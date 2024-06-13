import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/loading_component.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/services/db_service.dart';

class ActivityPageComponent extends StatefulWidget {
  // final
  final bool isMessage;
  String startDate;
  String endDate;

  ActivityPageComponent({
    super.key,
    required this.isMessage,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<ActivityPageComponent> createState() => _ActivityPageComponentState();
}

class _ActivityPageComponentState extends State<ActivityPageComponent> {
  DbService db = DbService();
  late Future<ActivitiesClass> data;
  bool isLoading = true;

  @override
  void initState() {
    data = db.queryFromTo(widget.startDate, widget.endDate);
  }

  changeDates(newStart,newEnd) {
    setState(() {
      widget.startDate = newStart;
      widget.endDate = newEnd;
    });
    data = db.queryFromTo(newStart, newEnd);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text("DATA LOADED",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          );
        }
        else {
          return LoadingComponent();
        }
      }
    );
  }
}
