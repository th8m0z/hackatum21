import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hackatumapp/utils/sc.dart';

class Tag extends StatelessWidget {
  const Tag({
    Key key,
    this.textColor,
    this.color,
    this.hasBoxShadow,
    this.text,
  }) : super(key: key);
  final Color textColor;
  final Color color;
  final String text;
  final bool hasBoxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sc.h * 3, vertical: Sc.h * 1),
      height: 24,
      decoration: BoxDecoration(
        boxShadow: [
          hasBoxShadow == true
              ? BoxShadow(
                  blurRadius: Sc.h * 2.5,
                  spreadRadius: Sc.h * 0.1,
                  color: color.withOpacity(0.5),
                )
              : BoxShadow(
                  blurRadius: Sc.h * 2.5,
                  spreadRadius: Sc.h * 0.1,
                  color: Colors.transparent,
                )
        ],
        color: color ?? Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.circular(40),
      ),
      child: AutoSizeText(
        text ?? "Vegan",
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: textColor ?? Colors.white,
            ),
      ),
    );
  }
}
