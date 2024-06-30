import 'package:bakeryapps/screens/about.dart';
import 'package:bakeryapps/screens/profile.dart';
import 'package:bakeryapps/screens/home_screens.dart';
import 'package:bakeryapps/screens/product/product_form.dart';
import 'package:bakeryapps/screens/product/product_screeens.dart';
import 'package:bakeryapps/screens/reseler/reseler_form.dart';
import 'package:bakeryapps/screens/reseler/reseler_screeens.dart';
import 'package:bakeryapps/screens/stock/stock_form.dart';
import 'package:bakeryapps/screens/stock/stock_screens.dart';
import 'package:bakeryapps/welcome_screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomeScreens(),
        '/product': (context) => const ProductScreens(),
        '/add-product': (context) => const ProductFormScreen(),
        '/stock': (context) => const StockScreens(),
        '/add-stock': (context) => const StockFormScreen(),
        '/reseler': (context) => const ReselerScreens(),
        '/add-reseler': (context) => const reselerFormScreen(),
        '/profile': (context) => const Profile(),
        '/about': (context) => const About(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 184, 112),
      ),
      home: const WelcomeScreen(),
    );
  }
}
