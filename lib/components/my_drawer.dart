import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/pages/activities_page.dart';
import 'package:gemini_app/pages/home_page.dart';
import 'package:gemini_app/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
                  child: Center(
                child: Text("LOGO"),
              )),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));}
              ),
              ListTile(
                leading: Icon(Icons.table_chart),
                title: Text("Activities"),
                onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ActivitiesPage()));}
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingsPage()));}
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
