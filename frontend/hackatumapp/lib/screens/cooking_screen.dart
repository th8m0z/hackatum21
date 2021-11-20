import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/utils/sc.dart';

class CookingScreen extends StatefulWidget {
  CookingScreen({
    Key key,
    this.recipe,
  }) : super(key: key);
  final Recipe recipe;
  @override
  _CookingScreenState createState() => _CookingScreenState();
}

class _CookingScreenState extends State<CookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.only(top: Sc.v * 16, right: Sc.h * 4, left: Sc.h * 4),
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            AutoSizeText(
              widget.recipe.title,
              style: Theme.of(context).textTheme.headline1,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
