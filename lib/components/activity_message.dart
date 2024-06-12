import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/message_class.dart';

class ActivitiMessageClass extends StatefulWidget {
  final ActivitiesClass activitiesClass;

  ActivitiMessageClass({
    super.key,
    required this.activitiesClass,
  });

  @override
  State<ActivitiMessageClass> createState() => _ActivitiMessageClassState();
}

class _ActivitiMessageClassState extends State<ActivitiMessageClass> {
  bool modifyActivities = false;
  bool modifyEmotions = false;
  bool modifiedListEmotionsOrActivities = false;
  TextEditingController activitiesController = TextEditingController();
  TextEditingController emotionsController = TextEditingController();



  addActivity() {
    setState(() {
      if(activitiesController.text.isNotEmpty){
        modifiedListEmotionsOrActivities = true;
        widget.activitiesClass.activities!.add(activitiesController.text);
        activitiesController.clear();
      }
    });
  }

  addEmotion() {
    setState(() {
      if(emotionsController.text.isNotEmpty){
        modifiedListEmotionsOrActivities = true;
        widget.activitiesClass.emotions!.add(emotionsController.text);
        emotionsController.clear();
      }
    });
  }

  removeActivity(String val) {
    modifiedListEmotionsOrActivities = true;
    widget.activitiesClass.activities!.remove(val);
  }

  removeEmotion(String val){
      modifiedListEmotionsOrActivities = true;
    widget.activitiesClass.emotions!.remove(val);
  }

  saveData() {
    if(modifiedListEmotionsOrActivities){
      // TODO send data to firebase
      modifiedListEmotionsOrActivities = false;
    }
  }

  modifyActivity() {
    setState(() {
      modifyActivities = !modifyActivities;
    });
  }

  modifyEmotion() {
    setState(() {
      modifyEmotions = !modifyEmotions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                        Text(
              "Daily activities",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
          height: 15,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text("The description provided is for"),
        ),
        Container(
            alignment: Alignment.centerLeft,
            child: SegmentedButton(
              segments: [
                ButtonSegment(value: "yesterday", label: Text("yesterday")),
                ButtonSegment(value: "today", label: Text("today")),
              ],
              selected: {
                widget.activitiesClass.yesterday ? "yesterday" : "today"
              },
              onSelectionChanged: (newSelection) {
                setState(() {
                  widget.activitiesClass.yesterday =
                      (newSelection.first == "yesterday");
                });
              },
            )),
        SizedBox(
          height: 10,
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                //leading: Icon(Icons.table_chart),
                title: Row(children: [
                  Text(
                    "Activities list",
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
                subtitle: Text("This is the activities from your description"),
              ),
              modifyActivities
                  ? Padding(
                      padding: EdgeInsets.only(left: 15, right: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: TextField(
                            controller: activitiesController,
                            decoration: InputDecoration(
                                hintText: "Add activity",
                                hintStyle: TextStyle(color: Colors.grey[600])),
                          )),
                          Container(
                            child: IconButton.filledTonal(
                              onPressed: addActivity,
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
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
                                  removeActivity(widget.activitiesClass.activities![idx]);
                                });
                              },
                              label:
                                  Text(widget.activitiesClass.activities![idx]),
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
                              label:
                                  Text(widget.activitiesClass.activities![idx]),
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
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Row(children: [
                  Text(
                    "Emotions list",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton.filledTonal(
                      onPressed: modifyEmotion,
                      icon: modifyEmotions
                          ? Icon(Icons.save)
                          : Icon(Icons.edit),
                      color: Colors.black)
                ]),
                subtitle: Text("This is the activities from your description"),
              ),
              modifyEmotions
                  ? Padding(
                      padding: EdgeInsets.only(left: 15, right: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: TextField(
                            controller: emotionsController,
                            decoration: InputDecoration(
                                hintText: "Add emotion",
                                hintStyle: TextStyle(color: Colors.grey[600])),
                          )),
                          Container(
                            child: IconButton.filledTonal(
                              onPressed: addEmotion,
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              modifyEmotions
                  ? Wrap(
                      children: List<Widget>.generate(
                        widget.activitiesClass.emotions!.length,
                        (int idx) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Chip(
                              shape: StadiumBorder(side: BorderSide()),
                              onDeleted: () {
                                setState(() {
                                  removeEmotion(widget.activitiesClass.emotions![idx]);
                                });
                              },
                              label:
                                  Text(widget.activitiesClass.emotions![idx]),
                            ),
                          );
                        },
                      ).toList(),
                    )
                  : Wrap(
                      children: List<Widget>.generate(
                        widget.activitiesClass.emotions!.length,
                        (int idx) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Chip(
                              shape: StadiumBorder(side: BorderSide()),
                              label:
                                  Text(widget.activitiesClass.emotions![idx]),
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
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
