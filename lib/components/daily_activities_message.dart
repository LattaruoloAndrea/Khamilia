import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/services/current_day_service.dart';
import 'package:gemini_app/services/db_service.dart';

class DailyActivitiesMessage extends StatefulWidget {
  final ActivitiesClass activitiesClass;

  DailyActivitiesMessage({
    super.key,
    required this.activitiesClass,
  });

  @override
  State<DailyActivitiesMessage> createState() => _DailyActivitiesMessageState();
}

class _DailyActivitiesMessageState extends State<DailyActivitiesMessage> {
  bool modifyActivities = false;
  bool modifiedListEmotionsOrActivities = false;
  CurrentDayService dayService = CurrentDayService();
  DbService dbService = DbService();
  String day = "";
  bool removedActivity = false;

  removeActivity(String val) {
    modifiedListEmotionsOrActivities = true;
    widget.activitiesClass.activities!.remove(val);
    removedActivity= true;
  }

  modifyActivity() {
    if(removedActivity){
    dbService.updateDailyActivitiesActivities(
        widget.activitiesClass.docId, widget.activitiesClass.activities!);
    }

    setState(() {
      modifyActivities = !modifyActivities;
      removedActivity = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentDay = CurrentDayService().currentDate();
    day = currentDay.toString().substring(0, 10);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Today periodic activities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.auto_awesome_sharp,
              size: 40,
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Divider(
              thickness: 2,
              color: Colors.black,
            )),
        SizedBox(
          height: 3,
        ),
        widget.activitiesClass.activities!.length > 0 || removedActivity
            ? Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      //leading: Icon(Icons.table_chart),
                      title: Row(children: [
                        Text(
                          "Activities list for ${dayService.getDayOfTheWeek()}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton.filledTonal(
                            onPressed: modifyActivity,
                            icon: modifyActivities
                                ? Icon(Icons.save)
                                : Icon(Icons.edit),
                            color: Colors.black)
                      ]),
                      subtitle: Text(
                          "This are the activities from your today periodic ativities."),
                    ),
                    modifyActivities
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Text(
                                'If today you are not going to do this activity just delete it! If you want to add new activities send a message with your daily description!',style: TextStyle(fontSize: 11),))
                        : SizedBox(),
                    modifyActivities
                        ? Wrap(
                            children: List<Widget>.generate(
                              widget.activitiesClass.activities!.length,
                              (int idx) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Chip(
                                    shape: StadiumBorder(side: BorderSide()),
                                    onDeleted: () {
                                      setState(() {
                                        removeActivity(widget
                                            .activitiesClass.activities![idx]);
                                      });
                                    },
                                    label: Text(widget
                                        .activitiesClass.activities![idx]),
                                  ),
                                );
                              },
                            ).toList(),
                          )
                        : Wrap(
                            children: List<Widget>.generate(
                              widget.activitiesClass.activities!.length,
                              (int idx) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Chip(
                                    shape: StadiumBorder(side: BorderSide()),
                                    label: Text(widget
                                        .activitiesClass.activities![idx]),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            : Card(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                ListTile(
                  //leading: Icon(Icons.table_chart),
                  title: Text(
                    "No periodic activities for ${dayService.getDayOfTheWeek()}!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "You removed all your periodic activities for today, but next weak it will be present. If you want to delete this activity from the periodic activities go to the activity page and clik on the periodic button!"),
                ),
              ])),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
