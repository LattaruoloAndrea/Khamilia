import 'package:flutter/material.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:lottie/lottie.dart';

class ErrorChatComponent extends StatelessWidget {
  const ErrorChatComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "This is embarassing...",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text("""Looks like I couldn't understand what you said! Try to reformulate the sentence or ask for help to see if you are executing the correct task!
              """),
        ),

        // Center(child: Lottie.asset("lib/images/help.json")),
        // SizedBox(
        //   height: 10,
        // ),
      ],
    );
  }
}
