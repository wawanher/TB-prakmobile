import 'package:flutter/material.dart';
import 'package:restoranapps/models/Reseller.dart';
import 'package:restoranapps/screens/reseller/reseller_form_screens.dart';
import 'package:restoranapps/screens/sidebar_screens.dart';
import 'package:restoranapps/widgets/bottombar/reseller_bottom.dart';

class ResellerScreens extends StatefulWidget {
  @override
  State<ResellerScreens> createState() => _ResellerScreensState();
}

class _ResellerScreensState extends State<ResellerScreens> {
  List<Reseller> resellers = [];

  void _addReseller(Reseller reseller) {
    setState(() {
      resellers.add(reseller);
    });
  }

  void _updateReseller(int index, Reseller reseller) {
    setState(() {
      resellers[index] = reseller;
    });
  }

  void _deleteReseller(int index) {
    setState(() {
      resellers.removeAt(index);
    });
  }

  void _openResellerForm([Reseller? reseller, int? index]) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResellerFormScreen(
          reseller: reseller,
          index: index,
          onSave: (reseller) {
            if (index == null) {
              _addReseller(reseller);
            } else {
              _updateReseller(index, reseller);
            }
          },
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
                            ));
                      },
                      child: Icon(
                        Icons.sort_rounded,
                        color: Colors.black.withOpacity(0.5),
                        size: 35,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _openResellerForm();
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
                  "RESELLER",
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
                  itemCount: resellers.length,
                  itemBuilder: (context, index) {
                    final reseller = resellers[index];
                    return ListTile(
                      title: Text(reseller.name),
                      subtitle: Text(
                          'Alamat: ${reseller.alamat}\nNo HP: ${reseller.nohp}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _openResellerForm(reseller, index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteReseller(index),
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
      bottomNavigationBar: ResellerBottomBar(),
    );
  }
}
