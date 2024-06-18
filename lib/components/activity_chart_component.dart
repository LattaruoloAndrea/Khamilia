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

class ChartData {
  ChartData(this.x, this.y, this.c);
  final String x;
  final int y;
  final Color c;
}

class EmotionsValue {
  EmotionsValue(this.emotion, this.value, this.color);
  final String emotion;
  final int value;
  final Color? color;
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
  final Color physicalColor = Colors.blue;
  final Color entertainmentColor = Colors.red;
  final Color learningColor = Colors.green;
  final Color workColor = Colors.orange;
  final Color socialColor = Colors.purple;
  final String physicalLabel = "Sports";
  final String entertainmentLabel = "Hobby";
  final String learningLabel = "Study";
  final String workLabel = "Work";
  final String socialLabel = "Social";
  double max_value = 10;
  double interval = 5;
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
  }

  double _max(List<int> values) {
    double v = 0;
    for (int i = 0; i < values.length; i++) {
      if (values[i] > v) {
        v = values[i].toDouble();
      }
    }
    return v;
  }

  openModalFor(Activities label, GroupClass grouping){
    String current_category = "";
    String current_explaination = "";
    List<String> current_list = [];
    switch (label) {
      case Activities.sport:
        current_category = "Sports / Physical activities";
        current_explaination =
            "These are the activities that somehow involve in a physical activity.";
        current_list = grouping.pyshicalActivities!;
      case Activities.hobby:
        current_category = "Hobby / Entertainment";
        current_explaination =
            "These are the activities that somehow involve in a hobby.";
        current_list = grouping.entertainment!;
      case Activities.study:
        current_category = "Study / Learning & development";
        current_explaination =
            "These are the activities that somehow involve in learning and development.";
        current_list = grouping.learningDevelopment!;
      case Activities.work:
        current_category = "Work & Chores";
        current_explaination =
            "These are the activities that somehow involve working or doing chroes.";
        current_list = grouping.workChores!;
      case Activities.social:
        current_category = "Social / Social & person";
        current_explaination =
            "These are the activities that somehow involve social activities and personal activities.";
        current_list = grouping.socialPerson!;
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

  List<ChartData> createChartData(GroupClass activitiesList) {
    max_value = 2 +
        _max([
          activitiesList.pyshicalActivities!.length,
          activitiesList.entertainment!.length,
          activitiesList.learningDevelopment!.length,
          activitiesList.workChores!.length,
          activitiesList.socialPerson!.length
        ]);
    List<ChartData> chartData = [
      ChartData(physicalLabel, activitiesList.pyshicalActivities!.length,
          physicalColor),
      ChartData(entertainmentLabel, activitiesList.entertainment!.length,
          entertainmentColor),
      ChartData(learningLabel, activitiesList.learningDevelopment!.length,
          learningColor),
      ChartData(workLabel, activitiesList.workChores!.length, workColor),
      ChartData(socialLabel, activitiesList.socialPerson!.length, socialColor),
    ];
    if (max_value < 20) {
      interval = 1;
    } else if (max_value < 50) {
      interval = 5;
    } else if (max_value < 100) {
      interval = 10;
    }
    return chartData;
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
              return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Card(
                    child: SizedBox(
                      child: Column(
                        children: [
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
                                  maximum: max_value,
                                  interval: interval),
                              // tooltipBehavior: _tooltip,
                              series: <CartesianSeries<ChartData, String>>[
                                ColumnSeries<ChartData, String>(
                                  dataSource: createChartData(snapshot.data!),
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                  pointColorMapper: (ChartData data, _) =>
                                      data.c,
                                  // yAxisName: "Number of activities",
                                  // enableTooltip: true,
                                  // dataLabelMapper: (ChartData data, _) => data.x,
                                )
                                // name: 'Gold',
                                // color: (ChartData data, _) => data.c)
                              ]),
                          SizedBox(height: 40,),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: FloatingActionButton(
                                    heroTag: "Objct1",
                                      onPressed: () => openModalFor(Activities.sport,snapshot.data!),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: physicalColor),
                                            height: 30,
                                            width: 30,
                                          ),
                                          Text(
                                            physicalLabel,
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: FloatingActionButton(
                                    heroTag: "Objct2",
                                      onPressed: () =>
                                          openModalFor(Activities.hobby,snapshot.data!),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: entertainmentColor),
                                            height: 30,
                                            width: 30,
                                          ),
                                          Text(
                                            entertainmentLabel,
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: FloatingActionButton(
                                    heroTag: "Objct3",
                                      onPressed: () =>
                                          openModalFor(Activities.study,snapshot.data!),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: learningColor),
                                            height: 30,
                                            width: 30,
                                          ),
                                          Text(
                                            learningLabel,
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: FloatingActionButton(
                                    heroTag: "Objct4",
                                      onPressed: () =>
                                          openModalFor(Activities.work,snapshot.data!),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: workColor),
                                            height: 30,
                                            width: 30,
                                          ),
                                          Text(
                                            workLabel,
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: FloatingActionButton(
                                    heroTag: "Objct5",
                                      onPressed: () =>
                                          openModalFor(Activities.social,snapshot.data!),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: socialColor),
                                            height: 30,
                                            width: 30,
                                          ),
                                          Text(
                                            socialLabel,
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ));
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
