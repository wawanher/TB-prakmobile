import 'package:bakeryapps/apiservice/product.dart';
import 'package:bakeryapps/models/product.dart';
import 'package:bakeryapps/screens/widgets/tab_product/Bagel.dart';
import 'package:bakeryapps/screens/widgets/tab_product/Donat.dart';
import 'package:bakeryapps/screens/widgets/tab_product/crossaint.dart';
import 'package:bakeryapps/screens/widgets/tab_product/ryebread.dart';
import 'package:bakeryapps/screens/widgets/sidebar_screens.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'images/carosel1.png',
  'images/carosel2.png',
  'images/carosel3.png',
  'images/carosel4.png',
  'images/carosel5.png',
];

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Product>> listProduct;
  final ProductApi productService = ProductApi();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
    listProduct = productService.getProducts();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  void refreshProducts() {
    setState(() {
      listProduct = productService.getProducts();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarScreens(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(247, 255, 169, 9),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Hari Terbaik Untuk Makan Roti!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              width: MediaQuery.of(context).size.width,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(247, 255, 169, 9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Cari Roti Kamu",
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                    prefix: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TabBar(
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white.withOpacity(0.5),
                isScrollable: true,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3,
                    color: Colors.black,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 10),
                ),
                labelStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                tabs: const [
                  Tab(text: "Rye Bread"),
                  Tab(text: "Croissant"),
                  Tab(text: "Bagel"),
                  Tab(text: "Donat"),
                ]),
            const SizedBox(height: 10),
            Center(
              child: [
                const Ryebread(),
                const Crossaint(),
                const Bagel(),
                const Donat(),
              ][_tabController.index],
            ),
          ],
        ),
      ),
    );
  }
}
