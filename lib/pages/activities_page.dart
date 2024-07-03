import 'package:flutter/material.dart';
import 'package:gemini_app/components/activities_periodic_select_button.dart';
import 'package:gemini_app/components/activity_page_component.dart';
import 'package:gemini_app/components/my_drawer.dart';

class ActivitiesPage extends StatelessWidget {
  final Function()? onTap;
  const ActivitiesPage({super.key, this.onTap});


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
      body: ListView(children: [
        ActivitiesPeriodicSelectButton(onTap: onTap,activity: true),
        ActivityPageComponent(isMessage: false,startDate: getTodayDate(),endDate: getTodayDate()),
      ],) 
    );
  }
}
