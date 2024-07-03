import 'package:flutter/material.dart';

class ActivitiesPeriodicSelectButton extends StatefulWidget {
  final Function()? onTap;
  final bool? activity;
  const ActivitiesPeriodicSelectButton({super.key, this.onTap, this.activity});

  @override
  State<ActivitiesPeriodicSelectButton> createState() =>
      _ActivitiesPeriodicSelectButtonState();
}

enum Type { activities, periodic }

class _ActivitiesPeriodicSelectButtonState
    extends State<ActivitiesPeriodicSelectButton> {
  Type typeView = Type.activities;

  @override
  initState() {
    if (widget.activity!) {
      typeView = Type.activities;
    } else {
      typeView = Type.periodic;
    }
  }

  changepage() {
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SegmentedButton<Type>(
          segments: const <ButtonSegment<Type>>[
            ButtonSegment<Type>(
                value: Type.activities, label: Text('Activities')),
            ButtonSegment<Type>(
              value: Type.periodic,
              label: Text('Periodic'),
            ),
          ],
          selected: <Type>{typeView},
          onSelectionChanged: (Set<Type> newSelection) {
            setState(() {
              typeView = newSelection.first;
              changepage();
            });
          },
        ));
  }
}
