from flask import Flask, request, jsonify
import requests
from werkzeug.utils import secure_filename
import os

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

'''
    :returns array of products 
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
        if i == 1:
            break
        line_elements = line.split(' ')
        line_len = len(line_elements)
        if line_len > 2:
            name = ' '.join(line_elements[0:line_len-2])

            for index, char in enumerate(name):
                if char in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']:
                    name = name[0:index]

            price = line_elements[-2]
            products.append(name)

        i += 1
        if i >= 3:
            break
    return products


app.run(host='0.0.0.0')