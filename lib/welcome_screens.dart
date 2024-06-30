import 'package:bakeryapps/screens/home_screens.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 100, bottom: 40),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 244, 170, 95),
            image: DecorationImage(
              image: AssetImage('images/bg.png'),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "Merasa Lapar? Makan roti aja!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1),
            ),
            const SizedBox(height: 90),
            Material(
              color: const Color.fromARGB(255, 242, 125, 1),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreens(),
                      ));
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                    child: const Text(
                      "Mulai Aplikasi",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
