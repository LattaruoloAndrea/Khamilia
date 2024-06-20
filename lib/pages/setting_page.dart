import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/components/activity_page_component.dart';
import 'package:gemini_app/components/my_drawer.dart';
import 'package:gemini_app/components/set_periodicy_component.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
        appBar: AppBar(
            title: Text(
              "Kamilia",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            backgroundColor: Colors.pink[300]),
        drawer: MyDrawer(),
        body: SafeArea(child: ListView( children: [
          // Text("sdasdsdsad")
          SetPeriodicyComponent(),
          // SizedBox(height: 200,child: Container(decoration: BoxDecoration(color: Colors.black),),),
          // SizedBox(height: 200,child: Container(decoration: BoxDecoration(color: Colors.red),),),
          // SizedBox(height: 200,child: Container(decoration: BoxDecoration(color: Colors.green),),),
          // SizedBox(height: 200,child: Container(decoration: BoxDecoration(color: Colors.blue),),),
          // SizedBox(height: 200,child: Container(decoration: BoxDecoration(color: Colors.yellow),),),
          // SizedBox(height: 200,child: Container(decoration: BoxDecoration(color: Colors.orange),),),
          // SizedBox(height: 200,child: Container(decoration: BoxDecoration(color: Colors.purple),),),
          // SizedBox(height: 200,child: Container(decoration: BoxDecoration(color: Colors.grey),),),
          // SizedBox(height: 200,child: Container(decoration: BoxDecoration(color: Colors.black),),),
        ],)));
  }
}
