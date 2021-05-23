import 'package:flutter/material.dart';

import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _ischeckedvisibility = true;
  IconData icon = Icons.visibility;
  String email;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[100],
        body: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Login with email',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Material(
                  elevation: 8,
                  color: Colors.indigo[100],
                  child: TextField(
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
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Password',
                      suffixIcon: InkWell(
                        onTap: togglePasswordView,
                        child: Icon(icon),
                      ),
                    ),
                    obscureText: _ischeckedvisibility,
                  ),
                ),
              ),
              TextButton(
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 16, color: Colors.indigo[150]),
                ),
                onPressed: () => null,
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  print(email);
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: Colors.indigo[150]),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Don\'t have account',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.indigo[150],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void togglePasswordView() {
    setState(() {
      _ischeckedvisibility = !_ischeckedvisibility;
      if (icon == Icons.visibility) {
        icon = Icons.visibility_off;
      } else
        icon = Icons.visibility;
    });
  }
}
