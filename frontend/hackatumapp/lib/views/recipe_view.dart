import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hackatumapp/screens/cooking_screen.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/widgets/button.dart';

class RecipeView extends StatelessWidget {
  RecipeView({Key key, Recipe this.recipe}) : super(key: key);
  final Recipe recipe;
  @override
  Widget build(BuildContext context) {
    return Button(
      gestureOnly: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CookingScreen(
              recipe: recipe,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      AutoSizeText(
                        recipe != null ? recipe.title : "Gebratener Lachs",
                        minFontSize: 10,
                        maxFontSize: 20,
                        style: Theme.of(context).textTheme.caption,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 8,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 145,
                    width: 145,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          recipe != null
                              ? recipe.image
                              : "https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_960_720.jpg",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
