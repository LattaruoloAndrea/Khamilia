import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/message_class.dart';

class ActivitiMessageClass extends StatefulWidget {
  final ActivitiesClass activitiesClass;

  ActivitiMessageClass(
      {super.key,
      required this.activitiesClass,
});

  @override
  State<ActivitiMessageClass> createState() => _ActivitiMessageClassState();
}

class _ActivitiMessageClassState extends State<ActivitiMessageClass> {

  removeActivity(){}

  removeEmotion(){}

  saveData(){}

  changeDay(){}

  addActivity(){}

  addEmotion(){}

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("dasdsasdsasaasdsadsad"),);
    // return Row(children: [
    //   Expanded(child: Text("Daily Activities", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),),

    // ],);
  }
}
