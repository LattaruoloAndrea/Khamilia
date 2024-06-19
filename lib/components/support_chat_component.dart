import 'package:flutter/material.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:lottie/lottie.dart';

class SupportChatComponent extends StatelessWidget {
  final SupportClass message;
  const SupportChatComponent({super.key, required this.message});

  openTutorial() {
    //TODO add tutorial
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
- Set periodic activities that no ones wants to fill every day\n
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
