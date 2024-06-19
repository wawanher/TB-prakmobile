// lib/product_form_screen.dart
import 'package:flutter/material.dart';
import 'package:restoranapps/models/product.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;
  final int? index;
  final Function(Product) onSave;

  ProductFormScreen({this.product, this.index, required this.onSave});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _image;
  late int _price;
  late int _stock;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _name = widget.product!.name;
      _image = widget.product!.image;
      _price = widget.product!.price;
      _stock = widget.product!.stock;
    } else {
      _name = '';
      _image = '';
      _price = 0;
      _stock = 0;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newProduct = Product(_name, _image, _price, _stock);
      widget.onSave(newProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.product == null ? 'Tambahkan Product' : 'Edit Product'),
        backgroundColor: Color.fromARGB(247, 255, 169, 9),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tolong isi Namanya';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _image,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tolong Isi Image URL';
                  }
                  return null;
                },
                onSaved: (value) => _image = value!,
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tolong Isi Harganya';
                  }
                  return null;
                },
                onSaved: (value) => _price = int.parse(value!),
              ),
              TextFormField(
                initialValue: _stock.toString(),
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tolong Isi stocknya';
                  }
                  return null;
                },
                onSaved: (value) => _stock = int.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
