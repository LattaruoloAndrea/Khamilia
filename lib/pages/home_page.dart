import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/main.dart';
import 'package:gemini_app/pages/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.pink[300],actions: [
        IconButton(onPressed: signOutUser, icon: Icon(Icons.logout))
      ]),
      body: Center(child: Text('Welcome, you are logged in')),
    );
  }
}
