import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hackatumapp/widgets/recipe_tile.dart';

class RecipeListScreen extends StatefulWidget {
  RecipeListScreen({Key key}) : super(key: key);

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            AutoSizeText(
              "Curated for you",
              style: Theme.of(context).textTheme.headline1,
            ),
            ListView(
              padding: EdgeInsets.only(top: 20),
              children: [RecipeTile()],
            ),
          ],
        ),
      ),
    );
  }
}
