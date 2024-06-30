import 'package:bakeryapps/apiservice/product.dart';
import 'package:bakeryapps/models/product.dart';
import 'package:bakeryapps/screens/product/detailscreen.dart';
import 'package:flutter/material.dart';

class Ryebread extends StatefulWidget {
  const Ryebread({super.key});

  @override
  State<Ryebread> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<Ryebread> {
  late Future<List<Product>> listProduct;
  final ProductApi productService = ProductApi();

  @override
  void initState() {
    super.initState();
    listProduct = productService.getProducts();
  }

  void refreshProducts() {
    setState(() {
      listProduct = productService.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'images/rye bread classic.png',
      'images/rye bread butter.png',
      'images/rye bread peanuts.png',
      'images/rye bread Round.png',
    ];

    return FutureBuilder<List<Product>>(
      future: listProduct,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No products available"));
        } else {
          List<Product> products = snapshot.data!;
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 150 / 195,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];
              String productImage = images[index % images.length];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detailscreen(
                        product: product,
                        imageUrl: productImage,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 255, 184, 112),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        productImage,
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Roti terbaik",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Rp ${product.price}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
