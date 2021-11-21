import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:provider/provider.dart';

class IngredientView extends StatefulWidget {
  final List<Ingredient> ingredients;
  IngredientView({Key key, this.ingredients}) : super(key: key);

  @override
  _IngredientViewState createState() => _IngredientViewState();
}

class _IngredientViewState extends State<IngredientView> {
  @override
  Widget build(BuildContext context) {
    List<IngredientTile> ingredientTiles = widget.ingredients
        .map(
          (e) => IngredientTile(
            ingredient: e,
          ),
        )
        .toList();
    return Container(
      // height: Sc.v * 10,
      width: double.infinity,
      // decoration: BoxDecoration(
      //   color: Colors.red,
      //   boxShadow: [
      //     BoxShadow(
      //       blurRadius: Sc.h * 2.5,
      //       spreadRadius: Sc.h * 0.1,
      //       color: Colors.black.withOpacity(0.1),
      //     )
      //   ],
      // ),
      // padding:
      //     EdgeInsets.only(top: Sc.v * 5, left: Sc.h * 2.5, right: Sc.h * 2.5),
      child: ingredientTiles == null || ingredientTiles.isEmpty
          ? Center(
              child: Text(
                "No ingredients yet.",
                style: Theme.of(context).textTheme.caption,
              ),
            )
          : ListView(
              padding: EdgeInsets.zero,
              children: ingredientTiles,
            ),
    );
  }
}

class IngredientTile extends StatelessWidget {
  final Ingredient ingredient;
  const IngredientTile({
    this.ingredient,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("aisle == ${ingredient.aisle}");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sc.h * 3, vertical: Sc.h * 1),
      margin: EdgeInsets.only(bottom: Sc.h * 1),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      //   boxShadow: [
      //     BoxShadow(
      //       blurRadius: Sc.h * 2.5,
      //       spreadRadius: Sc.h * 0.1,
      //       color: Colors.black.withOpacity(0.1),
      //     )
      //   ],
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ingredient.name,
            style: GoogleFonts.nunito().copyWith(
                fontSize: Sc.h * 4.25,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          Text(determineCategory(ingredient.aisle),
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontSize: Sc.h * 8)),
        ],
      ),
    );
  }
}

String determineCategory(String aisle) {
  switch (aisle) {
    case "Baking":
      return "🥐";
      break;

    case "Spices and Seasoning":
      return "🧂";
      break;

    case "Cheese":
      return "🧀";
      break;

    case "Fruits":
      return "🍓";
      break;

    case "Pasta and rice":
      return "🍝";
      break;

    case "Bread":
      return "🍞";
      break;

    case "Beverages":
      return "🧃";
      break;

    case "Produce":
      return "🥗";
      break;

    case "Canned and Jarred":
      return "🥫";
      break;

    case "Milk, Eggs, Other Dairy":
      return "🥛";
      break;

    case "Meat":
      return "🥩";
      break;
    case "Sweet Snacks":
      return "🍭";
      break;

    case "Oil, Vinegar, Salad Dressing":
      return "🍳";
      break;
    default:
      return "🍎";
  }
}
