import 'package:flutter/material.dart';
//import 'package:uuid/Uuid.dart';
import 'package:provider/provider.dart';
// import 'ListPage.dart';
import '../models/Assignment.dart';
import '../main.dart';

class AssignmentPage extends StatefulWidget {
  @override
  AssignmentPageState createState() => AssignmentPageState();
}

class AssignmentPageState extends State<AssignmentPage> {
  final TextEditingController _nameController =
      TextEditingController(); //text editors currently used to modify all data.
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _dueDateController =
      TextEditingController(); //will change this soon to a drop down or something similar
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _priorityController =
      TextEditingController(); //TODO: change to drop down
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _colorController =
      TextEditingController(); //TODO: change to drop down

  Assignment? _currentAssignment; //declared to create save assignment

  InputDecoration _boxedDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: EdgeInsets.all(16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: _boxedDecoration('Name'),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _classNameController,
                      decoration: _boxedDecoration('Class Name'),
                    ),
                  ),
                  SizedBox(width: 0.0), //To remove space between two boxes
                  Expanded(
                    child: TextFormField(
                      controller: _dueDateController,
                      decoration: _boxedDecoration('Due Date'),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _detailsController,
                decoration: _boxedDecoration('Details'),
                maxLines: 7,
              ),
              TextFormField(
                controller: _priorityController,
                decoration: _boxedDecoration('Priority'),
              ),
              TextFormField(
                controller: _notesController,
                decoration: _boxedDecoration('Notes'),
              ),
              TextFormField(
                controller: _colorController,
                decoration: _boxedDecoration('Color'),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final appState = context.read<MyAppState>();
                      if (_currentAssignment == null ||
                          _currentAssignment!.id.isEmpty) {
                        _currentAssignment =
                            appState.assignments.createAssignment();
                      } //creates assignment if assignment does not exist. Currently, assignment never exists.

                      _currentAssignment!.name = _nameController.text;
                      _currentAssignment!.className = _classNameController.text;
                      _currentAssignment!.dueDate =
                          DateTime.parse(_dueDateController.text);
                      _currentAssignment!.details = _detailsController.text;
                      _currentAssignment!.priority =
                          int.parse(_priorityController.text);
                      _currentAssignment!.notes = _notesController.text;
                      _currentAssignment!.color =
                          int.parse(_colorController.text);

                      appState.assignments.saveAssignment(_currentAssignment!);

                      //selectScreen(0); //still figuring this out
                    },
                    child: Text('Save'),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      //selectScreen(0);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
