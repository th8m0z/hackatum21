import 'dart:io';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

const apiBase = "api.spoonacular.com";
const apiKey = "d5c3362156be441f8ce223ad224857db";
const searchRoute = "/recipes/complexSearch";

Future<Map> getSelectedRecipes(String q, String includeIngredients) async {
  final queryParameters = {
    "apiKey": apiKey,
    "fillIngredients": "true",
    "sort": "max-used-ingredients",
    "includeIngredients": includeIngredients,
    "number": 10,
    "query": q
  };
  final uri = Uri.https(apiBase, searchRoute, queryParameters);
  final res = await http.get(uri);
  if (res.statusCode == 200) {
    var jsonResponse =
    convert.jsonDecode(res.body) as Map<String, dynamic>;
    print(jsonResponse);
    return jsonResponse;
  } else {
    print('Request failed with status: ${res.statusCode}.');
  }
}

Future<Map> getCookableRecipes() async {
  final queryParameters = {
    "apiKey": apiKey,
  };

  final uri = Uri.https(apiBase, searchRoute, queryParameters);
  final res = await http.get(uri);
  if (res.statusCode == 200) {
    var jsonResponse =
    convert.jsonDecode(res.body) as Map<String, dynamic>;
    print(jsonResponse);
    return jsonResponse;
  } else {
    print('Request failed with status: ${res.statusCode}.');
  }
}
