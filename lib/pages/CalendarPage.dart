import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../models/Assignment.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'SettingsPageWidgets/textWidget.dart';

var assignmentList = <Assignment>[];
bool fromCalendar = false;

class CalendarPage extends StatelessWidget {
  final Function(dynamic) selectScreen;

  const CalendarPage({super.key, required this.selectScreen});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    assignmentList
        .clear(); //so that it doesn't add onto old list before adding updated list
    for (var ass in appState.assignments.getAllAssignments()) {
      assignmentList.add(ass);
    }

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: "Event Calendar", multiplier: 1.0,),
        backgroundColor: Color.fromARGB(255, theme.red + 100, theme.green + 100, theme.blue + 100),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => infoWidget(selectScreen: selectScreen),
            ),
          ),
        ],
      ),
      body: SfCalendar(
        allowedViews: [
          CalendarView.month,
          CalendarView.schedule,
        ],
        view: CalendarView.month,
        showNavigationArrow: true,
        dataSource: MeetingDataSource(getDataSource()),
        monthViewSettings: MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.appointment) {
            final Assignment assignmentDetails = details.appointments![0];
            selectScreen(assignmentDetails);
            fromCalendar = true;
          }
        },
      ),
    );
  }
}

List<Assignment> getDataSource() {
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

  //set event end time as 11:59 PM because the calendar kept getting mad that the event was given just a start time
  @override
  DateTime getEndTime(int index) {
    DateTime endTime = appointments![index].dueDate;
    endTime = DateTime(endTime.year, endTime.month, endTime.day, 23, 59);
    return endTime;
  }

  //since the calendar can only take one string, I combined to look like "name -- className"
  @override
  String getSubject(int index) {
    String temp =
        appointments![index].name + " -- " + appointments![index].className;
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
    return Colors.pink; //TODO: whenever colors are set up stick that puppy here
  }
}

class AddAssignment {
  AddAssignment(this.name, this.className, this.details, this.dueDate,
      this.priority, this.notes, this.color);

  String name;
  String className;
  String details;
  DateTime dueDate;
  int priority;
  String notes;
  int color;
}

class infoWidget extends StatelessWidget {
  final Function(dynamic) selectScreen;

  const infoWidget({
    super.key,
    required this.selectScreen,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("INFORMATION"),
      content: Wrap(
        children: [
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    TextWidget(text: "Month View: Shows assignments in the month view\n\n", multiplier: 1.0,),
                  ],
                ),
                Row(
                  children: [
                      TextWidget(text: "Schedule View: Compresses calendar down to show assignments with their respective due dates. Tap on assignment to see details", multiplier: 1.0,)

                  ],
                )
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // selectScreen(assignmentDetails); don't know how to make this work
            Navigator.of(context).pop();
          },
          child: Text('view'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('close'),
        )
      ],
    );
  }
}
