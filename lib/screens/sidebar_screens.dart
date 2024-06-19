import 'package:flutter/material.dart';
import 'package:restoranapps/screens/home_screens.dart';
import 'package:restoranapps/screens/product/product_screens.dart';
import 'package:restoranapps/screens/reseller/reseller_screens.dart';
import 'package:restoranapps/screens/Stock/stock_screens.dart';

class SideBarScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: 150,
          alignment: Alignment.bottomLeft,
          color: Colors.amber,
          child: Text(
            "Menu Pilihan",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
        SizedBox(height: 10),
        ListTile(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreens()));
          },
          leading: Icon(Icons.home),
          title: Text(
            "Home",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductScreens()));
          },
          leading: Icon(Icons.production_quantity_limits),
          title: Text(
            "Product",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
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
          leading: Icon(Icons.badge_sharp),
          title: Text(
            "Stock",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResellerScreens(),
                ));
          },
          leading: Icon(Icons.person_2),
          title: Text(
            "Reseller",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    ));
  }
}
