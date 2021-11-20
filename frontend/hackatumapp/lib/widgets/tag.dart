import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag({
    Key key,
    this.color,
    this.text,
  }) : super(key: key);
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      height: 24,
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(40)),
      child: AutoSizeText(
        text ?? "Vegan",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
