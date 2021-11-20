import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:hackatumapp/widgets/recipe_tile.dart';

class RecipeListScreen extends StatefulWidget {
  RecipeListScreen({Key key, @required this.recipes}) : super(key: key);
  final List<Recipe> recipes;
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  @override
  Widget build(BuildContext context) {
    widget.recipes
        .sort((r1, r2) => r1.missedIngredientCount - r2.missedIngredientCount);
    Sc().init(context);
    List<Widget> tiles = widget.recipes
        .map((recipe) => Container(
              child: RecipeTile(
                recipe: recipe,
              ),
            ))
        .toList()
        .cast<Widget>();
    tiles.insert(
      0,
      Container(
        margin: EdgeInsets.only(bottom: Sc.v * 5),
        child: AutoSizeText(
          "Curated for you",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(padding: EdgeInsets.only(top: 80), children: tiles),
      ),
    );
  }
}
