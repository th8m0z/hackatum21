from flask import Flask, request, jsonify
import requests
from werkzeug.utils import secure_filename
import os
from collections import  defaultdict
import re

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("hackatum-d9e2e-firebase-adminsdk-sbcmr-3a9e9ed96b.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

from fooddata import get_products

import cv2
import pytesseract

app = Flask(__name__)
app.config["DEBUG"] = True
from pathlib import Path
Path("./receipts").mkdir(parents=True, exist_ok=True)


@app.route('/', methods=['GET'])
def home():
    return "running!"

def add_products_to_fridge(products, user_id):
    for p in products:
        if p is not None:
            print(p)
            db.collection('users').document(user_id).collection('ingredients').document(str(p["id"])).set(p)


@app.route('/upload_receipt', methods=['POST'])
def upload_receipt():
    user_id = request.args.get('user_id')
    file = request.files['']
    if file :
        filename = secure_filename(file.filename)
        filepath = os.path.join("./receipts", filename)
        file.save(filepath)

        products = process_receipt(filepath)
        processed_products = (get_products(products))
        add_products_to_fridge(processed_products, user_id)

        return jsonify({"accepted": True, "products_processes": processed_products, "products": products})

example_product = ("Paprika Mix REWE", 1.69)

@app.route('/update_shopping_list', methods=['POST'])
def update_shopping_list():
    user_id = request.args.get('user_id')
    recipes = db.collection(u'users').document(u'C6OvTqu5Ui4wFOjqmGRw').collection(u'recipes').stream()
    ingredients = db.collection(u'users').document(u'C6OvTqu5Ui4wFOjqmGRw').collection(u'ingredients').stream()
    shopping_list = db.collection(u'users').document(u'C6OvTqu5Ui4wFOjqmGRw').collection(u'shopping_list').stream()

    all_recipe_ingredients = defaultdict(int)
    info_for_id = {}
    for recipe in recipes:
        recipe_dict = recipe.to_dict()
        recipe_ingredients = recipe_dict.get('usedIngredients', [])
        for ingredient in recipe_ingredients:
            ingredient_id = ingredient.get('id', 0)
            ingredient_name = ingredient.get('name', '')
            ingredient_pic = ingredient.get('image', '')
            all_recipe_ingredients[ingredient_id] += 1
            info_for_id[ingredient_id] = (ingredient_name, ingredient_pic)

    for ingredient in ingredients:
        ingredient_dict = ingredient.to_dict()
        ingredient_id = ingredient_dict.get('id', -1)
        ingredient_amount = ingredient_dict.get('amount', 0)
        all_recipe_ingredients[ingredient_id] -= ingredient_amount

    update_dict = {k:v for k, v in all_recipe_ingredients.items() if v >= 0}

    ids_to_delete = []
    for element in shopping_list:
        id = element.to_dict().get('id', -1)
        if id not in update_dict.keys():
            ids_to_delete.append(element.id)
    
    upload_data = []
    for k, v in update_dict.items():
        upload_data.append({
            "amount":v,
            "id": k,
            "name": info_for_id[k][0],
            "image": info_for_id[k][1]
        })
    
    for element in ids_to_delete:
        db.collection(u'users').document(u'C6OvTqu5Ui4wFOjqmGRw').collection(u'shopping_list').document(element).delete()
    
    for element in upload_data:
        db.collection(u'users').document(u'C6OvTqu5Ui4wFOjqmGRw').collection(u'shopping_list').add(element)

# json array {ingredients: []}
category_co2_scores = {
    "Meat": 5,
    "Cheese": 3,
    "Milk, Eggs, Other Dairy": 1.5,
    "Sweet Snacks": 2,
    "Pasta and Rice": 0.6
}

"""
    accepts {ingredients: [{aisle: string, ...}]} body
    returns {score: 1-10} or {score: null} if no sufficient information
"""
@app.route('/recipe_co2_score', methods=['POST'])
def get_co2_score():
    ingredients = request.get_json(force=True)["ingredients"]
    score = 10
    ingredients_rated = 0

    for ingredient in ingredients:
        if "aisle" in ingredient:
            ingredients_rated += 1
            if ingredient["aisle"] in category_co2_scores:
                score = score - category_co2_scores[ingredient["aisle"]]

    if ingredients_rated > len(ingredients)/5:
        return jsonify({"score": max(score, 0)})
    else:
        return jsonify({"score": None})

'''
    :returns array of {product, amount} 
    example /process_receipt?user_id=9138h4n8jms
'''
def process_receipt(filepath):
    img = cv2.imread(filepath)
    custom_config = r'--oem 3 --psm 6'
    text = pytesseract.image_to_string(img, config=custom_config)

    lines = text.splitlines()

    products = []

    i = 0
    for line in lines:
        # if i == 1:
        #     break

        try:
            weight = re.findall("(\d+)g",  line)[0]
        except IndexError:
            weight = None
        line_elements = line.split(' ')
        line_len = len(line_elements)
        if line_len > 2:
            name = ' '.join(line_elements[0:line_len-2])

            for index, char in enumerate(name):
                if char in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']:
                    name = name[0:index]

            product = {"name": name}
            if weight is not None:
                product["amount"] = weight
                product["units"] = "g"
            products.append(product)
        #
        # i += 1
        # if i >= 3:
        #     break
    return products


app.run(host='0.0.0.0')