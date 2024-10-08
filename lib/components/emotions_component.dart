import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/loading_component.dart';
import 'package:gemini_app/components/message_class.dart';
// import 'package:gemini_app/components/shimmering_component.dart';
import 'package:gemini_app/services/gemini_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:lottie/lottie.dart';

enum EnumEmotionsCategorize {
  basicEmotion(
      color: Colors.blue,
      label: "Basic",
      key: "Basic Emotion",
      description:
          " These are considered universal and innate, often arising from biological and evolutionary processes. They are usually experienced in a more intense and immediate way."),
  socialEmotion(
      color: Colors.red,
      label: "Social",
      key: "Social Emotion",
      description:
          "These are heavily influenced by our interactions with others and are tied to our social roles and relationships. They reflect our social needs and how we navigate social situations."),
  cognitiveEmotion(
      color: Colors.green,
      label: "Cognitive",
      key: "Cognitive Emotion",
      description:
          "These arise from our thoughts, beliefs, and interpretations of situations. They are often associated with our mental processes and how we perceive the world around us."),
  pyshicalEmotion(
      color: Colors.orange,
      label: "Pyshical",
      key: "Pyshical Emotion",
      description:
          "These are closely tied to our bodily sensations and physiological responses. They can be triggered by external stimuli or internal states and often involve physical changes like heart rate, breathing, or muscle tension."),
  complexEmotion(
      color: Colors.purple,
      label: "Complex",
      key: "Complex Emotion",
      description:
          "These are multifaceted and often involve a combination of other emotions. They can be nuanced and difficult to categorize, frequently reflecting a blend of feelings.");

  const EnumEmotionsCategorize(
      {required this.color,
      required this.label,
      required this.key,
      required this.description});

  final Color color;
  final String label;
  final String key;
  final String description;
}

class EmotionsValue {
  EmotionsValue(this.emotion, this.value, this.color);
  final String emotion;
  final int value;
  final Color? color;
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
  EmotionQueryClass emotionClass = EmotionQueryClass();

  @override
  void initState() {
    data = gemini.categolizeListOfEmotions(widget.emotions);
    data.then(emotionClass.createChartData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: data,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // if (false) {
            if (snapshot.data == null) {
              return Text("Data not provided");
            } else {
              return MessageEmotionsQueryComponent(
                emotionClass: emotionClass,
              );
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
}

class MessageEmotionsQueryComponent extends StatefulWidget {
  final EmotionQueryClass emotionClass;

  const MessageEmotionsQueryComponent(
      {super.key,
      required this.emotionClass});

  @override
  State<MessageEmotionsQueryComponent> createState() => _MessageEmotionsQueryComponent();
}

class _MessageEmotionsQueryComponent extends State<MessageEmotionsQueryComponent> {
  EmotionQueryClass emotionClass = EmotionQueryClass();

  @override
  initState() {
    emotionClass = widget.emotionClass;
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
                  "Your emotion score is: ${emotionClass.score!.toStringAsFixed(1)}",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                      "To every emotion is given a score from 1-10 and the averege is given as emotional score.Where 1 is a negative emotion 5 is neutral and 10 is positive emotion."),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text("These are all your emotions:",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400)),
                    Wrap(
                      children: List<Widget>.generate(
                        emotionClass.allEmotions!.length,
                        (int idx) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Chip(
                              backgroundColor: emotionClass.allEmotions![idx].color,
                              avatar: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Text('${emotionClass.allEmotions![idx].value}'),
                              ),
                              shape: StadiumBorder(side: BorderSide()),
                              label: Text(emotionClass.allEmotions![idx].emotion),
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

  openModalFor(String category) {
    String current_category = "";
    String current_explaination = "";
    List<String> current_list = [];
    switch (category) {
      case "Basic":
        current_category = EnumEmotionsCategorize.basicEmotion.key;
        current_explaination = EnumEmotionsCategorize.basicEmotion.description;
        current_list = emotionClass.basicEmotions!;
      case 'Social':
        current_category = EnumEmotionsCategorize.socialEmotion.key;
        current_explaination = EnumEmotionsCategorize.socialEmotion.description;
        current_list = emotionClass.socialEmotions!;
      case 'Cognitive':
        current_category = EnumEmotionsCategorize.cognitiveEmotion.key;
        current_explaination =
            EnumEmotionsCategorize.cognitiveEmotion.description;
        current_list = emotionClass.cognitiveEmotions!;
      case 'Pyshical':
        current_category = EnumEmotionsCategorize.pyshicalEmotion.key;
        current_explaination =
            EnumEmotionsCategorize.pyshicalEmotion.description;
        current_list = emotionClass.pyshicalEmotions!;
      case 'Complex':
        current_category = EnumEmotionsCategorize.complexEmotion.key;
        current_explaination =
            EnumEmotionsCategorize.complexEmotion.description;
        current_list = emotionClass.complexEmotions!;
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
            child: Column(
              children: [
                Text(
                  "Emotions",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
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
                          RadialBarSeries<ChartDataEmotions, String>(
                              useSeriesColor: true,
                              trackOpacity: 0.2,
                              dataSource: emotionClass.chartData,
                              xValueMapper: (ChartDataEmotions data, _) => data.x,
                              yValueMapper: (ChartDataEmotions data, _) => data.y,
                              pointColorMapper: (ChartDataEmotions data, _) => data.c,
                              innerRadius: '40%',
                              cornerStyle: CornerStyle.bothCurve)
                        ])),
                    Padding(
                      padding: EdgeInsets.only(right: 10, top: 50),
                      child: FloatingActionButton(
                        heroTag: emotionClass.floatingHeroTag,
                        onPressed: openListEmotions,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(Icons.stay_primary_portrait_outlined),
                            Text(
                              emotionClass.score!.toStringAsFixed(1),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26),
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
                Wrap(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor:
                                  EnumEmotionsCategorize.basicEmotion.color),
                          onPressed: () => {
                            openModalFor(
                                EnumEmotionsCategorize.basicEmotion.label)
                          },
                          child:
                              Text(EnumEmotionsCategorize.basicEmotion.label),
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor:
                                    EnumEmotionsCategorize.socialEmotion.color),
                            onPressed: () => {
                                  openModalFor(EnumEmotionsCategorize
                                      .socialEmotion.label)
                                },
                            child: Text(
                                EnumEmotionsCategorize.socialEmotion.label))),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: EnumEmotionsCategorize
                                    .cognitiveEmotion.color),
                            onPressed: () => {
                                  openModalFor(EnumEmotionsCategorize
                                      .cognitiveEmotion.label)
                                },
                            child: Text(EnumEmotionsCategorize
                                .cognitiveEmotion.label))),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: EnumEmotionsCategorize
                                    .pyshicalEmotion.color),
                            onPressed: () => {
                                  openModalFor(EnumEmotionsCategorize
                                      .pyshicalEmotion.label)
                                },
                            child: Text(
                              EnumEmotionsCategorize.pyshicalEmotion.label,
                              style: TextStyle(color: Colors.black),
                            ))),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: EnumEmotionsCategorize
                                    .complexEmotion.color),
                            onPressed: () => {
                                  openModalFor(EnumEmotionsCategorize
                                      .complexEmotion.label)
                                },
                            child: Text(
                                EnumEmotionsCategorize.complexEmotion.label))),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
