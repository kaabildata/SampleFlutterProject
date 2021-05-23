import 'package:flutter/material.dart';
import 'package:sample_project/widgets/reusable_widgets.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  bool _ischeckedvisibility = true;
  IconData _icon = Icons.visibility;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign up with email',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.indigo[300],
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ReusableTextfield(hintText: 'Name'),
            SizedBox(
              height: 20,
            ),
            ReusableTextfield(hintText: 'Email'),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 30),
              child: Material(
                elevation: 8,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 5),
                    ),
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
              onPressed: () {},
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
}
