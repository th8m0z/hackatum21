import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:hackatumapp/widgets/button.dart';

class RecipeTile extends StatelessWidget {
  RecipeTile({Key key, Recipe this.recipe}) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Button(
      gestureOnly: true,
      hasBoxshadow: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Sc.h * 2),
        margin: EdgeInsets.only(bottom: Sc.v * 4),
        height: Sc.h * 35,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColorLight.withOpacity(0.45),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(Sc.h * 1.75),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // boxShadow: [
                //   BoxShadow(
                //     color: Theme.of(context).primaryColor.withOpacity(0.5),
                //     blurRadius: 12.0,
                //     spreadRadius: 0,
                //   )
                // ],
                color: Theme.of(context).primaryColor.withOpacity(0.4),
              ),
              child: Icon(Icons.add, color: Colors.green[900]),
            ),
            SizedBox(
              width: Sc.h * 3,
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
                      color: Colors.black.withOpacity(0.4),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: Sc.h * 4, horizontal: Sc.h * 3),
              height: Sc.h * 26,
              width: Sc.h * 26,
              decoration: BoxDecoration(
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
            )
          ],
        ),
      ),
    );
  }
}
