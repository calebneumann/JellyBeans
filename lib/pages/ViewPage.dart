import 'package:flutter/material.dart';
import '../models/Assignment.dart';
import '../main.dart';
import 'package:provider/provider.dart';

class ViewPage extends StatelessWidget {
  final Function(dynamic) selectScreen;
  final Assignment assignment;

  ViewPage({required this.assignment, required this.selectScreen});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.currentAssignment = assignment;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Jelly Beans' Homework Tracker v0.2",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          selectScreen(2);
        },
        child: Icon(Icons.edit),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${assignment.name}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Class Name: ${assignment.className}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Due Date: ${assignment.dueDate.toString()}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Details: ${assignment.details}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Priority: ${assignment.priority}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Notes: ${assignment.notes}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Color: ${assignment.color}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final appState = context.read<MyAppState>();
                      appState.currentAssignment = null;
                      Navigator.pop(context);
                      selectScreen(0);
                    },
                    child: Text('Done'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
