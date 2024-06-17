import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/date_picker_component.dart';
import 'package:gemini_app/components/emotions_component.dart';
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
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();

  @override
  void initState() {
    data = db.queryFromTo(widget.startDate, widget.endDate);
    dateFrom.text = "2024-06-14";
    dateTo.text = "2024-06-14";
  }

  changeDates(newStart, newEnd) {
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
            if (snapshot.data == null) {
              return Text("No data");
            } else {
              return SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DatePickerComponent(
                            restorationId: "",
                            label: "From",
                            controller: dateFrom,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DatePickerComponent(
                            restorationId: "",
                            label: "To",
                            controller: dateTo,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    snapshot.data!.emotions!.length >0? EmotionsComponent(emotions: snapshot.data!.emotions!) : SizedBox(),
                    Container(
                      height: 200,
                      child: Text("dasdsadsadad"),
                    ),
                    Container(
                      height: 200,
                      child: Text("dasdsadsadad"),
                    ),
                    Container(
                      height: 200,
                      child: Text("dasdsadsadad"),
                    ),
                    Container(
                      height: 200,
                      child: Text("dasdsadsadad"),
                    ),
                    Container(
                      height: 200,
                      child: Text("dasdsadsadad"),
                    ),
                    Container(
                      height: 200,
                      child: Text("dasdsadsadad"),
                    ),
                  ],
                ),
              );
            }
          } else {
            return LoadingComponent();
          }
        });
  }
}
