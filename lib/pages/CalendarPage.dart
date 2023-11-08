import 'package:app_project/models/Themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          onTap: (CalendarTapDetails details) {

            if(details.targetElement == CalendarElement.appointment){
              final Assignment assignmentDetails = details.appointments![0];
              var assNotes = assignmentDetails.notes;
              var assClassName = assignmentDetails.className;
              var assDetails = assignmentDetails.details;
              DateTime assDueDate = assignmentDetails.dueDate;
              var assDay = assDueDate.day;
              var assYear = assDueDate.year;

              var assName = assignmentDetails.name;

            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
                title: 
                  Row(children: [
                    Text(assName),
                    Text(' - '),
                    Text(assClassName, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),),
                  ],),
                content: Container(
                  height: 80,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(assNotes, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),),

                        ],
                      ),
                      Row(
                        children: [
                          Text("${DateFormat.MMM().format(assDueDate)} $assDay, $assYear"),
                        ],
                      ),
                      Text(assDetails, style: TextStyle(fontSize: 10),),
                    ],
                  ),
                ),
                actions: <Widget>[
                   TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text('close'),
                  )
                ],
              );
            }
            );
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