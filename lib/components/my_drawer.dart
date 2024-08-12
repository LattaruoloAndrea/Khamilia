import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/pages/activities_or_periodic.dart';
import 'package:gemini_app/pages/activities_page.dart';
import 'package:gemini_app/pages/data_analysis.dart';
import 'package:gemini_app/pages/home_page.dart';
import 'package:gemini_app/pages/progression_page.dart';
import 'package:gemini_app/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  static const version = "v1.0.0";
  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.pink[200],
        child: ListView(
          children: [
            DrawerHeader(
                child: Column(children: [
              Container(
                  child: Image.asset(
                'lib/images/logo.png',
                width: 100,
                height: 100,
              )),
              Text('Khamilia ${version}',textAlign: TextAlign.left,),
            ])),
            ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  // print(Navigator);
                  // Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                }),
            ListTile(
                leading: Icon(Icons.table_chart),
                title: Text("Activities"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ActivitiesOrPeriodicPage()));
                }),
            ListTile(
                leading: Icon(Icons.query_stats),
                title: Text("Progressions"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProgressionPage()));
                }),
            ListTile(
                leading: Icon(Icons.insights),
                title: Text("Data analysis"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DataAnalysisPage()));
                }),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: signOutUser,
            )
          ],
        ),
      ),
    );
  }
}
