import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/components/activity_page_component.dart';
import 'package:gemini_app/components/my_drawer.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  void openMenu() {}

  String getTodayDate(){
    return "13-06-2024";
  }

  @override
  Widget build(BuildContext context) {
    // syncfusion_flutter_charts 25.2.7 
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Kamilia",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          backgroundColor: Colors.pink[300]),
      drawer: MyDrawer(),
      body: ActivityPageComponent(isMessage: false,startDate: getTodayDate(),endDate: getTodayDate()),
    );
  }
}
