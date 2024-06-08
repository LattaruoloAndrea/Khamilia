import 'package:flutter/material.dart';

class UserInputChat extends StatelessWidget {
  final controller;
  final onPressed;
  final onPressedMic;

  const UserInputChat(
      {super.key,
      required this.controller,
      required this.onPressed,
      required this.onPressedMic});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(child: IconButton(onPressed: onPressedMic, icon: Icon(Icons.mic)),),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
                ),
                fillColor: Colors.grey.shade400,
                filled: true,
                hintText: "Send message",
                hintStyle: TextStyle(color: Colors.grey[600])),
          ),
        )),
        Center(child: IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_upward)),),
      ],
    );
  }
}
