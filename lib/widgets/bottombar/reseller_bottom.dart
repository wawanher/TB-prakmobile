import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restoranapps/screens/home_screens.dart';
import 'package:restoranapps/screens/product/product_screens.dart';
import 'package:restoranapps/screens/reseller/reseller_screens.dart';
import 'package:restoranapps/screens/Stock/stock_screens.dart';

class ResellerBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: Colors.white,
              size: 35,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StockScreen(
                      products: [],
                      onUpdateProduct: (int, Product) {},
                    ),
                  ));
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
              color: Colors.black,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
