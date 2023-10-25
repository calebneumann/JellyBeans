import 'package:flutter/material.dart';
import 'package:uuid/Uuid.dart';
import 'package:provider/provider.dart';
import 'ListPage.dart';
import '../models/Assignment.dart';

class AssignmentPage extends StatefulWidget {
  @override
  AssignmentPageState createState() => AssignmentPageState();
}

class AssignmentPageState extends State<AssignmentPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

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
                      /*  final assignments = context.read<Assignments>();
                      final assignment = Assignment(Uuid().v1())
                        ..name = _nameController.text
                        ..className = _classNameController.text
                        ..dueDate = int.parse(_dueDateController.text)
                        ..details = _detailsController.text
                        ..priority = int.parse(_priorityController.text)
                        ..Notes = _notesController.text
                        ..color = int.parse(_colorController.text);

                      assignments.createAssignment(assignment);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ListPage())); //Doesn't work! */
                    },
                    child: Text('Save'),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ListPage())); //Doesn't work! */
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
