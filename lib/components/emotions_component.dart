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

class EmotionsValue{
  EmotionsValue(this.emotion,this.value,this.color);
  final String emotion;
  final int value;
  final Color color; 
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
  final Color basicColor = Colors.blue;
  final Color socialColor = Colors.red;
  final Color cognitiveColor = Colors.green;
  final Color pyshicalColor = Colors.orange;
  final Color complexColor = Colors.purple;
  final String basicLabel = "Basic";
  final String socialLabel = "Social";
  final String cognitiveLabel = "Cognitive";
  final String pyshicalLabel = "Pyshical";
  final String complexLabel = "Complex";
  List<String> basicEmotions = [];
  List<String> socialEmotions = [];
  List<String> cognitiveEmotions = [];
  List<String> pyshicalEmotions = [];
  List<String> complexEmotions = [];
  List<EmotionsValue> allEmotions = [];
  double score = 0;

  @override
  void initState() {
    data = gemini.categolizeListOfEmotions(widget.emotions);
  }

  List<ChartData> createChartData(List<EmotionEvaluationClass> emotionsList) {
    basicEmotions = [];
    socialEmotions = [];
    cognitiveEmotions = [];
    pyshicalEmotions = [];
    complexEmotions = [];
    allEmotions = [];
    score = 0;
    for (int i = 0; i < emotionsList.length; i++) {
      score+= emotionsList[i].evaluation!;
      Color c = Colors.transparent;
      switch (emotionsList[i].category) {
        case 'Basic Emotion':
          basicEmotions.add(emotionsList[i].emotion!);
          c = basicColor;
        case 'Social Emotion':
          socialEmotions.add(emotionsList[i].emotion!);
          c = socialColor;
        case 'Cognitive Emotion':
          cognitiveEmotions.add(emotionsList[i].emotion!);
          c = cognitiveColor;
        case 'Pyshical Emotion':
          basicEmotions.add(emotionsList[i].emotion!);
          c = pyshicalColor;
        case 'Complex Emotion':
          complexEmotions.add(emotionsList[i].emotion!);
          c = complexColor;
      }
      allEmotions.add(EmotionsValue(emotionsList[i].emotion!,emotionsList[i].evaluation!,c));
    }
    score = score/emotionsList.length;
    List<ChartData> chartData = [
      ChartData(basicLabel, basicEmotions.length, basicColor),
      ChartData(socialLabel, socialEmotions.length, socialColor),
      ChartData(cognitiveLabel, cognitiveEmotions.length, cognitiveColor),
      ChartData(pyshicalLabel, pyshicalEmotions.length, pyshicalColor),
      ChartData(complexLabel, complexEmotions.length, complexColor)
    ];
    return chartData;
  }

  openListEmotions() {
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
                  "Your emotion score is: ${score.toStringAsFixed(1)}",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("To every emotion is given a score from 1-10 and the averege is given as emotional score.Where 1 is a negative emotion 5 is neutral and 10 is positive emotion."),
                ),
                SizedBox(height: 20,),
                Expanded(
                    child: Column(
                      
                  children: [
                    Text("These are all your emotions:",
                    // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400)),
                    Wrap(
                      children: List<Widget>.generate(
                        allEmotions.length,
                        (int idx) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Chip(
                              backgroundColor: allEmotions[idx].color,
                              avatar: CircleAvatar(backgroundColor: Colors.transparent, child: Text('${allEmotions[idx].value}'),),
                              shape: StadiumBorder(side: BorderSide()),
                              label: Text(allEmotions[idx].emotion),
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
                SizedBox(height: 20,)
              ],
            ),
          ),
        );
      },
    );
  }

  openModalFor(String category) {
    String current_category = "";
    String current_explaination = "";
    List<String> current_list = [];
    switch (category) {
      case "Basic":
        current_category = "Basic emotions";
        current_explaination =
            " These are considered universal and innate, often arising from biological and evolutionary processes. They are usually experienced in a more intense and immediate way.";
        current_list = basicEmotions;
      case 'Social':
        current_category = "Social emotions";
        current_explaination =
            "These are heavily influenced by our interactions with others and are tied to our social roles and relationships. They reflect our social needs and how we navigate social situations.";
        current_list = socialEmotions;
      case 'Cognitive':
        current_category = "Cognitive emotions";
        current_explaination =
            "These arise from our thoughts, beliefs, and interpretations of situations. They are often associated with our mental processes and how we perceive the world around us.";
        current_list = cognitiveEmotions;
      case 'Pyshical':
        current_category = "Pyshical emotions";
        current_explaination =
            "These are closely tied to our bodily sensations and physiological responses. They can be triggered by external stimuli or internal states and often involve physical changes like heart rate, breathing, or muscle tension.";
        current_list = pyshicalEmotions;
      case 'Complex':
        current_category = "Complex emotions";
        current_explaination =
            "These are multifaceted and often involve a combination of other emotions. They can be nuanced and difficult to categorize, frequently reflecting a blend of feelings.";
        current_list = complexEmotions;
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
                SizedBox(height: 20,)
              ],
            ),
          ),
        );
      },
    );
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            "Check your emotion score and your emotions categorizations!"),
                      ),
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
                                    score.toStringAsFixed(1),
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
                                  onPressed: () => openModalFor(basicLabel),
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
                                  onPressed: () => openModalFor(socialLabel),
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
                                  onPressed: () => openModalFor(cognitiveLabel),
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
                                  onPressed: () => openModalFor(pyshicalLabel),
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
                                  onPressed: () => openModalFor(complexLabel),
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
