import 'package:flutter/material.dart';
import 'package:restoranapps/screens/home_screens.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 100, bottom: 40),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 244, 170, 95),
            image: DecorationImage(
              image: AssetImage('images/bg.png'),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Merasa Lapar? Makan roti aja!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1),
            ),
            SizedBox(height: 90),
            Material(
              color: Color.fromARGB(255, 242, 125, 1),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreens(),
                      ));
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                    child: Text(
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
