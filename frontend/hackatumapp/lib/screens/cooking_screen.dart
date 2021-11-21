import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:hackatumapp/views/ingredient_list_view.dart';
import 'package:hackatumapp/widgets/instruction_widget.dart';
import 'package:provider/provider.dart';

class CookingScreen extends StatefulWidget {
  CookingScreen({
    Key key,
    this.recipe,
    this.instructions,
  }) : super(key: key);
  final Recipe recipe;
  final List<InstructionStep> instructions;
  @override
  _CookingScreenState createState() => _CookingScreenState();
}

class _CookingScreenState extends State<CookingScreen> {
  @override
  Widget build(BuildContext context) {
    List<Ingredient> ingredients = Provider.of<List<Ingredient>>(context);
    List<Widget> instructionWidgets = [];
    for (int i = 0; i < widget.instructions.length; i++) {
      instructionWidgets.add(
        InstructionWidget(
          instructionStep: widget.instructions[i],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: Sc.v * 18, right: Sc.h * 4, left: Sc.h * 4),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: Sc.v * 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.recipe.image,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Sc.v * 8,
                ),
                AutoSizeText(
                  widget.recipe.title,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: Colors.black,
                      ),
                  maxLines: 1,
                ),
                Container(
                  height: Sc.v * 30,
                  child: IngredientView(ingredients: [
                    ...widget.recipe.usedIngredients,
                    ...widget.recipe.missedIngredients
                  ]),
                ),
                SizedBox(height: Sc.v * 5),
                ...instructionWidgets,
                SizedBox(height: Sc.v * 8),
                SizedBox(
                  height: Sc.v * 30,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Container(
              height: Sc.v * 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: Sc.h * 5),
              child: Center(
                child: SwipeButton(
                  onSwipeEnd: () {
                    Navigator.pop(context);
                  },
                  activeTrackColor:
                      Theme.of(context).primaryColor.withOpacity(0.3),
                  height: Sc.h * 20,
                  thumbPadding: EdgeInsets.all(3),
                  activeThumbColor: Theme.of(context).primaryColorDark,
                  thumb: Icon(
                    Icons.check,
                    size: Sc.h * 10,
                    color: Theme.of(context).primaryColor,
                  ),
                  elevation: 2,
                  child: Text(
                    "Recipe cooked".toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
