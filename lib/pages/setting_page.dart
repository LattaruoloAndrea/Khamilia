import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/components/activity_page_component.dart';
import 'package:gemini_app/components/my_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  void openMenu() {}

  String getToday(){
    return "13-06-2024";
  }

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
      drawer: MyDrawer(),
      body: ActivityPageComponent(endDate: getToday(),startDate: getToday(),isMessage: false,),
    );
  }
}
