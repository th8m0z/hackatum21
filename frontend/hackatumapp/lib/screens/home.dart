import 'package:flutter/material.dart';
import 'package:hackatumapp/services/ml_vision_service.dart';
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
                  String receiptText =
                      await VisionService.processImage(image.path);
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
              alignment: Alignment(0, -0.9),
              child: Container(
                height: 450,
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
                  color: Colors.black.withOpacity(0.035),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
