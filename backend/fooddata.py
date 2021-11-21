
# import pprint
import requests
import json
# queries = [("PAPRIKA MIX REWE", '1,69'), ("CHAKALAKA", '0,85'), ("SPAGHETTI NO. 5", '1,69'), ("JA! BASMATI REIS", "1,99")]

# search_result = openfoodfacts.products.search(queries[3][0])
# pprint.pp(search_result)

spoonApiKey = "3b57d5f1d6004b9daad1f52b856d9a7b"

food_names = set(json.load(open("./foodlist.json")))
def get_product(name):
    search_result = requests.get("https://api.spoonacular.com/food/ingredients/search?query={}&apiKey={}&metaInformation=true".format(name, spoonApiKey)).json()

    try:
        if search_result["totalResults"] == 0:
            return

        # cur approach: take first by default
        first = search_result["results"][0]


        return {
            "amount": 1,
            "id": first['id'],
            "name": first['name'],
            "unit": "",
            "aisle": first["aisle"],
        }
    except KeyError:
        return None



def get_products(products):
    res = []
    for product in products:
        query = product["name"]
        found_product = get_product(query)
        if found_product is None:
            for word in query.split(' '):
                if word in food_names:
                    found_product = get_product(word)
                    if found_product is not None:
                        break
                elif len(word) > 3:
                    found_product = get_product(word)
                    if found_product is not None:
                        break

        if "unit" in product and product["unit"] is not None:
            found_product["unit"] = product["unit"]
            found_product["amount"] = product["amount"]

        res.append(found_product)
    return res
