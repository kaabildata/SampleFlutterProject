import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String name;
  String email;
  String password;
  bool _ischeckedvisibility = true;
  IconData _icon = Icons.visibility;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.indigo[100],
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign up with email',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              FloatingActionButton(
                onPressed: () => {
                  getImageFromGallery,
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.indigo[300],
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Material(
                  elevation: 8,
                  color: Colors.indigo[100],
                  child: TextFormField(
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Name",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Material(
                  elevation: 8,
                  color: Colors.indigo[100],
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Email",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 30),
                child: Material(
                  elevation: 8,
                  child: TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Password',
                      suffixIcon: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(_icon),
                      ),
                    ),
                    obscureText: _ischeckedvisibility,
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      _firestore
                          .collection('users')
                          .add({'Email': email, 'Name': name});
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 16, color: Colors.indigo[150]),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Already have an account?',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: Colors.indigo[150]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _ischeckedvisibility = !_ischeckedvisibility;
      if (_icon == Icons.visibility) {
        _icon = Icons.visibility_off;
      } else
        _icon = Icons.visibility;
    });
  }

  Future getImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    File _image;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
