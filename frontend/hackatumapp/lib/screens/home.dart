import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackatumapp/screens/intro_screen.dart';
import 'package:hackatumapp/screens/recipe_list_screen.dart';
import 'package:hackatumapp/screens/shopping_list.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/services/image_store.dart';
import 'package:hackatumapp/services/upload_service.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:hackatumapp/views/ingredient_list_view.dart';
import 'package:hackatumapp/views/recipe_view.dart';
import 'package:hackatumapp/widgets/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:hackatumapp/services/recipe_reqs.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController pageController = PageController();
  int selectedTab = 0;

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
            EdgeInsets.only(left: Sc.h * 5, right: Sc.h * 5, top: Sc.v * 18),
        // color: Colors.red,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            // onTap: () {
                            //   List<Recipe> recipes = Provider.of<List<Recipe>>(
                            //       context,
                            //       listen: false);
                            //   List<Ingredient> missedIngredients = [];
                            //   recipes.forEach(
                            //     (r) {
                            //       missedIngredients.addAll(r.missedIngredients);
                            //     },
                            //   );
                            //   print(
                            //       "missedIngredients == ${missedIngredients.length}");
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => ShoppingList(
                            //           ingredients: missedIngredients,
                            //         ),
                            //       ));
                            // },
                            child: Text(
                              "Hey John! 🍎",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          // SizedBox(
                          //   height: Sc.v * 3,
                          // ),
                          // Container(
                          //   width: Sc.h * 65,
                          //   child: Wrap(
                          //     spacing: Sc.h * 2,
                          //     runSpacing: Sc.v * 1.5,
                          //     children: [
                          //       Tag(
                          //         textColor: Colors.green[900],
                          //         color: Theme.of(context).primaryColor,
                          //         text: "Vegan",
                          //       ),
                          //       Tag(
                          //           textColor: Colors.orange[700],
                          //           color: Color(0xFFfcd670),
                          //           text: "Gluten-Free"),
                          //       Tag(
                          //         text: "Sustainable",
                          //         textColor: Colors.brown[900],
                          //         color: Theme.of(context)
                          //             .highlightColor
                          //             .withOpacity(0.8),
                          //       ),
                          //     ],
                          //   ),
                          // )
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
                            XFile file = await _picker.pickImage(
                                source: ImageSource.gallery);
                            String uid = "C6OvTqu5Ui4wFOjqmGRw";
                            if (file != null) {
                              await DioUploadService.uploadPhotos(
                                file.path,
                                uid,
                              );
                            }

                            print("done");
                          } on PlatformException catch (e) {
                            print("error while picking file");
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Sc.v * 10),
                AutoSizeText(
                  "Your Food",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: Sc.v * 3),
                CupertinoSlidingSegmentedControl(
                  groupValue: selectedTab,
                  backgroundColor: Colors.black.withOpacity(0.05),
                  thumbColor: Colors.white,
                  children: {
                    0: Text(
                      "Ingredients",
                      style: Theme.of(context).textTheme.caption.copyWith(
                          fontWeight: FontWeight.w600, fontSize: Sc.h * 3.4),
                    ),
                    1: Text(
                      "Photo",
                      style: Theme.of(context).textTheme.caption.copyWith(
                          fontWeight: FontWeight.w600, fontSize: Sc.h * 3.4),
                    ),
                  },
                  onValueChanged: (input) {
                    setState(() {
                      selectedTab = input;
                    });
                    pageController.animateToPage(input,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn);
                  },
                ),
                SizedBox(height: Sc.v * 3),
                Container(
                  height: Sc.h * 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.black.withOpacity(0.035),
                  ),
                  child: PageView(
                    controller: pageController,
                    // physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (int page) {
                      setState(() {
                        selectedTab = page;
                      });
                    },
                    children: [
                      Container(
                        child: IngredientView(
                          ingredients: allIngredients,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: StaticStore.image != null
                                ? StaticStore.image
                                : NetworkImage(
                                    "https://cdn.pixabay.com/photo/2016/08/25/15/00/refrigerator-1619676_1280.jpg",
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Sc.v * 8),
                AutoSizeText(
                  "${cookingList.length} Recipes",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: Sc.v * 3,
                ),
                Align(
                  alignment: Alignment(0, 0.6),
                  child: Container(
                    height: Sc.v * 40,
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
                SizedBox(height: Sc.v * 5),
              ],
            ),
            Align(
              alignment: Alignment(0, 0.925),
              child: Button(
                opacityOnly: true,
                onTap: () async {
                  UserModel userModel =
                      Provider.of<UserModel>(context, listen: false);
                  print("allIngredients == $allIngredients");
                  for (int i = 0; i < allIngredients.length; i++) {
                    print(allIngredients[i].name);
                  }
                  List<Recipe> cookableRecipes =
                      await ExternalAPI.getCookableRecipes(
                          allIngredients, userModel);
                  for (int i = 0; i < cookableRecipes.length; i++) {
                    int co2Score = await InternalAPI.getRecipeCO2Score(
                      cookableRecipes[i],
                    );
                    cookableRecipes[i].co2Score = co2Score;
                    print("instructions == $co2Score");
                  }

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
