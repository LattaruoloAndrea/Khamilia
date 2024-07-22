import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserInputChatMic extends StatefulWidget {
  final TextEditingController controller;
  final onPressed;
  final onPressedMic;

  UserInputChatMic(
      {super.key,
      required this.controller,
      required this.onPressed,
      required this.onPressedMic});

  @override
  State<UserInputChatMic> createState() => _UserInputChatMicState();
}

class _UserInputChatMicState extends State<UserInputChatMic> {
  bool showMic = true;

  sendText() {
    setState(() {
      showMic = true;
    });
    widget.onPressed();
  }

  sendVocal(){
    setState(() {
      showMic = true;
      
    });
    widget.onPressedMic();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: widget.controller,
            onChanged: (value) => setState(() {
              if (widget.controller.text.isNotEmpty) {
                showMic = false;
              } else {
                showMic = true;
              }
            }),
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
                      onPressed: () => sendVocal(),
                      icon: Icon(
                        Icons.mic,
                        color: Colors.white,
                      ))
                  : IconButton(
                      onPressed: ()=>sendText(),
                      icon: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ))),
        )
      ],
    );
  }
}
