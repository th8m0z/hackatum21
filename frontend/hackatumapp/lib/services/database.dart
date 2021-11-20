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

  static Future<bool> addToShoppingList(String uid, Recipe recipe)  {
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
}
