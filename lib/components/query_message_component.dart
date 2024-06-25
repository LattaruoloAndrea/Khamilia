import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/activity_chart_component.dart';
import 'package:gemini_app/components/emotions_component.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/services/db_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MessageForActivityComponent extends StatefulWidget {
  // final
  QueryClassToMessage queryForMessage;

  MessageForActivityComponent({super.key, required this.queryForMessage});

  @override
  State<MessageForActivityComponent> createState() =>
      _MessageForActivityComponentState();
}

class _MessageForActivityComponentState
    extends State<MessageForActivityComponent> {
  late EmotionQueryClass emotionClass;
  late ActivityQueryClass activityClass;
  late String dateStart;
  late String dateEnd;

  @override
  void initState() {
    dateStart = widget.queryForMessage.start!;
    dateEnd = widget.queryForMessage.end!;
    emotionClass = widget.queryForMessage.emotions!;
    activityClass = widget.queryForMessage.activities!;
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
          Column(
            children: [
              Text("Retrieved data",  style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 26),
                    ),
              dateStart == dateEnd
                  ? Text(
                      'On ${dateStart}',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
                    )
                  : Text('From: ${dateStart}, to ${dateEnd}',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 11)),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //TODO
          emotionClass.allEmotions!.isNotEmpty
              ? MessageEmotionsQueryComponent(
                  emotionClass: emotionClass,
                )
              : SizedBox(),
          SizedBox(
            height: 20,
          ),
          MessageActivityQueryComponent(activityClass: activityClass),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
