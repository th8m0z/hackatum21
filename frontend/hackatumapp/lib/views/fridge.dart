import 'package:flutter/material.dart';
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
      child: Column(
        children: [
          Row(
            children: [
              Container(color: Colors.lightBlue[200]),
              Container(),
            ],
          ),
          Row(
            children: [Container(), Container()],
          ),
        ],
      ),
    );
  }
}
