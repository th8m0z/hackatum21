import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackatumapp/screens/home.dart';
import 'package:hackatumapp/screens/intro_screen.dart';
import 'package:hackatumapp/services/data_format.dart';
import 'package:hackatumapp/services/database.dart';
import 'package:hackatumapp/utils/sc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // _fetchData() is your function to fetch data

  Future<void> getFile() {}

  @override
  Widget build(BuildContext context) {
    Duration fiveSeconds = const Duration(seconds: 5);
    Timer.periodic(fiveSeconds, (Timer t) => getFile());
    return MultiProvider(
      providers: [
        StreamProvider.value(
            value: Database.userModel("C6OvTqu5Ui4wFOjqmGRw"),
            initialData: null),
        StreamProvider<List<Ingredient>>.value(
            value: Database.ingredientStream("C6OvTqu5Ui4wFOjqmGRw"),
            initialData: []),
        StreamProvider<List<Recipe>>.value(
            value: Database.cookingList("C6OvTqu5Ui4wFOjqmGRw"),
            initialData: []),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          backgroundColor: Color(0xFFF1FFE7),
          primaryColorLight: Color(0XFF66cc99),
          primaryColor: Color(0xFF2ecc71),
          primaryColorDark: Color(0xFF1e824c),
          highlightColor: Color(0xFF6C464E),
          textTheme: TextTheme(
            headline1: GoogleFonts.nunito(
              fontWeight: FontWeight.w900,
              fontSize: 34,
              color: Colors.black,
            ),
            headline2: GoogleFonts.nunito(
              fontWeight: FontWeight.w800,
              fontSize: 28,
              color: Colors.black,
            ),
            headline3: GoogleFonts.nunito(
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontSize: 20,
              color: Colors.black,
            ),
            caption: GoogleFonts.nunito(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: Colors.black,
            ),
            bodyText1: GoogleFonts.nunito(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.white,
            ),
            bodyText2: GoogleFonts.nunito(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
            button: GoogleFonts.nunito(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
        ),
        home: IntroScreen(),
      ),
    );
  }
}

class SizeConfigInit extends StatelessWidget {
  const SizeConfigInit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sc().init(context);
    return Home();
  }
}
