import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackatumapp/screens/recipe_list_screen.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/services/database.dart';
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

    List<RecipeView> recipeViews = cookingList.map((item) {
      return RecipeView(
        recipe: item,
      );
    }).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 22, right: 22, top: 40),
        // color: Colors.red,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, -0.975),
              child: Container(
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
                          height: 5,
                        ),
                        Container(
                          width: 190,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Tag(
                                color: Theme.of(context).primaryColor,
                                text: "Vegan",
                              ),
                              Tag(
                                  text: "Protein",
                                  color: Theme.of(context).highlightColor),
                              Tag(
                                text: "Sustainable",
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
                        final ImagePicker _picker = ImagePicker();
                        XFile image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        String uid = "C6OvTqu5Ui4wFOjqmGRw";
                        await DioUploadService.uploadPhotos(
                          image.path,
                          uid,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.55),
              child: Container(
                height: Sc.h * 98,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.035),
                ),
                child: FridgeView(),
              ),
            ),
            Align(
              alignment: Alignment(0, 0.6),
              child: Container(
                height: Sc.v * 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.035),
                ),
                child: PageView(
                  children: recipeViews,
                ),
              ),
            ),
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
                  List instructions = await ExternalAPI.getInstructionsById(
                      cookableRecipes[0].id);
                  print("instructions == $instructions");
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
