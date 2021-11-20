import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackatumapp/screens/recipe_list_screen.dart';
import 'package:hackatumapp/services/data_format.dart';

import 'package:hackatumapp/services/upload_service.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:hackatumapp/views/fridge.dart';
import 'package:hackatumapp/views/recipe_view.dart';
import 'package:hackatumapp/widgets/button.dart';
import 'package:hackatumapp/widgets/tag.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:hackatumapp/services/recipe_reqs.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Sc().init(context);

    List<Ingredient> allIngredients = Provider.of<List<Ingredient>>(context);
    List<Recipe> cookingList = Provider.of<List<Recipe>>(context);

    List<RecipeView> recipeViews = cookingList.map(
      (item) {
        return RecipeView(
          recipe: item,
        );
      },
    ).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding:
            EdgeInsets.only(left: Sc.h * 5, right: Sc.h * 5, top: Sc.v * 15),
        // color: Colors.red,
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Hey John!",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: Sc.v * 3,
                      ),
                      Container(
                        width: Sc.h * 65,
                        child: Wrap(
                          spacing: Sc.h * 2,
                          runSpacing: Sc.v * 1.5,
                          children: [
                            Tag(
                              textColor: Colors.green[900],
                              color: Theme.of(context).primaryColor,
                              text: "Vegan",
                            ),
                            Tag(
                                textColor: Colors.orange[700],
                                color: Color(0xFFfcd670),
                                text: "Gluten-Free"),
                            Tag(
                              text: "Sustainable",
                              textColor: Colors.brown[900],
                              color: Theme.of(context)
                                  .highlightColor
                                  .withOpacity(0.8),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Button(
                    hasBoxshadow: true,
                    opacityOnly: true,
                    borderRadius: 100,
                    color: Theme.of(context).primaryColor,
                    child: Icon(Icons.add),
                    height: Sc.h * 14,
                    width: Sc.h * 14,
                    onTap: () async {
                      try {
                        final ImagePicker _picker = ImagePicker();
                        XFile image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        String uid = "C6OvTqu5Ui4wFOjqmGRw";
                        if (image != null) {
                          await DioUploadService.uploadPhotos(
                            image.path,
                            uid,
                          );
                        }
                      } on PlatformException catch (e) {
                        print("error while picking file");
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: Sc.v * 6),
            Container(
              height: Sc.h * 98,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: Colors.black.withOpacity(0.035),
              ),
              child: FridgeView(),
            ),
            Align(
              alignment: Alignment(0, 0.6),
              child: Container(
                height: Sc.v * 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: Sc.h * 2.5,
                      spreadRadius: Sc.h * 0.1,
                      color: Colors.black.withOpacity(0.1),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: PageView(
                  children: recipeViews,
                ),
              ),
            ),
            SizedBox(height: Sc.v * 8),
            Align(
              alignment: Alignment(0, 0.92),
              child: Button(
                opacityOnly: true,
                onTap: () async {
                  print("allIngredients == $allIngredients");
                  for (int i = 0; i < allIngredients.length; i++) {
                    print(allIngredients[i].name);
                  }
                  List<Recipe> cookableRecipes =
                      await ExternalAPI.getCookableRecipes(allIngredients);
                  // for (int i = 0; i < cookableRecipes.length; i++) {
                  //   List instructions = await ExternalAPI.getInstructionsById(
                  //       cookableRecipes[i].id);
                  //   print("instructions == $instructions");
                  // }

                  // List<Color> colors = [];
                  // for (int i = 0; i < cookableRecipes.length; i++) {
                  //   List<int> rgbColors =
                  //       await getColorFromUrl(cookableRecipes[i].image);
                  //   print("rgbColor == ${rgbColors.runtimeType}");
                  //   colors.add(
                  //     Color.fromARGB(
                  //         255, rgbColors[0], rgbColors[1], rgbColors[2]),
                  //   );
                  // }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeListScreen(
                        recipes: cookableRecipes,
                      ),
                    ),
                  );
                  // String co2Score = await getRecipeCO2Score(cookableRecipes[0]);
                  // print("co2 score == $co2Score");
                },
                child: Text(
                  "GET CURATED RECIPES",
                  style: Theme.of(context).textTheme.button,
                ),
                height: 58,
                width: double.infinity,
                borderRadius: 2000,
                hasBoxshadow: true,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
