import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/services/database.dart';
import 'package:hackatumapp/services/upload_service.dart';
import 'package:hackatumapp/views/fridge.dart';
import 'package:hackatumapp/views/recipe_view.dart';
import 'package:hackatumapp/widgets/button.dart';
import 'package:hackatumapp/widgets/tag.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 22, right: 22, top: 40),
        // color: Colors.red,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 0.92),
              child: Button(
                onTap: () async {
                  Stream<List<Ingredient>> ingredientStream =
                      Database.ingredientStream("C6OvTqu5Ui4wFOjqmGRw");
                },
                child: Icon(
                  Icons.bolt_rounded,
                  size: 35,
                ),
                height: 58,
                width: 58,
                borderRadius: 2000,
                hasBoxshadow: true,
                color: Colors.greenAccent[400],
              ),
            ),
            Align(
              alignment: Alignment(0, -0.55),
              child: Container(
                height: 380,
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
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.035),
                ),
                child: RecipeView(),
              ),
            ),
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
                          style: Theme.of(context).textTheme.headline1,
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
                      color: Theme.of(context).primaryColorLight,
                      child: Icon(Icons.add),
                      height: 50,
                      width: 50,
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
          ],
        ),
      ),
    );
  }
}
