import 'package:flutter/material.dart';

class DescriptionComponent extends StatelessWidget {
  final String description;
  final String day;
  const DescriptionComponent(
      {super.key, required this.description, required this.day});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            "The description provided for ${day}",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(description),
          ),
        ],
      ),
    );
  }
}
