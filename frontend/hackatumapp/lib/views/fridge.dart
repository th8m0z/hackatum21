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
      child: Stack(
        children: [
          Align(
            alignment: Alignment(-0.92, -0.94),
            child: Row(
              children: [
                Button(
                  borderRadius: 100,
                  color: Colors.green[800],
                  child: Icon(Icons.add),
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}
