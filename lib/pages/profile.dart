import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travel_app_02/pages/login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = 'Raul el padre de martinoli';
  String phone = '03107085816';
  String address = 'Leon, Gto';
  String email = 'elmejorcomentarista@gmail.com';
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 70,
                backgroundImage: _getProfileImage(),
                child: InkWell(
                  onTap: () {
                    _pickImage();
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    itemProfile('Nombre', name, CupertinoIcons.person),
                    const SizedBox(height: 10),
                    itemProfile('Telefono', phone, CupertinoIcons.phone),
                    const SizedBox(height: 10),
                    itemProfile('Direccion', address, CupertinoIcons.location),
                    const SizedBox(height: 10),
                    itemProfile('Email', email, CupertinoIcons.mail),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _editProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Editar perfil'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _logout();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    side: BorderSide(color: Colors.red),
                  ),
                  child: const Text('Cerrar sesión',
                      style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editProfile() async {
    // Show a dialog with the editing options
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = name;
        String newPhone = phone;
        String newAddress = address;
        String newEmail = email;

        return AlertDialog(
          title: Text("Editar Perfil"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Nombre"),
                onChanged: (value) {
                  newName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Telefono"),
                onChanged: (value) {
                  newPhone = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Direccion"),
                onChanged: (value) {
                  newAddress = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Email"),
                onChanged: (value) {
                  newEmail = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  name = newName;
                  phone = newPhone;
                  address = newAddress;
                  email = newEmail;
                });
                Navigator.pop(context);
              },
              child: Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Color.fromRGBO(249, 113, 15, 1).withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }

  ImageProvider _getProfileImage() {
    if (profileImage != null) {
      return FileImage(profileImage!);
    } else {
      return AssetImage('assets/imagenes/orba.jpg');
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        profileImage = File(pickedImage.path);
      });
    }
  }

  void _logout() async {
    // Eliminar el token almacenado utilizando flutter_secure_storage
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'auth_token');

    // Navega a la pantalla de inicio de sesión y reemplaza todas las rutas anteriores
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false, // Elimina todas las rutas en la pila
    );
  }
}
