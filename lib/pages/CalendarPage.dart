import 'package:app_project/models/Themes.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../models/Assignment.dart';
import 'package:provider/provider.dart';
import '../main.dart';

var assignmentList = <Assignment>[];
class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var buffer = <Assignment>[];
    assignmentList.clear(); //so that it doesn't add onto old list before adding updated list
    for(var ass in appState.assignments.getAllAssignments()){
      assignmentList.add(ass);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('AHH A CALENDAR!!! RUN!!!!!!!!!!!!!!!!!!!!!!'),
      ),
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
List<Assignment> getDataSource() {






/*
  meetings.add(Meeting(
      'WOW THIS IS AN EXAAAAMPLE ASSIGNMENT', startTime, endTime, Colors.pink, "descriiiiption"));
  */
  return assignmentList;
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Assignment> source) {
    appointments = source;
  }

  
   @override
  DateTime getStartTime(int index) {
    return appointments![index].dueDate;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].dueDate;
  }

  //since the calendar can only take one string, I combined to look like "name -- className"
  @override
  String getSubject(int index) {
    String temp = appointments![index].name + " -- " + appointments![index].className;
    return temp;
  }

//this only takes 1 string, so for now im combining the assignment name and class name
/*
  @override
  String getSubject(int index) {
    return appointments![index].name;
  }
*/
  @override
  Color getColor(int index) {
    return Colors.pink;
  }
}

class AddAssignment {
  AddAssignment(this.name, this.className, this.details, this.dueDate, this.priority, this.notes, this.color);

  String name;
  String className;
  String details;
  DateTime dueDate;
  int priority;
  String notes;
  int color;
}