import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackatumapp/views/fridge.dart';
import 'package:hackatumapp/widgets/button.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 22, right: 22, top: 40),
        // color: Colors.red,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 0.92),
              child: Button(
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  XFile image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  print("receiptText");
                },
                child: Icon(
                  Icons.bolt_rounded,
                  size: 35,
                ),
                height: 58,
                width: 58,
                borderRadius: 2000,
                hasBoxshadow: true,
                color: Colors.greenAccent[400],
              ),
            ),
            Align(
              alignment: Alignment(0, -0.65),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.035),
                ),
                child: FridgeView(),
              ),
            ),
            Align(
              alignment: Alignment(0, 0.6),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).backgroundColor,
                  // Colors.black.withOpacity(0.035),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.975),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hey John!",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Button(
                      hasBoxshadow: true,
                      opacityOnly: true,
                      borderRadius: 100,
                      color: Theme.of(context).primaryColorLight,
                      child: Icon(Icons.add),
                      height: 50,
                      width: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
