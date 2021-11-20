import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/utils/sc.dart';

class RecipeTile extends StatelessWidget {
  RecipeTile({Key key, Recipe this.recipe}) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sc.v * 16,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        children: [
          Icon(Icons.add_box_outlined),
          AutoSizeText(
            recipe.title,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
