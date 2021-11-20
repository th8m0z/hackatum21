import 'package:flutter/material.dart';

class RecipeTile extends StatelessWidget {
  const RecipeTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        children: [
          Icon(Icons.add_box_outlined),
        ],
      ),
    );
  }
}
