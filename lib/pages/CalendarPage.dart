import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AHH A CALENDAR!!! RUN!!!!!!!!!!!!!!!!!!!!!!'),
      ),
      
        //TODO: stick this in its own widget bc CalendarPage shouldn't take parameters
        body: SfCalendar(
          view: CalendarView.month,
          showNavigationArrow: true,
          dataSource: MeetingDataSource(getDataSource()),
          monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment
          ),
        ),

    );
  }
}

//example of adding assignment to calendar
//going to make it to where you can add an assignment from
//anywhere in the app by calling the class with parameters
List<Meeting> getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime startTime =
      DateTime(2023, 11, 13);
  final DateTime endTime = DateTime(2023, 11, 15);
  meetings.add(Meeting(
      'WOW THIS IS AN EXAAAAMPLE ASSIGNMENT', startTime, endTime, Colors.pink, "descriiiiption"));
  return meetings;
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  Color getDescription(int index) {
    return appointments![index].background;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.description);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  String description;
}