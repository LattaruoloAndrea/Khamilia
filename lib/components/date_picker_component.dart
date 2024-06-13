import 'package:flutter/material.dart';
import 'package:gemini_app/services/current_day_service.dart';

class DatePickerComponent extends StatefulWidget {
  const DatePickerComponent({super.key,required this.restorationId,required this.date});
  final String date;
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
  String? get date => widget.date;
  RestorableDateTime? _selectedDate;
  int day = CurrentDayService().currentDay();
  int month = CurrentDayService().currentMonth();
  int year = CurrentDayService().currentYear();

  @override
  void initState() {
    _selectedDate = RestorableDateTime(DateTime.parse(date!));
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
          initialDate: DateTime(2024,6,13),
          firstDate: DateTime(2024),
          lastDate: DateTime(2024,6,13),
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate!.value.day}/${_selectedDate!.value.month}/${_selectedDate!.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            _restorableDatePickerRouteFuture.present();
          },
          child: const Text('From: 123-213-123'),
        ),
      ),
    );
  }
}
