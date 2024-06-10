import 'package:flutter/material.dart';

class UserInputChat extends StatelessWidget {
  final TextEditingController controller;
  final onPressed;
  final onPressedMic;
  bool showMic = true;

  UserInputChat(
      {super.key,
      required this.controller,
      required this.onPressed,
      required this.onPressedMic});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: controller,
            onChanged: (value) =>{
              print("sdasdasdasd"),
              if (controller.text.isNotEmpty)
                {showMic = false}
              else
                {showMic = true}
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                fillColor: Colors.grey.shade400,
                filled: true,
                hintText: "Send message",
                hintStyle: TextStyle(color: Colors.grey[600])),
          ),
        )),
        Container(
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.only(right: 20),
          child: Center(
              child: showMic
                  ? IconButton(
                      onPressed: onPressedMic,
                      icon: Icon(
                        Icons.mic,
                        color: Colors.white,
                      ))
                  : IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                      ))),
        )
      ],
    );
  }
}
