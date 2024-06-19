import 'package:flutter/material.dart';
import 'package:restoranapps/models/Reseller.dart';


class ResellerFormScreen extends StatefulWidget {
  final Reseller? reseller;
  final int? index;
  final Function(Reseller) onSave;

  ResellerFormScreen({this.reseller, this.index, required this.onSave});

  @override
  _ResellerFormScreenState createState() => _ResellerFormScreenState();
}

class _ResellerFormScreenState extends State<ResellerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _alamat;
  late int _nohp;

  @override
  void initState() {
    super.initState();
    if (widget.reseller != null) {
      _name = widget.reseller!.name;
      _alamat = widget.reseller!.alamat;
      _nohp = widget.reseller!.nohp;
    } else {
      _name = '';
      _alamat = '';
      _nohp = 0;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final reseller = Reseller(_name, _alamat, _nohp);
      widget.onSave(reseller);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reseller == null ? 'Tambah Reseller' : 'Edit Reseller'),
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
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _alamat,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _alamat = value!;
                },
              ),
              TextFormField(
                initialValue: _nohp.toString(),
                decoration: InputDecoration(labelText: 'No HP'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nohp = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
