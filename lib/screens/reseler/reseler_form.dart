import 'package:bakeryapps/apiservice/reseler.dart';
import 'package:bakeryapps/models/reseler.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class reselerFormScreen extends StatefulWidget {
  final Reseler? reseler;

  const reselerFormScreen({super.key, this.reseler});

  @override
  State<reselerFormScreen> createState() => _reselerFormScreenState();
}

// ignore: camel_case_types
class _reselerFormScreenState extends State<reselerFormScreen> {
  final ReselerApi reselerApi = ReselerApi();
  final _formKey = GlobalKey<FormState>();
  final _buyerController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.reseler != null) {
      _buyerController.text = widget.reseler!.buyer;
      _phoneController.text = widget.reseler!.phone;
      _dateController.text = widget.reseler!.date;
      _statusController.text = widget.reseler!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reseler == null
            ? 'Tambah reseler Roti'
            : 'Edit reseler Roti'),
        backgroundColor: const Color.fromARGB(247, 255, 169, 9),
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _buyerController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'reseler'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan nama reseler';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'No Hp'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan No Hp reseler';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'tanggal'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan tanggal reseler';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _statusController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'status'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan status reseler';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool response;
                    if (widget.reseler == null) {
                      // Tambah reseler baru
                      response = await reselerApi.createReseler(
                        _buyerController.text,
                        _phoneController.text,
                        _dateController.text,
                        _statusController.text,
                      );
                    } else {
                      // Update reseler yang ada
                      response = await reselerApi.updateReseler(
                        Reseler(
                          id: widget.reseler!.id,
                          buyer: _buyerController.text,
                          phone: _phoneController.text,
                          date: _dateController.text,
                          status: _statusController.text,
                        ),
                        widget.reseler!.id,
                      );
                    }

                    if (response == true) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(widget.reseler == null
                            ? "reseler berhasil ditambahkan"
                            : "reseler berhasil diperbarui"),
                      ));
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).popAndPushNamed('/reseler');
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(widget.reseler == null
                            ? "reseler gagal ditambahkan"
                            : "reseler gagal diperbarui"),
                      ));
                    }
                  }
                },
                child: Text(
                  widget.reseler == null ? 'Simpan' : 'Update',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
