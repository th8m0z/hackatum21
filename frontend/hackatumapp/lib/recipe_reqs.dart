import 'dart:convert' as convert;
import 'dart:io';

import 'package:hackatumapp/services/data_format.dart';
import 'package:http/http.dart' as http;

// spoonacular
const apiBase = "api.spoonacular.com";
const apiKey = "d5c3362156be441f8ce223ad224857db";
const searchRoute = "/recipes/complexSearch";
const findByIngredientsRoute = "/recipes/findByIngredients";

// intl firebase functions
const internalApiBase = "192.168.178.24:5000";
const recipeCO2Route = "/recipe_co2_score";

// util
List<Recipe> processRecipe(List recipeObjsRaw, bool amountIsInt) {
  List<Recipe> recipeObjsProcessed = [];
  for (var recipe in recipeObjsRaw) {
    // used ingredients
    List<Ingredient> usedIngredients = [];
    for (var ingredient in recipe["usedIngredients"]) {
      usedIngredients.add(new Ingredient(
        id: ingredient["id"],
        amount: amountIsInt ? ingredient["amount"] : ingredient["amount"].round(),
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
        amount: amountIsInt ? ingredient["amount"] : ingredient["amount"].round(),
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
      imageType: recipe["imageType"],
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

// external requests
Future<List> getSelectedRecipes(String q, List<Ingredient> existingIngredients) async {
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

    return processRecipe(recipeObjsRaw, true);
  } else {
    print('Request failed with status: ${res.statusCode}.');
  }
}

Future<List> getCookableRecipes(List<Ingredient> existingIngredients) async {
  var includeIngredients =
      existingIngredients.map((ingredient) => ingredient.name).join(",");

  final queryParameters = {
    "apiKey": apiKey,
    "ingredients": includeIngredients,
    "number": "10",
    "instructionsRequired": "true",
    "addRecipeNutrition": "true",
    "addRecipeInformation": "true",
    "ranking": "1"
  };

  final uri = Uri.https(apiBase, findByIngredientsRoute, queryParameters);
  final res = await http.get(uri);
  if (res.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(res.body) as List<dynamic>;

    return processRecipe(jsonResponse, false);
  } else {
    print('Request failed with status: ${res.statusCode}.');
  }
}

// internal reqs
Future<String> getRecipeCO2Score(Recipe recipe) async {
  final uri = Uri.https(apiBase, searchRoute);
  final res = await http.get(uri);
  if (res.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
    return jsonResponse["results"];
  } else {
    print('Request failed with status: ${res.statusCode}.');
  }
}

void main() async {
  getCookableRecipes(null);
}