import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
class Calender extends StatelessWidget {
  const Calender({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
    ),
    );
  }
}