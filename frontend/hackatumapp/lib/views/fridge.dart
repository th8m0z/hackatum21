import 'package:flutter/material.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:hackatumapp/widgets/button.dart';

class FridgeView extends StatefulWidget {
  FridgeView({Key key}) : super(key: key);

  @override
  _FridgeViewState createState() => _FridgeViewState();
}

class _FridgeViewState extends State<FridgeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        mainAxisSpacing: Sc.h * 3,
        crossAxisSpacing: Sc.h * 3,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                "🥛",
                style: TextStyle(fontSize: Sc.h * 18),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                "🥩",
                style: TextStyle(fontSize: Sc.h * 18),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                "🍏",
                style: TextStyle(fontSize: Sc.h * 18),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.orange[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                "🍞",
                style: TextStyle(fontSize: Sc.h * 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
