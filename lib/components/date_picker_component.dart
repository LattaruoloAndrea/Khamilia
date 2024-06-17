import 'package:flutter/material.dart';
import 'package:gemini_app/services/current_day_service.dart';

class DatePickerComponent extends StatefulWidget {
  const DatePickerComponent({super.key,required this.restorationId,required this.controller,required this.label});
  final TextEditingController controller;
  final String label;
  final String? restorationId;

  @override
  State<DatePickerComponent> createState() => _DatePickerComponentState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _DatePickerComponentState extends State<DatePickerComponent>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;
  RestorableDateTime? _selectedDate;
  DateTime? initialTime;

  @override
  void initState() {
    if(widget.controller.text.isNotEmpty){
        _selectedDate = RestorableDateTime(DateTime.parse(widget.controller.text));
        initialTime = DateTime.parse(widget.controller.text);
        print(widget.controller.text);
    }
  }


  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate!.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: CurrentDayService().currentDate(),
          firstDate: DateTime(2024,6,01),
          lastDate: CurrentDayService().currentDate(),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate!, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate!.value = newSelectedDate;
        widget.controller.text = '${_selectedDate!.value.year}-${_selectedDate!.value.month}-${_selectedDate!.value.day}';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate!.value.year}-${_selectedDate!.value.month}-${_selectedDate!.value.day}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
        return TextField(
        controller: widget.controller,
        decoration: InputDecoration(
            icon: Icon(Icons.calendar_today),
            labelText: widget.label
            ),
        readOnly: true,
        onTap: () async {
            _restorableDatePickerRouteFuture.present();
        });
  }
}
