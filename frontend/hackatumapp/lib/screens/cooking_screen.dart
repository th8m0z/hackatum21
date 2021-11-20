import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/utils/sc.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding:
            EdgeInsets.only(top: Sc.v * 18, right: Sc.h * 4, left: Sc.h * 4),
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
            AutoSizeText(
              widget.instructions[0].text,
            ),
          ],
        ),
      ),
    );
  }
}
