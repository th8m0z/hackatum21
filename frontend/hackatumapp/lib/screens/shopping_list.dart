import 'package:flutter/material.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:hackatumapp/views/ingredient_list_view.dart';

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.ingredients}) : super(key: key);
  final List<Ingredient> ingredients;
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    print("missedIngredient length == ${widget.ingredients.length}");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: Sc.v * 20),
            Text(
              "Shopping List",
              style: Theme.of(context).textTheme.headline1,
            ),
            Container(
              height: Sc.v * 80,
              child: IngredientView(ingredients: widget.ingredients),
            )
          ],
        ),
      ),
    );
  }
}
