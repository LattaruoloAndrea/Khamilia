import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/activity_chart_component.dart';
import 'package:gemini_app/components/emotions_component.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/services/db_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ActivityPageComponent extends StatefulWidget {
  // final
  String startDate;
  String endDate;
  EmotionCategorizeClass emotions;
  GroupClass groups;

  ActivityPageComponent(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.groups,
      required this.emotions});

  @override
  State<ActivityPageComponent> createState() => _ActivityPageComponentState();
}

class _ActivityPageComponentState extends State<ActivityPageComponent> {
  DbService db = DbService();
  late EmotionCategorizeClass emotions;
  late GroupClass groups;
  late String dateStart;
  late String dateEnd;

  @override
  void initState() {
    emotions = widget.emotions;
    groups = widget.groups;
    dateStart = widget.startDate;
    dateEnd = widget.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              dateStart == dateEnd
                  ? Text(
                      'On ${dateStart}',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                    )
                  : Text('From: ${dateStart}, to ${dateEnd}',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 22)),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //TODO 
          // emotions.listEmotions!.length > 0
          //     ? EmotionsComponentForMessage(emotions: emotions)
          //     : SizedBox(),
          SizedBox(
            height: 20,
          ),
          ActivityComponentForMessage(activities: groups),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

// class EmotionsComponentForMessage extends StatelessWidget {
//   final EmotionCategorizeClass emotions;
//   EmotionsComponentForMessage({super.key, required this.emotions});
//   List<String> basicEmotions = [];
//   List<String> socialEmotions = [];
//   List<String> cognitiveEmotions = [];
//   List<String> pyshicalEmotions = [];
//   List<String> complexEmotions = [];
//   List<EmotionsValue> allEmotions = [];
//   double score = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 20,
//                   ),
//                   child: Card(
//                     child: SizedBox(
//                       child: Column(
//                         children: [
//                           Text(
//                             "Emotions",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w600, fontSize: 26),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20),
//                             child: Divider(),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20),
//                             child: Text(
//                                 "Check your emotion score and your emotions categorizations!"),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                   child: SfCircularChart(
//                                       // backgroundImage: AssetImage("./lib/images/flamingo_screen.png"),
//                                       series: <CircularSeries>[
//                                     // Renders radial bar chart
//                                     RadialBarSeries<ChartData, String>(
//                                         useSeriesColor: true,
//                                         trackOpacity: 0.2,
//                                         dataSource: createChartData(
//                                             snapshot.data!.listEmotions!),
//                                         xValueMapper: (ChartData data, _) =>
//                                             data.x,
//                                         yValueMapper: (ChartData data, _) =>
//                                             data.y,
//                                         pointColorMapper: (ChartData data, _) =>
//                                             data.c,
//                                         innerRadius: '40%',
//                                         cornerStyle: CornerStyle.bothCurve)
//                                   ])),
//                               Padding(
//                                 padding: EdgeInsets.only(right: 10, top: 50),
//                                 child: FloatingActionButton(
//                                   heroTag: "Objct6",
//                                   onPressed: openListEmotions,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       // Icon(Icons.stay_primary_portrait_outlined),
//                                       Text(
//                                         score.toStringAsFixed(1),
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 26),
//                                         textAlign: TextAlign.center,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               )
//                             ],
//                           ),
//                           Wrap(
//                             children: [
//                               Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 5),
//                                   child: FilledButton(
//                                     style: FilledButton.styleFrom(
//                                         backgroundColor: EnumEmotionsCategorize.basicEmotion.color),
//                                     onPressed: () => {
//                                       setState(() {
//                                         openModalFor(EnumEmotionsCategorize.basicEmotion.label);
//                                       })
//                                     },
//                                     child: Text(EnumEmotionsCategorize.basicEmotion.label),
//                                   )),
//                               Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 5),
//                                   child: FilledButton(
//                                       style: FilledButton.styleFrom(
//                                           backgroundColor: EnumEmotionsCategorize.socialEmotion.color),
//                                       onPressed: () => {
//                                             setState(() {
//                                               openModalFor(EnumEmotionsCategorize.socialEmotion.label);
//                                             })
//                                           },
//                                       child: Text(EnumEmotionsCategorize.socialEmotion.label))),
//                               Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 5),
//                                   child: FilledButton(
//                                       style: FilledButton.styleFrom(
//                                           backgroundColor: EnumEmotionsCategorize.cognitiveEmotion.color),
//                                       onPressed: () => {
//                                             setState(() {
//                                               openModalFor(EnumEmotionsCategorize.cognitiveEmotion.label);
//                                             })
//                                           },
//                                       child: Text(EnumEmotionsCategorize.cognitiveEmotion.label))),
//                               Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 5),
//                                   child: FilledButton(
//                                       style: FilledButton.styleFrom(
//                                           backgroundColor: EnumEmotionsCategorize.pyshicalEmotion.color),
//                                       onPressed: () => {
//                                             setState(() {
//                                               openModalFor(EnumEmotionsCategorize.pyshicalEmotion.label);
//                                             })
//                                           },
//                                       child: Text(
//                                         EnumEmotionsCategorize.pyshicalEmotion.label,
//                                         style: TextStyle(color: Colors.black),
//                                       ))),
//                               Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 5),
//                                   child: FilledButton(
//                                       style: FilledButton.styleFrom(
//                                           backgroundColor: EnumEmotionsCategorize.complexEmotion.color),
//                                       onPressed: () => {
//                                             setState(() {
//                                               openModalFor(EnumEmotionsCategorize.complexEmotion.label);
//                                             })
//                                           },
//                                       child: Text(EnumEmotionsCategorize.complexEmotion.label))),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ));
//   }
// }


class ActivityComponentForMessage extends StatelessWidget {
  final GroupClass activities;
  const ActivityComponentForMessage({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Text("Activities");
  }
}
