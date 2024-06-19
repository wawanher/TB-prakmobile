import 'package:flutter/material.dart';
import 'package:restoranapps/screens/welcome_screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 184, 112),
      ),
      home: WelcomeScreen(),
    );
  }
}
