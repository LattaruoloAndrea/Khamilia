import 'package:flutter/material.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/pages/tutorial_page.dart';
import 'package:lottie/lottie.dart';

class SupportChatComponent extends StatefulWidget {
  final SupportClass message;
  SupportChatComponent({required this.message});

  @override
  State<SupportChatComponent> createState() => _SupportChatComponentState();
}

class _SupportChatComponentState extends State<SupportChatComponent> {
  

  openTutorial() {
    //TODO add tutorial
        Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TutorialPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Help and support",
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
          child: Text("""These is the list of the things I can do for you:\n
- Provide a description of today or yesterday and we'll sort your activites and emotions\n
- Asks for specific data of a single day or in a between of days or visit the page activities\n
- Add activies after you provided a description you can add activities for today or yesterday\n
\n
If you have still doubs you can check the tutorial on the button below!
              """),
        ),

        // Center(child: Lottie.asset("lib/images/help.json")),
        // SizedBox(
        //   height: 10,
        // ),
        OutlinedButton(
            onPressed: openTutorial, child: const Text('Open tutorial')),
      ],
    );
  }
}
