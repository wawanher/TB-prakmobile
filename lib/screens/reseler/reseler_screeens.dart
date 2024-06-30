import 'package:bakeryapps/apiservice/reseler.dart';
import 'package:bakeryapps/models/reseler.dart';
import 'package:bakeryapps/screens/reseler/detailscreen.dart';
import 'package:bakeryapps/screens/reseler/reseler_form.dart';
import 'package:bakeryapps/screens/widgets/sidebar_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReselerScreens extends StatefulWidget {
  const ReselerScreens({super.key});

  @override
  State<ReselerScreens> createState() => _ReselerScreensState();
}

class _ReselerScreensState extends State<ReselerScreens> {
  late Future<List<Reseler>> listReseler;
  // ignore: non_constant_identifier_names
  final ReselerService = ReselerApi();

  @override
  void initState() {
    super.initState();
    listReseler = ReselerService.getReselers();
  }

  void refreshReselers() {
    setState(() {
      listReseler = ReselerService.getReselers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarScreens(),
      appBar: AppBar(
        title: const Text('Daftar Reseler'),
        backgroundColor: const Color.fromARGB(247, 255, 169, 9),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/add-reseler'),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 5),
        child: FutureBuilder<List<Reseler>>(
            future: listReseler,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Reseler> isiReseler = snapshot.data!;
                return ListView.builder(
                  itemCount: isiReseler.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      reseler: isiReseler[index],
                                    )));
                      },
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                              icon: Icons.edit,
                              backgroundColor: Colors.blue,
                              onPressed: (context) async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => reselerFormScreen(
                                      reseler: isiReseler[index],
                                    ),
                                  ),
                                ).then((_) => refreshReselers());
                              },
                            ),
                            SlidableAction(
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                              onPressed: (context) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Hapus Reseler"),
                                        content: const Text(
                                            "Apakah Anda yakin ingin menghapus Reseler ini?"),
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
                                              bool response =
                                                  await ReselerService
                                                      .deleteReseler(
                                                          isiReseler[index].id);
                                              if (response == true) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                      "Reseler berhasil dihapus"),
                                                ));
                                                Navigator.of(context).pop();
                                                refreshReselers();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Reseler gagal dihapus"),
                                                  ),
                                                );
                                                Navigator.of(context).pop();
                                                refreshReselers();
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                        child: Card(
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              backgroundImage: AssetImage('reseler.jpg'),
                            ),
                            title: Text(
                              isiReseler[index].buyer,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              isiReseler[index].status,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
