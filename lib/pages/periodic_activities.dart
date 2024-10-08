import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/components/activities_periodic_select_button.dart';
import 'package:gemini_app/components/activity_page_component.dart';
import 'package:gemini_app/components/my_drawer.dart';
import 'package:gemini_app/components/set_periodicy_component.dart';

class PeriodicActivityPage extends StatelessWidget {
  final Function()? onTap;
  final Future<PeriodicyDataClass> periodicData;

  const PeriodicActivityPage({super.key,this.onTap,required this.periodicData});

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
        ActivitiesPeriodicSelectButton(onTap: onTap,activity: false,),
        SetPeriodicyComponent(periodicData: periodicData,),
        ],)));
  }
}
