import 'package:bakeryapps/apiservice/product.dart';
import 'package:bakeryapps/models/product.dart';
import 'package:bakeryapps/screens/product/detailscreen.dart';
import 'package:bakeryapps/screens/product/product_form.dart';
import 'package:bakeryapps/screens/widgets/sidebar_screens.dart';
import 'package:flutter/material.dart';

class ProductScreens extends StatefulWidget {
  const ProductScreens({super.key});

  @override
  State<ProductScreens> createState() => _ProductScreensState();
}

class _ProductScreensState extends State<ProductScreens> {
  late Future<List<Product>> listProduct;
  final productService = ProductApi();

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

  final List<String> images = [
    'images/rye bread classic.png',
    'images/rye bread butter.png',
    'images/rye bread peanuts.png',
    'images/rye bread Round.png',
    'images/Donat_matcha.png',
    'images/Donat_classic.png',
    'images/Donat_peanuts.png',
    'images/Croissant_butter.png',
    'images/Croissant_round.png',
    'images/Croissant_classic.png',
    'images/Bagel_black.png',
    'images/Bagel_cinamon.png',
    'images/Bagel_classic.png',
    'images/Bagel_peanuts.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarScreens(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(247, 255, 169, 9),
        title: const Center(child: Text('Daftar Roti')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed('/add-product'),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: listProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Products available"));
          } else {
            List<Product> products = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 120 / 145,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  String productImage = images[index % images.length];
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 244, 225, 207),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
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
                            margin: const EdgeInsets.only(top: 35),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    const Text(
                                      "Roti terbaik",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      "Harga: Rp ${product.price}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductFormScreen(
                                      product: product,
                                    ),
                                  ),
                                ).then((_) => refreshProducts());
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Hapus Product"),
                                      content: const Text(
                                          "Apakah Anda yakin ingin menghapus Product ini?"),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text("Tidak"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text("Ya"),
                                          onPressed: () async {
                                            bool response = await productService
                                                .deleteProduct(product.id);
                                            if (response) {
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                      "Product berhasil dihapus"),
                                                ),
                                              );
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context).pop();
                                              refreshProducts();
                                            } else {
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      "Product gagal dihapus"),
                                                ),
                                              );
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context).pop();
                                              refreshProducts();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
