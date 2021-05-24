import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_project/ui/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void getUsers() async {
    final users = await _firestore.collection('users').get();
    for (var user in users.docs) {
      print(user.data());
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('users').snapshots()) {
      for (var user in snapshot.docs) {
        print(user.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[100],
          title: Text(
            "Users",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          centerTitle: false,
        ),
        backgroundColor: Colors.indigo[100],
        body: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                builder: (context, snapshot) {
                  List<Widget> userWidgets = [];
                  if (snapshot.hasData) {
                    final users = snapshot.data.docs;

                    for (var user in users) {
                      Map<String, dynamic> userMap = user.data();
                      final userName = userMap["Name"];
                      final userEmail = userMap["Email"];
                      final userWidget = userBox(
                        email: userEmail,
                        name: userName,
                      );
                      userWidgets.add(userWidget);
                    }
                    return Expanded(
                      child: ListView(
                        children: userWidgets,
                      ),
                    );
                  } else {
                    userWidgets.add(Text("No Data"));
                  }
                },
                stream: _firestore.collection('users').snapshots(),
              ),
              IconButton(
                icon: Icon(
                  Icons.logout,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    LoginScreen.id,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class userBox extends StatelessWidget {
  final String name;
  final String email;

  const userBox({this.name, this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: CircleAvatar(
                  backgroundColor: Colors.indigo[100],
                  child: Icon(
                    Icons.person,
                    size: 25,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "$email",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            ],
          ),
          Divider(
            color: Colors.indigo[50],
          )
        ],
      ),
    );
  }
}
