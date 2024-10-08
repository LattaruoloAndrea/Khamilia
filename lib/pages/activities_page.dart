import 'package:flutter/material.dart';
import 'package:gemini_app/components/activities_periodic_select_button.dart';
import 'package:gemini_app/components/activity_chart_component.dart';
import 'package:gemini_app/components/activity_page_component.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/components/my_drawer.dart';

class ActivitiesPage extends StatelessWidget {
  final Function()? onTap;
  final Future<ActivitiesClass> activities;
  final String startDate;
  final String endDate;
  const ActivitiesPage({super.key, this.onTap, required this.activities,required this.startDate,required this.endDate});



  @override
  Widget build(BuildContext context) {
    // syncfusion_flutter_charts 25.2.7
    return Scaffold(
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
        body: ListView(
          children: [
            ActivitiesPeriodicSelectButton(onTap: onTap, activity: true),
            ActivityPageComponent(
              isMessage: false,
              startDate: startDate,
              endDate: endDate,
              activities: activities,
            ),
          ],
        ));
  }
}
