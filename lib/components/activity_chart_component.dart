import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/loading_component.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/services/gemini_service.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum Activities { sport, hobby, work, study, social }

enum EnumActivitiesGroup {
  pyshicalActivities(
      color: Colors.blue,
      label: "Sports",
      key: "pyshical",
      category: "Sports / Physical activities",
      description:
          "These are the activities that somehow involve in a physical activity."),
  entertainmentAvtivities(
      color: Colors.red,
      label: "Hobby",
      key: "entertainment",
      category: "Hobby / Entertainment",
      description:
          "These are the activities that somehow involve in a hobby."),
  learningActivities(
      color: Colors.green,
      label: "Study",
      key: "learning",
      category: "Study / Learning & development",
      description:
          "These are the activities that somehow involve in learning and development."),
  workActivities(
      color: Colors.orange,
      label: "Work",
      key: "work",
      category: "Work & Chores",
      description:
          "These are the activities that somehow involve working or doing chroes."),
  socialActivities(
      color: Colors.purple,
      label: "Social",
      key: "social",
      category: "Social / Social & person",
      description:
          "These are the activities that somehow involve social activities and personal activities.");

  const EnumActivitiesGroup(
      {required this.color,
      required this.label,
      required this.key,
      required this.category,
      required this.description});

  final Color color;
  final String label;
  final String key;
  final String category;
  final String description;
}

class ActivityChartComponent extends StatefulWidget {
  // final
  final List<String> activities;

  ActivityChartComponent({super.key, required this.activities});

  @override
  State<ActivityChartComponent> createState() => _ActivityChartComponentState();
}

class _ActivityChartComponentState extends State<ActivityChartComponent> {
  GeminyService gemini = GeminyService();
  late Future<GroupClass> data;
  ActivityQueryClass activityClass = ActivityQueryClass();

  Set<Activities> selection = <Activities>{
    Activities.hobby,
    Activities.sport,
    Activities.social,
    Activities.study,
    Activities.work
  };

  @override
  void initState() {
    data = gemini.groupActivities(widget.activities);
     data.then(activityClass.createChartData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: data,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return Text("Data not provided");
            } else {
              return MessageActivityQueryComponent(activityClass: activityClass);
            }
          } else {
            return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Card(
                  child: SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "Loading data",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 26),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(),
                        ),
                        //TODO put loading here
                        // Center(child: Lottie.asset("lib/images/loading_component.json")),
                      ],
                    ),
                  ),
                ));
          }
        });
  }

  Widget _multipleSelectionActivities() {
    return SegmentedButton<Activities>(
      // style: ButtonStyle(maximumSize: WidgetStateProperty.all(Size(50, 50)), minimumSize: WidgetStateProperty.all(Size(50, 50),), textStyle: WidgetStateProperty.all(TextStyle(fontSize: 20)) ),
      segments: const <ButtonSegment<Activities>>[
        ButtonSegment<Activities>(
            value: Activities.sport, label: Text('Sport')),
        ButtonSegment<Activities>(
            value: Activities.hobby, label: Text('Hobby')),
        ButtonSegment<Activities>(
            value: Activities.study, label: Text('Study')),
        ButtonSegment<Activities>(
          value: Activities.work,
          label: Text('Work'),
        ),
        // ButtonSegment<Activities>(value: Activities.social, label: Text('Social')),
      ],
      selected: selection,
      onSelectionChanged: (Set<Activities> newSelection) {
        setState(() {
          selection = newSelection;
        });
      },
      multiSelectionEnabled: true,
    );
  }
}


class MessageActivityQueryComponent extends StatefulWidget {
  final ActivityQueryClass activityClass;

  const MessageActivityQueryComponent(
      {super.key,
      required this.activityClass});

  @override
  State<MessageActivityQueryComponent> createState() => _MessageActivityQueryComponent();
}

class _MessageActivityQueryComponent extends State<MessageActivityQueryComponent> {
  ActivityQueryClass activityClass = ActivityQueryClass();

  @override
  initState() {
    activityClass = widget.activityClass;
  }

  openModalFor(Activities label) {
    String current_category = "";
    String current_explaination = "";
    List<String> current_list = [];
    switch (label) {
      case Activities.sport:
        current_category = EnumActivitiesGroup.pyshicalActivities.category;
        current_explaination = EnumActivitiesGroup.pyshicalActivities.description;
        current_list = activityClass.groupClass!.pyshicalActivities!;
      case Activities.hobby:
        current_category = EnumActivitiesGroup.entertainmentAvtivities.category;
        current_explaination =EnumActivitiesGroup.entertainmentAvtivities.description;
        current_list = activityClass.groupClass!.entertainment!;
      case Activities.study:
        current_category = EnumActivitiesGroup.learningActivities.category;
        current_explaination = EnumActivitiesGroup.learningActivities.description;
        current_list = activityClass.groupClass!.learningDevelopment!;
      case Activities.work:
        current_category = EnumActivitiesGroup.workActivities.category;
        current_explaination =EnumActivitiesGroup.workActivities.description;
        current_list = activityClass.groupClass!.workChores!;
      case Activities.social:
        current_category = EnumActivitiesGroup.socialActivities.category;
        current_explaination = EnumActivitiesGroup.socialActivities.description;
        current_list = activityClass.groupClass!.socialPerson!;
    }
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          // height: 400,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  current_category,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(current_explaination),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text("Your ${current_category} are:",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400)),
                    Wrap(
                      children: List<Widget>.generate(
                        current_list.length,
                        (int idx) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Chip(
                              shape: StadiumBorder(side: BorderSide()),
                              label: Text(current_list[idx]),
                            ),
                          );
                        },
                      ).toList(),
                    )
                  ],
                )),
                IconButton.filledTonal(
                  icon: Icon(Icons.close),
                  color: Colors.red,
                  // child: const Text('Close'),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Card(
                    child: SizedBox(
                        child: Column(children: [
                      Text(
                        "Activities",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 26),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            "Check how your time is distribuited among activities!"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // _multipleSelectionActivities(),
                      // SizedBox(height: 20,),
                      SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(
                              minimum: 0,
                              maximum: activityClass.maxValue!,
                              interval: activityClass.interval),
                          // tooltipBehavior: _tooltip,
                          series: <CartesianSeries<ChartDataActivities, String>>[
                            ColumnSeries<ChartDataActivities, String>(
                              dataSource: activityClass.chartData,
                              xValueMapper: (ChartDataActivities data, _) => data.x,
                              yValueMapper: (ChartDataActivities data, _) => data.y,
                              pointColorMapper: (ChartDataActivities data, _) => data.c,
                              // yAxisName: "Number of activities",
                              // enableTooltip: true,
                              // dataLabelMapper: (ChartData data, _) => data.x,
                            )
                            // name: 'Gold',
                            // color: (ChartData data, _) => data.c)
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                    backgroundColor: EnumActivitiesGroup.pyshicalActivities.color),
                                onPressed: () => {
                                  setState(() {
                                    openModalFor(
                                        Activities.sport);
                                  })
                                },
                                child: Text(EnumActivitiesGroup.pyshicalActivities.label),
                              )),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: FilledButton(
                                  style: FilledButton.styleFrom(
                                      backgroundColor: EnumActivitiesGroup.entertainmentAvtivities.color),
                                  onPressed: () => {
                                        setState(() {
                                          openModalFor(
                                              Activities.hobby);
                                        })
                                      },
                                  child: Text(EnumActivitiesGroup.entertainmentAvtivities.label))),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: FilledButton(
                                  style: FilledButton.styleFrom(
                                      backgroundColor: EnumActivitiesGroup.learningActivities.color),
                                  onPressed: () => {
                                        setState(() {
                                          openModalFor(
                                              Activities.study);
                                        })
                                      },
                                  child: Text(EnumActivitiesGroup.learningActivities.label))),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: FilledButton(
                                  style: FilledButton.styleFrom(
                                      backgroundColor: EnumActivitiesGroup.workActivities.color),
                                  onPressed: () => {
                                        setState(() {
                                          openModalFor(
                                              Activities.work);
                                        })
                                      },
                                  child: Text(
                                    EnumActivitiesGroup.workActivities.label,
                                    style: TextStyle(color: Colors.black),
                                  ))),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: FilledButton(
                                  style: FilledButton.styleFrom(
                                      backgroundColor: EnumActivitiesGroup.socialActivities.color),
                                  onPressed: () => {
                                        setState(() {
                                          openModalFor(Activities.social);
                                        })
                                      },
                                  child: Text(EnumActivitiesGroup.socialActivities.label))),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      )
                    ])),
                  ));
  }

}