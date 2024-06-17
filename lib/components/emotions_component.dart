import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/loading_component.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/services/gemini_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y, this.c);
  final String x;
  final int y;
  final Color c;
}

class EmotionsComponent extends StatefulWidget {
  // final
  List<String> emotions;

  EmotionsComponent({super.key, required this.emotions});

  @override
  State<EmotionsComponent> createState() => _EmotionsComponentState();
}

class _EmotionsComponentState extends State<EmotionsComponent> {
  GeminyService gemini = GeminyService();
  late Future<EmotionCategorizeClass> data;
  Color basicColor = Colors.blue;
  Color socialColor = Colors.red;
  Color cognitiveColor = Colors.green;
  Color pyshicalColor = Colors.orange;
  Color complexColor = Colors.purple;
  String basicLabel = "Basic";
  String socialLabel = "Social";
  String cognitiveLabel = "Cognitive";
  String pyshicalLabel = "Pyshical";
  String complexLabel = "Complex";

  @override
  void initState() {
    data = gemini.categolizeListOfEmotions(widget.emotions);
  }

  List<ChartData> createChartData(List<EmotionEvaluationClass> emotionsList) {
    int basic = 0;
    int social = 0;
    int cognitive = 0;
    int pyshical = 0;
    int complex = 0;
    for (int i = 0; i < emotionsList.length; i++) {
      switch (emotionsList[i].category) {
        case 'Basic Emotion':
          basic += 1;
        case 'Social Emotion':
          social += 1;
        case 'Cognitive Emotion':
          cognitive += 1;
        case 'Pyshical Emotion':
          pyshical += 1;
        case 'Complex Emotion':
          complex += 1;
      }
    }
    List<ChartData> chartData = [
      ChartData(basicLabel, basic, basicColor),
      ChartData(socialLabel, social, socialColor),
      ChartData(cognitiveLabel, cognitive, cognitiveColor),
      ChartData(pyshicalLabel, pyshical, pyshicalColor),
      ChartData(complexLabel, complex, complexColor)
    ];
    return chartData;
  }

  openListEmotions() {}

  openModalFor() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: data,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return Text("Data not provided");
            } else {
              return Card(
                child: SizedBox(
                  width: 360,
                  height: 500,
                  child: Column(
                    children: [
                      Text(
                        "Emotions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 26),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(),
                      ),
                      Text(
                          "Check your emotion score and your emotions categorizations!"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: SfCircularChart(
                                  // backgroundImage: AssetImage("./lib/images/flamingo_screen.png"),
                                  series: <CircularSeries>[
                                // Renders radial bar chart
                                RadialBarSeries<ChartData, String>(
                                    useSeriesColor: true,
                                    trackOpacity: 0.2,
                                    dataSource: createChartData(
                                        snapshot.data!.listEmotions!),
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    pointColorMapper: (ChartData data, _) =>
                                        data.c,
                                    innerRadius: '40%',
                                    cornerStyle: CornerStyle.bothCurve)
                              ])),
                          Padding(
                            padding: EdgeInsets.only(right: 10, top: 50),
                            child: FloatingActionButton(
                              onPressed: openListEmotions,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon(Icons.stay_primary_portrait_outlined),
                                  Text(
                                    "7.8",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: FloatingActionButton(
                                  onPressed: openModalFor,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: basicColor),
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        basicLabel,
                                        style: TextStyle(),
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
                                  onPressed: openModalFor,
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
                                        style: TextStyle(),
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
                                  onPressed: openModalFor,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: cognitiveColor),
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        cognitiveLabel,
                                        style: TextStyle(),
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
                                  onPressed: openModalFor,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: pyshicalColor),
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        pyshicalLabel,
                                        style: TextStyle(),
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
                                  onPressed: openModalFor,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: complexColor),
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        complexLabel,
                                        style: TextStyle(),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          } else {
            return Text("LOADING EMOTIONS");
          }
        });
  }
}
