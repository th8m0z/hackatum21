import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/services/database.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:hackatumapp/widgets/button.dart';
import 'package:hackatumapp/widgets/tag.dart';

class RecipeTile extends StatelessWidget {
  RecipeTile({Key key, this.recipe, this.color}) : super(key: key);
  final Recipe recipe;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Button(
      onTap: () async {
        await Database.addToShoppingList("C6OvTqu5Ui4wFOjqmGRw", recipe);
        Navigator.pop(context);
      },
      opacityOnly: true,
      gestureOnly: true,
      hasBoxshadow: true,
      child: Container(
        // padding: EdgeInsets.symmetric(left: Sc.h * 2),
        margin:
            EdgeInsets.only(bottom: Sc.v * 5, left: Sc.h * 2, right: Sc.h * 3),
        height: Sc.h * 40,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: Sc.h * 2.5,
              spreadRadius: Sc.h * 0.1,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: Sc.h * 6, horizontal: Sc.h * 5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: Sc.h * 2,
                        blurRadius: Sc.h * 5,
                        color: Theme.of(context).primaryColor.withOpacity(0.1)),
                  ],
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
            Container(
              width: Sc.h * 43,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Sc.v * 5,
                  ),
                  AutoSizeText(
                    recipe.title,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  AutoSizeText(
                    "${recipe.missedIngredientCount} missing ingredients",
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500,
                      fontSize: Sc.h * 3.5,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  SizedBox(
                    height: Sc.v * 2,
                  ),
                  Row(
                    children: [
                      /*Tag(
                        hasBoxShadow: false,
                        color: Colors.red,
                        text: recipe.healthScore.toString(),
                      ), removed due to bloat */
                      Tag(
                        hasBoxShadow: false,
                        color: Colors.green[900],
                        text: "CO2 Score: " + recipe.co2Score.toString(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: Sc.h * 3,
            ),
            Container(
              width: Sc.h * 12,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Theme.of(context).primaryColor.withOpacity(0.8),
              ),
              child: Icon(
                Icons.add,
                color: Colors.green[900],
                size: Sc.h * 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
