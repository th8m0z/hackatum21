import 'package:flutter/material.dart';
import 'package:hackatumapp/screens/home.dart';
import 'package:hackatumapp/services/database.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:hackatumapp/widgets/button.dart';
import 'package:hackatumapp/widgets/quiz_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sc().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Theme.of(context).primaryColorLight.withOpacity(0.4),
        padding: EdgeInsets.symmetric(horizontal: Sc.h * 4),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, -0.175),
              child: Text(
                "Nevera",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),

            Align(
              alignment: Alignment(0, -0.95),
              child: Image.asset(
                "assets/recycling.png",
                height: Sc.h * 85,
              ),
            ),
            Align(
              alignment: Alignment(0, -0.05),
              child: Text(
                "Select what's important to you",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Align(
              alignment: Alignment(0, 0.55),
              child: Container(
                height: Sc.v * 68,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        QuizButton(
                          caption: "Vegetarian",
                          color: Colors.transparent,
                        ),
                        SizedBox(
                          width: Sc.h * 4,
                        ),
                        QuizButton(
                          onDeselect: (String s) {},
                          caption: "Gluten-Free",
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        QuizButton(
                          caption: "Sustainable",
                          color: Colors.transparent,
                        ),
                        SizedBox(
                          width: Sc.h * 4,
                        ),
                        QuizButton(
                          caption: "Vegan",
                          color: Colors.transparent,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // Align(
            //   alignment: Alignment(0, 0.0),
            //   child: Container(
            //     height: Sc.v * 100,
            //     child: Column(
            //       children: [
            //         Container(
            //           width: double.infinity,
            //           height: Sc.v * 30,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             color: Theme.of(context).primaryColorDark,
            //           ),
            //           child: Center(
            //             child: Text(
            //               "Sustainability and CO2",
            //               style: Theme.of(context).textTheme.headline2,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment(0, 0.9),
              child: Container(
                child: Button(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  height: 58,
                  width: double.infinity,
                  borderRadius: 2000,
                  hasBoxshadow: true,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "GET STARTED",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
