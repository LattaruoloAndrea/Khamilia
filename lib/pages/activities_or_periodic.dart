
import 'package:flutter/material.dart';
import 'package:gemini_app/pages/activities_page.dart';
import 'package:gemini_app/pages/login.dart';
import 'package:gemini_app/pages/periodic_activities.dart';
import 'package:gemini_app/pages/register_page.dart';

class ActivitiesOrPeriodicPage extends StatefulWidget {
  ActivitiesOrPeriodicPage({super.key});

  @override
  State<ActivitiesOrPeriodicPage> createState() => _ActivitiesOrPeriodicPage();
}

class _ActivitiesOrPeriodicPage extends State<ActivitiesOrPeriodicPage> {
 
  bool showActivities = true;

  void togglePages(){
    setState(() {
      showActivities = !showActivities;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showActivities){
      return ActivitiesPage(onTap: togglePages);
    }else{
      return PeriodicActivityPage(onTap: togglePages);
    }
        
  }
}
