import 'dart:convert' as convert;

import 'package:hackatumapp/services/data_format.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

// spoonacular
const apiBase = "api.spoonacular.com";
const apiKey = "d5c3362156be441f8ce223ad224857db";
const searchRoute = "/recipes/complexSearch";
const findByIngredientsRoute = "/recipes/findByIngredients";

// intl firebase functions
const internalApiBase = "192.168.178.24:5000";
const recipeCO2Route = "/recipe_co2_score";
const updateShoppingRoute = "/update_shopping_list";

class ExternalAPI {
  static Future<List<Recipe>> getSelectedRecipes(
      String q, List<Ingredient> existingIngredients) async {
    var includeIngredients =
        existingIngredients.map((ingredient) => ingredient.name).join(",");

    final queryParameters = {
      "apiKey": apiKey,
      "fillIngredients": "true",
      "sort": "max-used-ingredients",
      "includeIngredients": includeIngredients,
      "instructionsRequired": "true",
      "addRecipeNutrition": "true",
      "addRecipeInformation": "true",
      "number": "10",
      "query": q
    };
    final uri = Uri.https(apiBase, searchRoute, queryParameters);
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
      List recipeObjsRaw = jsonResponse["results"];

      return _processRecipe(recipeObjsRaw, false);
    } else {
      print('Request failed with status: ${res.statusCode}.');
    }
  }

  static Future<List<Recipe>> getCookableRecipes(
      List<Ingredient> existingIngredients) async {
    var includeIngredients =
        existingIngredients.map((ingredient) => ingredient.name).join(",");

    final queryParameters = {
      "apiKey": apiKey,
      "includeIngredients": includeIngredients,
      "number": "10",
      "fillIngredients": "true",
      "instructionsRequired": "true",
      "addRecipeNutrition": "true",
      "addRecipeInformation": "true",
      "sort": "max-used-ingredients",
      "query": ""
    };

    final uri = Uri.https(apiBase, searchRoute, queryParameters);
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
      print(res.body);

      return _processRecipe(jsonResponse["results"], false);
    } else {
      print('Request failed with status: ${res.statusCode}.');
      return null;
    }
  }

  // util
  static List<Recipe> _processRecipe(List recipeObjsRaw, bool amountIsInt) {
    List<Recipe> recipeObjsProcessed = [];
    for (var recipe in recipeObjsRaw) {
      // used ingredients
      List<Ingredient> usedIngredients = [];
      for (var ingredient in recipe["usedIngredients"]) {
        usedIngredients.add(new Ingredient(
          id: ingredient["id"],
          amount:
              amountIsInt ? ingredient["amount"] : ingredient["amount"].round(),
          unit: ingredient["unit"],
          aisle: ingredient["aisle"],
          name: ingredient["name"],
          image: ingredient["image"],
          meta: ingredient["meta"].cast<String>(),
        ));
      }

      // missed ingredients
      List<Ingredient> missedIngredients = [];
      for (var ingredient in recipe["missedIngredients"]) {
        missedIngredients.add(new Ingredient(
          id: ingredient["id"],
          amount:
              amountIsInt ? ingredient["amount"] : ingredient["amount"].round(),
          unit: ingredient["unit"],
          aisle: ingredient["aisle"],
          name: ingredient["name"],
          image: ingredient["image"],
          meta: ingredient["meta"].cast<String>(),
        ));
      }

      recipeObjsProcessed.add(new Recipe(
        id: recipe["id"],
        title: recipe["title"],
        image: recipe["image"],
        healthScore: recipe["healthScore"],
        pricePerServing: recipe["pricePerServing"],
        vegetarian: recipe["vegetarian"],
        vegan: recipe["vegan"],
        veryHealthy: recipe["veryHealthy"],
        veryPopular: recipe["veryPopular"],
        glutenFree: recipe["glutenFree"],
        dairyFree: recipe["dairyFree"],
        cheap: recipe["cheap"],
        sustainable: recipe["sustainable"],
        usedIngredients: usedIngredients,
        usedIngredientCount: usedIngredients.length,
        missedIngredients: missedIngredients,
        missedIngredientCount: missedIngredients.length,
      ));
    }

    return recipeObjsProcessed;
  }

  static Future<List> getInstructionsById(int recipeId) async {
    final queryParameters = {"apiKey": apiKey, "stepBreakdown": "false"};
    final uri = Uri.https(
        apiBase, "/recipes/${recipeId}/analyzedInstructions", queryParameters);
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(res.body) as List<dynamic>;
      List<dynamic> steps = jsonResponse[0]["steps"];
      print("body == ${res.body}");
      for (var step in steps) {
        print(step);
      }
    }
  }
}

class InternalAPI {
  static Future<String> getRecipeCO2Score(Recipe recipe) async {
    var ingredients = [...recipe.missedIngredients, ...recipe.usedIngredients];

    final uri = Uri.http(internalApiBase, recipeCO2Route);
    final res = await http
        .post(uri, body: {"ingredients": convert.jsonEncode(ingredients)});
    if (res.statusCode == 200) {
      //var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
      return res.body; //jsonResponse["results"];
    } else {
      print('Request failed with status: ${res.statusCode}.');
      return null;
    }
  }

  static Future<bool> updateShoppingList(String uid) async {
    var query = {"user_id": uid};

    final uri = Uri.http(internalApiBase, updateShoppingRoute, query);
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      return true;
    } else {
      print('Request failed with status: ${res.statusCode}.');
      return false;
    }
  }
}
