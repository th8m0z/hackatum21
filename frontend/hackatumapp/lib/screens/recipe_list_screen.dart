import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:hackatumapp/widgets/recipe_tile.dart';
import 'package:hackatumapp/widgets/tag.dart';
import 'package:provider/provider.dart';

class RecipeListScreen extends StatefulWidget {
  RecipeListScreen({
    Key key,
    @required this.recipes,
    this.colors,
  }) : super(key: key);
  final List<Recipe> recipes;
  final List<Color> colors;
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    widget.recipes
        .sort((r1, r2) => r1.missedIngredientCount - r2.missedIngredientCount);
    Sc().init(context);

    List<Widget> tiles = [];

    for (int i = 0; i < widget.recipes.length; i++) {
      tiles.add(
        RecipeTile(
          color: Colors.white,
          recipe: widget.recipes[i],
        ),
      );
    }
    List<Tag> tags = [];
    if (user.glutenFree == true) {
      tags.add(Tag(
          textColor: Colors.orange[700],
          color: Color(0xFFfcd670),
          text: "Gluten-Free"));
    }
    if (user.vegetarian == true) {
      tags.add(
        Tag(
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).primaryColorDark,
            text: "Vegetarian"),
      );
    }
    if (user.sustainable == true) {
      tags.add(Tag(
        text: "Sustainable",
        textColor: Colors.brown[900],
        color: Theme.of(context).highlightColor.withOpacity(0.8),
      ));
    }
    tiles.insert(
        0,
        Container(
          padding: EdgeInsets.only(left: Sc.h * 3, bottom: Sc.h * 6),
          child: Wrap(
              alignment: WrapAlignment.start,
              spacing: Sc.h * 3.5,
              runSpacing: Sc.v * 1.5,
              children: tags),
        ));
    tiles.insert(
      0,
      Container(
        margin: EdgeInsets.only(bottom: Sc.v * 3, left: Sc.h * 3),
        child: AutoSizeText(
          "Curated for you ✨",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: ListView(padding: EdgeInsets.only(top: 80), children: tiles),
      ),
    );
  }
}
