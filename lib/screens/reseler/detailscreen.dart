import 'dart:io';
import 'package:bakeryapps/models/reseler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailScreen extends StatefulWidget {
  final Reseler reseler;

  const DetailScreen({super.key, required this.reseler});

  @override
  // ignore: library_private_types_in_public_api
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile ${widget.reseler.buyer}'),
        backgroundColor: const Color.fromARGB(247, 255, 169, 9),
      ),
      body: Center(
        child: Container(
          height: 550,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 248, 189, 78),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          width: 200,
                          'images/reseler.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(height: 50),
              Text(
                widget.reseler.buyer,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "No Hp: ${widget.reseler.phone}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.brown[700],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Tanggal: ${widget.reseler.date}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.brown[700],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Status: ${widget.reseler.status}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.brown[700],
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton.icon(
                onPressed: () {
                  // Add your functionality here
                },
                icon: const Icon(Icons.message),
                label: const Text("Contact Reseller"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
