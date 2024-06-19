import 'package:flutter/material.dart';
import 'package:restoranapps/models/product.dart';
import 'package:restoranapps/screens/Stock/stock_screens.dart';
import 'package:restoranapps/screens/home_screens.dart';
import 'package:restoranapps/screens/product/product_form_screens.dart';
import 'package:restoranapps/screens/reseller/reseller_screens.dart';
import 'package:restoranapps/screens/sidebar_screens.dart';

class ProductScreens extends StatefulWidget {
  @override
  State<ProductScreens> createState() => _ProductScreensState();
}

class _ProductScreensState extends State<ProductScreens> {
  List<Product> products = [];

  void _addProduct(Product product) {
    setState(() {
      products.add(product);
    });
  }

  void _updateProduct(int index, Product product) {
    setState(() {
      products[index] = product;
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  void _openProductForm([Product? product, int? index]) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductFormScreen(
          product: product,
          index: index,
          onSave: (product) {
            if (index == null) {
              _addProduct(product);
            } else {
              _updateProduct(index, product);
            }
          },
        ),
      ),
    );
  }

  void _openStockScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StockScreen(
          products: products,
          onUpdateProduct: _updateProduct,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SideBarScreens(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.sort_rounded,
                        color: Colors.black.withOpacity(0.5),
                        size: 35,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _openProductForm();
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black.withOpacity(0.5),
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "PRODUCT LIST",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: Image.network(
                        product.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.name),
                      subtitle: Text(
                        'Price: \Rp ${product.price} - Stock: ${product.stock}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _openProductForm(product, index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteProduct(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(247, 255, 169, 9),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreens(),
                    ));
              },
              child: Icon(
                Icons.home,
                color: Colors.white,
                size: 35,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductScreens(),
                    ));
              },
              child: Icon(
                Icons.production_quantity_limits,
                color: Colors.black,
                size: 35,
              ),
            ),
            InkWell(
              onTap: () {
                _openStockScreen();
              },
              child: Icon(
                Icons.storage,
                color: Colors.white,
                size: 35,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResellerScreens(),
                    ));
              },
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
