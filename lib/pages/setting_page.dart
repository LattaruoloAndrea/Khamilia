import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/components/my_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  void openMenu() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Kamilia",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          backgroundColor: Colors.pink[300]),
      body: Center(child: Text('This is the settings page')),
      drawer: MyDrawer(),
    );
  }
}
