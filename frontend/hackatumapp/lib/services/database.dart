import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackatumapp/services/data_format.dart';

class Database {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Stream<List<Ingredient>> ingredientStream(String uid) {
    return _db
        .collection("users")
        .doc(uid)
        .collection("ingredients")
        .snapshots()
        .asBroadcastStream()
        .map(
      (snapshot) {
        if (snapshot == null) {
          print("snap is null! no ingredients returned");
          return [];
        } else {
          print("snapshot == ${snapshot.docs}");
          return snapshot.docs.map(
            (DocumentSnapshot doc) {
              Map<String, dynamic> data = doc.data();
              return Ingredient.fromMap(data);
            },
          ).toList();
        }
      },
    );
  }

  static Future<void> updateUser(
      String uid, Map<String, dynamic> newData) async {
    await _db.collection("users").doc(uid).update(newData);
  }

  static Future<bool> addToShoppingList(String uid, Recipe recipe) {
    return _db
        .collection("users")
        .doc(uid)
        .collection("recipes")
        .add(recipe.toMap())
        .then((value) => true)
        .catchError((error) {
      print("Failed to add to shopping list: $error");
      return false;
    });
  }

  static Stream<UserModel> userModel(String uid) {
    return _db.collection("users").doc(uid).snapshots().asBroadcastStream().map(
          (event) => UserModel.fromMap(
            event.data(),
          ),
        );
  }

  static Stream<List<Recipe>> cookingList(String uid) {
    return _db
        .collection("users")
        .doc(uid)
        .collection("recipes")
        .snapshots()
        .asBroadcastStream()
        .map((snap) {
      if (snap == null) {
        print("snap is null!");
        return null;
      } else {
        return snap.docs.map(
          (e) {
            Map<String, dynamic> data = e.data();
            return Recipe.fromMap(data);
          },
        ).toList();
      }
    });
  }
}
