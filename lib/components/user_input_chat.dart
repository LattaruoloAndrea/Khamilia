import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserInputChat extends StatefulWidget {
  final TextEditingController controller;
  final onPressed;

  UserInputChat(
      {super.key,
      required this.controller,
      required this.onPressed});

  @override
  State<UserInputChat> createState() => _UserInputChatState();
}

class _UserInputChatState extends State<UserInputChat> {
  bool validText = true;

  sendText() {
    setState(() {
      validText = true;
    });
    widget.onPressed();
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
              if (widget.controller.text.isEmpty) {
                validText = false;
              } else {
                validText = true;
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
              child: IconButton(
                      onPressed: validText?  ()=>sendText() : null,
                      disabledColor: Colors.grey,
                      icon: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ))),
        )
      ],
    );
  }
}
