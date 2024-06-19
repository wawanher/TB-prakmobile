import 'package:flutter/material.dart';

class Product {
  @required
  String name;
  @required
  String image;
  @required
  int price;
  @required
  int stock;

  Product(this.name, this.image, this.price, this.stock);
}
