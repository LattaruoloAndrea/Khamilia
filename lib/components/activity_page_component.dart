import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/activity_chart_component.dart';
import 'package:gemini_app/components/date_picker_component.dart';
import 'package:gemini_app/components/description_component.dart';
import 'package:gemini_app/components/emotions_component.dart';
import 'package:gemini_app/components/loading_component.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/services/current_day_service.dart';
import 'package:gemini_app/services/db_service.dart';

class ActivityPageComponent extends StatefulWidget {
  // final
  final bool isMessage;
  String startDate;
  String endDate;
  final Future<ActivitiesClass> activities;

  ActivityPageComponent({
    super.key,
    required this.isMessage,
    required this.startDate,
    required this.endDate,
    required this.activities,
  });

  @override
  State<ActivityPageComponent> createState() => _ActivityPageComponentState();
}

class _ActivityPageComponentState extends State<ActivityPageComponent> {
  DbService db = DbService();
  CurrentDayService dayService = CurrentDayService();
  //CurrentDayService dayService = CurrentDayService();
  late Future<ActivitiesClass> data;
  bool isLoading = true;
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();
  String currentDateStart = "";
  String currentDateEnd = "";

  swapDayMonthAndViceVersa(String s) {
    var a = s.split('-');
    return "${a[0]}-${a[2]}-${a[1]}";
  }

  @override
  void initState() {
    data = widget.activities;
    // data = db.queryFromTo(widget.startDate, widget.endDate);
    var s = swapDayMonthAndViceVersa(widget.startDate);
    var e = swapDayMonthAndViceVersa(widget.endDate);
    dateFrom.text = s;
    dateTo.text = e;
    currentDateStart = s;
    currentDateEnd = e;
    dateFrom.addListener(changeDates);
    dateTo.addListener(changeDates);
  }

  changeDates() {
    if (currentDateStart != dateFrom.text || currentDateEnd != dateTo.text) {
      var s_p = swapDayMonthAndViceVersa(dateFrom.text);
      var e_p = swapDayMonthAndViceVersa(dateTo.text);
      var s = dayService.toStringDate(
          dayService.fromString(s_p)); //create date with format yyyy-dd-MM
      var e = dayService.toStringDate(
          dayService.fromString(e_p)); //create date with format yyyy-dd-MM
      if (dayService.fromString(s_p).isAfter(dayService.fromString(e_p))) {
                ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Start day shoud come before end date! Change it to retrieve the data!'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                // Code to execute.
              },
            ),
          ),
        );
      } else {
        data = db.queryFromTo(s, e);
        currentDateStart = dateFrom.text;
        currentDateEnd = dateTo.text;
      }
    }
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
                        widget.isMessage
                            ? dateFrom.text == dateTo.text
                                ? Text(
                                    'On ${dateFrom.text}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22),
                                  )
                                : Text(
                                    'From: ${dateFrom.text}, to ${dateTo.text}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22))
                            // Row(children: [

                            // Expanded(child: Text('From: ${dateFrom.text}')),
                            // Expanded(child: Text('To: ${dateTo.text}')),
                            // ],)
                            : Expanded(
                                child: DatePickerComponent(
                                  restorationId: "",
                                  label: "From",
                                  controller: dateFrom,
                                ),
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        widget.isMessage
                            ? SizedBox()
                            : Expanded(
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
                    snapshot.data!.emotions!.length > 0
                        ? EmotionsComponent(emotions: snapshot.data!.emotions!)
                        : SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    ActivityChartComponent(
                        activities: snapshot.data!.activities!),

                    widget.isMessage
                        ? SizedBox(
                            height: 20,
                          )
                        : SizedBox(
                            height: 200,
                          ),
                    // dateFrom.text == dateTo.text? DescriptionComponent(day: dateFrom.text,description: "",): SizedBox(),
                    // SizedBox(height: 20,),
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
