import 'dart:math';
import 'package:bakeryapps/models/stock.dart';
import 'package:flutter/material.dart';

class Detailscreen extends StatelessWidget {
  final Stock stocks;

  const Detailscreen({Key? key, required this.stocks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Daftar gambar yang tersedia di direktori lokal
    final List<String> images = [
      'images/rye bread classic.png',
      'images/rye bread butter.png',
      'images/rye bread peanuts.png',
      'images/rye bread peanuts.png',
    ];

    // Pilih gambar secara acak dari daftar
    final random = Random();
    final String randomImage = images[random.nextInt(images.length)];

    return Scaffold(
      appBar: AppBar(
        title: Text(stocks.name),
        backgroundColor: const Color.fromARGB(247, 255, 169, 9),
      ),
      body: Center(
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 248, 189, 78),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  randomImage,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                stocks.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Stock: ${stocks.qty}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.brown[700],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Berat: ${stocks.weight} ${stocks.attr}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.brown[700],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
