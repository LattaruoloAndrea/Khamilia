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
  late Future<ActivitiesClass>
      data; // TODO change ActivitiesClass with message Class we also need the description of the day if it's a signle day or add to activities class
  bool isLoading = true;
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();
  String currentDateStart = "";
  String currentDateEnd = "";

  @override
  void initState() {
    data = widget.activities;
    // data = db.queryFromTo(widget.startDate, widget.endDate);
    dateFrom.text = widget.startDate;
    dateTo.text = widget.endDate;
    currentDateStart = widget.startDate;
    currentDateEnd = widget.endDate;
    dateFrom.addListener(changeDates);
    dateTo.addListener(changeDates);
  }

  changeDates() {
    if (currentDateStart != dateFrom.text || currentDateEnd != dateTo.text) {
      var s_p = dateFrom.text.split('-');
      var e_p = dateTo.text.split('-');
      var s = dayService.toStringDate(dayService.fromString("${s_p[0]}-${s_p[2]}-${s_p[1]}"));
      var e = dayService.toStringDate(dayService.fromString("${e_p[0]}-${e_p[2]}-${e_p[1]}"));
      data = db.queryFromTo(s, e);
      currentDateStart = dateFrom.text;
      currentDateEnd = dateTo.text;
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
