import 'package:bakeryapps/apiservice/stock.dart';
import 'package:bakeryapps/models/stock.dart';
import 'package:bakeryapps/screens/stock/detailscreen.dart';
import 'package:bakeryapps/screens/stock/stock_form.dart';
import 'package:bakeryapps/screens/widgets/sidebar_screens.dart';
import 'package:flutter/material.dart';

class StockScreens extends StatefulWidget {
  const StockScreens({super.key});

  @override
  State<StockScreens> createState() => _StockScreensState();
}

class _StockScreensState extends State<StockScreens> {
  late Future<List<Stock>> listStock;
  final stockService = StockApi();

  @override
  void initState() {
    super.initState();
    listStock = stockService.getStocks();
  }

  void refreshStocks() {
    setState(() {
      listStock = stockService.getStocks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarScreens(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(247, 255, 169, 9),
        title: const Center(child: Text('Daftar Stock Roti')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/add-stock'),
          ),
        ],
      ),
      body: FutureBuilder<List<Stock>>(
        future: listStock,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No stocks available"));
          } else {
            List<Stock> stocks = snapshot.data!;
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
                itemCount: stocks.length,
                itemBuilder: (context, index) {
                  Stock stock = stocks[index];
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
                                  stocks: stock,
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
                                      stock.name,
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
                                      "stock: ${stock.qty}",
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
                                    builder: (context) => StockFormScreen(
                                      stock: stock,
                                    ),
                                  ),
                                ).then((_) => refreshStocks());
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
                                        title: const Text("Hapus Stock"),
                                        content: const Text(
                                            "Apakah Anda yakin ingin menghapus Stock ini?"),
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
                                              bool response = await stockService
                                                  .deleteStock((stock.id));
                                              if (response == true) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                      "Stock berhasil dihapus"),
                                                ));
                                                Navigator.of(context).pop();
                                                refreshStocks();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Stock gagal dihapus"),
                                                  ),
                                                );
                                                Navigator.of(context).pop();
                                                refreshStocks();
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    });
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
