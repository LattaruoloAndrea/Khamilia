import 'package:flutter/material.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/components/set_periodicy_component.dart';
import 'package:gemini_app/pages/activities_page.dart';
import 'package:gemini_app/pages/login.dart';
import 'package:gemini_app/pages/periodic_activities.dart';
import 'package:gemini_app/pages/register_page.dart';
import 'package:gemini_app/services/db_service.dart';

class ActivitiesOrPeriodicPage extends StatefulWidget {
  ActivitiesOrPeriodicPage({super.key});

  @override
  State<ActivitiesOrPeriodicPage> createState() => _ActivitiesOrPeriodicPage();
}

class _ActivitiesOrPeriodicPage extends State<ActivitiesOrPeriodicPage> {
  bool showActivities = true;
  DbService db = DbService();
  late Future<PeriodicyDataClass> dataPeriodic = db.loadPeriodicy();
  late Future<ActivitiesClass> dataActivities = db.queryFromTo(getTodayDate(), getTodayDate());
  // late String startDate;
  // late String endDate;

  @override
  void initState() {
    super.initState();
    // startDate = getTodayDate();
    // endDate = getTodayDate();
    // Future<PeriodicyDataClass> dataPeriodic = db.loadPeriodicy();
    // Future<ActivitiesClass> dataActivities = db.queryFromTo(startDate, endDate);
  }

  void togglePages() {
    setState(() {
      showActivities = !showActivities;
    });
  }

  String getTodayDate() {
    return "13-06-2024";
  }

  @override
  Widget build(BuildContext context) {
    if (showActivities) {
      return ActivitiesPage(
        onTap: togglePages,
        activities: dataActivities,
        startDate: getTodayDate(),
        endDate: getTodayDate(),
      );
    } else {
      return PeriodicActivityPage(onTap: togglePages,periodicData: dataPeriodic,);
    }
  }
}
