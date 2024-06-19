import 'package:flutter/material.dart';
import 'package:restoranapps/models/product.dart';

class StockScreen extends StatefulWidget {
  final List<Product> products;
  final Function(int, Product) onUpdateProduct;

  StockScreen({required this.products, required this.onUpdateProduct});

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  void _increaseStock(int index) {
    setState(() {
      widget.products[index].stock += 1;
      widget.onUpdateProduct(index, widget.products[index]);
    });
  }

  void _decreaseStock(int index) {
    if (widget.products[index].stock > 0) {
      setState(() {
        widget.products[index].stock -= 1;
        widget.onUpdateProduct(index, widget.products[index]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Stock"),
        backgroundColor: Color.fromARGB(247, 255, 169, 9),
      ),
      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];
          return ListTile(
            leading: Image.network(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Price: \$${product.price} - Stock: ${product.stock}'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _decreaseStock(index),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _increaseStock(index),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
