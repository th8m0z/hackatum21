class Ingredient {
  final int id;
  final int amount;
  final String unit;
  final String aisle;
  final String name;
  final String originalString;
  final String originalName;
  final String image;
  final List<dynamic> meta;

  Ingredient(
      {this.id,
      this.amount,
      this.unit,
      this.aisle,
      this.name,
      this.originalName,
      this.originalString,
      this.image,
      this.meta});

  factory Ingredient.fromMap(Map<String, dynamic> data) {
    return Ingredient(
        id: data["id"],
        amount: data["amount"],
        unit: data["unit"],
        aisle: data["aisle"],
        name: data["name"],
        originalName: data["originalName"],
        originalString: data["originalString"],
        image: data["image"],
        meta: data["meta"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amount": amount,
      "unit": unit,
      "aisle": aisle,
      "name": name,
      "originalName": originalName,
      "originalString": originalString,
      "image": image,
      "meta": meta,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "amount": amount,
      "unit": unit,
      "aisle": aisle,
      "name": name,
      "originalName": originalName,
      "originalString": originalString,
      "image": image,
      "meta": meta,
    };
  }
}

class Recipe {
  final int usedIngredientCount;
  final int missedIngredientCount;
  final List<Ingredient> missedIngredients;
  final List<Ingredient> usedIngredients;
  final int id;
  final String title;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final bool dairyFree;
  final bool veryHealthy;
  final bool cheap;
  final bool veryPopular;
  final bool sustainable;

  final double healthScore;
  final double pricePerServing;
  final String image;

  Recipe(
      {this.usedIngredientCount,
      this.missedIngredientCount,
      this.usedIngredients,
      this.missedIngredients,
      this.id,
      this.cheap,
      this.dairyFree,
      this.image,
      this.glutenFree,
      this.healthScore,
      this.pricePerServing,
      this.sustainable,
      this.title,
      this.vegan,
      this.vegetarian,
      this.veryHealthy,
      this.veryPopular});

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> usedIngredientsMap = [];
    for (int i = 0; i < usedIngredients.length; i++) {
      usedIngredientsMap.add(usedIngredients[i].toMap());
    }

    List<Map<String, dynamic>> missedIngredientsMap = [];
    for (int i = 0; i < missedIngredients.length; i++) {
      usedIngredientsMap.add(missedIngredients[i].toMap());
    }
    return {
      "id": id,
      "title": title,
      "image": image,
      "healthScore": healthScore,
      "pricePerServing": pricePerServing,
      "vegetarian": vegetarian,
      "vegan": vegan,
      "veryHealthy": veryHealthy,
      "veryPopular": veryPopular,
      "glutenFree": glutenFree,
      "dairyFree": dairyFree,
      "cheap": cheap,
      "sustainable": sustainable,
      "usedIngredients": usedIngredientsMap,
      "usedIngredientsCount": usedIngredientCount,
      "missedIngredients": missedIngredientsMap,
      "missedIngredientsCount": missedIngredientCount
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> data) {
    List<Ingredient> usedIngredientsTemp = [];

    if (data["usedIngredients"] != null) {
      for (int i = 0; i < data["usedIngredients"].length; i++) {
        usedIngredientsTemp.add(
          Ingredient.fromMap(
            data["usedIngredients"][i],
          ),
        );
      }
    }
    List<Ingredient> missedIngredientsTemp = [];
    if (data["missedIngredients"] != null) {
      for (int i = 0; i < data["missedIngredients"].length; i++) {
        usedIngredientsTemp.add(
          Ingredient.fromMap(
            data["missedIngredients"][i],
          ),
        );
      }
    }

    return Recipe(
        cheap: data["cheap"],
        glutenFree: data["glutenFree"],
        dairyFree: data["dairyFree"],
        image: data["image"],
        title: data["title"],
        vegan: data["vegan"],
        vegetarian: data["vegetarian"],
        veryHealthy: data["veryHealthy"],
        veryPopular: data["veryPopular"],
        sustainable: data["sustainable"],
        pricePerServing: data["pricePerServing"],
        healthScore: data["healthScore"],
        id: data["id"],
        usedIngredients: usedIngredientsTemp,
        missedIngredients: missedIngredientsTemp,
        missedIngredientCount: data["missedIngredientsCount"],
        usedIngredientCount: data["usedIngredientsCount"]);
  }
}

class UserModel {
  final String name;
  final bool vegan;
  final bool vegetarian;
  final bool sustainable;
  final bool glutenFree;
  final String uid;

  UserModel(
      {this.name,
      this.vegan,
      this.vegetarian,
      this.glutenFree,
      this.uid,
      this.sustainable});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data["name"],
      vegan: data["vegan"],
      vegetarian: data["vegetarian"],
      glutenFree: data["glutenFree"],
      uid: data["uid"],
      sustainable: data["sustainable"],
    );
  }

  toMap() {
    return {
      "name": name,
      "vegan": vegan,
      "vegetarian": vegetarian,
      "glutenFree": glutenFree,
      "uid": uid,
      "sustainable": sustainable,
    };
  }
}
