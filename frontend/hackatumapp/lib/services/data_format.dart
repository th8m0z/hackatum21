class Ingredient {
  final int id;
  final double amount;
  final String unit;
  final String aisle;
  final String name;
  final String originalString;
  final String originalName;
  final String image;
  final List<String> meta;

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
}

class Recipe {
  final int usedIngredientCount;
  final int missedIngredientCount;
  final List<Ingredient> missedIngredients;
  final List<Ingredient> usedIngredients;
  final int id;
  final String title;
  final String imageType;
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
      this.imageType,
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

  // factory Recipe.fromMap(Map<String, dynamic> data) {
  //   return Recipe(
  //     glutenFree: data["glutenFree"],
  //     dairyFree: data["dairyFree"],
  //     image: data["image"],
  //     title: data["title"],
  //     vegan: data["vegan"],
  //     vegetarian: data["vegetarian"],
  //     veryHealthy: data["veryHealthy"],
  //     veryPopular: data["veryPopular"],
  //     sustainable: data["sustainable"],
  //     pricePerServing: data["pricePerServing"],
  //     healthScore: data["healthScore"],
  //     id: data["id"],
  //     unusedIngredients:
  //   );
  // }

}
