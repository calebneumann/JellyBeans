import 'package:app_project/pages/SettingsPageWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Assignment.dart';
import '../main.dart';
import 'package:provider/provider.dart';
import 'CalendarPage.dart';
import '../models/UserSettings.dart';
import 'package:flutter_html/flutter_html.dart';

UserSettings userSettings = UserSettings(1);

class ViewPage extends StatelessWidget {
  final Function(dynamic) selectScreen;
  final Assignment assignment;

  ViewPage({required this.assignment, required this.selectScreen});

  void _deleteAssignment(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Assignment'),
          content: Text('Are you sure you want to delete this assignment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final appState = context.read<MyAppState>();
                appState.assignments.deleteAssignment(assignment.id);
                appState.assignments.sortAssignments();
                appState.currentAssignment = null;
                Navigator.pop(context);
                selectScreen(2);
                _deleteConfirm(context);
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Assignment Successfully Deleted'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (fromCalendar == true) {
                  selectScreen(1);
                } else {
                  selectScreen(0);
                }
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.currentAssignment = assignment;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Jelly Beans' Homework Tracker v0.3",
          style: TextStyle(
              color: Colors.white, fontSize: UserSettings.getFontSize() * 1.0),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: theme,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              selectScreen(2);
            },
            child: Icon(Icons.edit, size: 32.0),
          ),
          SizedBox(height: 32),
          TextButton(
            onPressed: () => _deleteAssignment(context),
            child: Icon(Icons.delete, size: 32.0),
          ),
          SizedBox(height: 32),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${assignment.name}',
                style: TextStyle(
                    fontSize: UserSettings.getFontSize() * 0.9,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Class Name: ${assignment.className}',
                style: TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
              ),
              SizedBox(height: 8),
              Text(
                'Due Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(assignment.dueDate)}',
                style: TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
              ),
              SizedBox(height: 8),
              Html(data: "<p>Details: ${assignment.details}</p>", style: {
                "p": Style(
                  fontSize: FontSize(UserSettings.getFontSize() * 0.8),
                ),
              }),
              SizedBox(height: 8),
              Text(
                'Priority: ${assignment.priority + 1}',
                style: TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
              ),
              SizedBox(height: 8),
              Text(
                'Notes: ${assignment.notes}',
                style: TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
              ),
              SizedBox(height: 8),
              // Text(
              //   'Color: ${assignment.color}',
              //   style: TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
              // ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final appState = context.read<MyAppState>();
                    appState.currentAssignment = null;
                    Navigator.pop(context);
                    if (fromCalendar) {
                      fromCalendar = false;
                      selectScreen(1);
                    } else {
                      selectScreen(0);
                    }
                  },
                  child: TextWidget(
                    text: 'Done',
                    multiplier: 0.7,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
