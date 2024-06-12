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
  removeActivity() {}

  removeEmotion() {}

  saveData() {}

  addActivity() {}

  addEmotion() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome_sharp,
              size: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Daily activities",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                      onPressed: addActivity,
                      icon: Icon(Icons.add),
                      color: Colors.black)
                ]),
                subtitle: Text("This is the activities from your description"),
              ),
              Wrap(
                children: List<Widget>.generate(
                  widget.activitiesClass.activities!.length,
                  (int idx) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Chip(
                        // padding: EdgeInsets.symmetric(horizontal: 20),
                        // shape: ,
                        deleteIcon: Icon(Icons.delete),
                        shape: StadiumBorder(side: BorderSide()),
                        onDeleted: () {
                          setState(() {
                            removeActivity();
                          });
                        },
                        label: Text(widget.activitiesClass.activities![idx]),
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
                //leading: Icon(Icons.table_chart),
                title: Row(children: [
                  Text(
                    "Emotions list",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton.filledTonal(
                      onPressed: addEmotion,
                      icon: Icon(Icons.add),
                      color: Colors.black)
                ]),
                subtitle: Text("This is the emotions from your description"),
              ),
              Wrap(
                children: List<Widget>.generate(
                  widget.activitiesClass.emotions!.length,
                  (int idx) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Chip(
                        // padding: EdgeInsets.symmetric(horizontal: 20),
                        // shape: ,
                        deleteIcon: Icon(Icons.delete),
                        shape: StadiumBorder(side: BorderSide()),
                        onDeleted: () {
                          setState(() {
                            removeEmotion();
                          });
                        },
                        label: Text(widget.activitiesClass.emotions![idx]),
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
