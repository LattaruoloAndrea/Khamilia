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
  late Future<ActivitiesClass> data; // TODO change ActivitiesClass with message Class we also need the description of the day if it's a signle day or add to activities class
  bool isLoading = true;
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();

  @override
  void initState() {
    data = db.queryFromTo(widget.startDate, widget.endDate);
    dateFrom.text = "2024-06-14"; //widget.startDate
    dateTo.text = "2024-06-14"; //widget.endDate
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
                        widget.isMessage? 
                        SizedBox()
                        // Column(children: [

                        // Expanded(child: Text('From: ${dateFrom.text}')),
                        // Expanded(child: Text('To: ${dateTo.text}')),
                        // ],)
                        :
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
                        widget.isMessage? SizedBox()
                        :
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
                    SizedBox(height: 20,),
                    ActivityChartComponent(activities: snapshot.data!.activities!),

                    widget.isMessage?
                    SizedBox(height: 20,): 
                    SizedBox(height: 200,),
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
