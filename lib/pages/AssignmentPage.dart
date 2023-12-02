import 'package:app_project/pages/SettingsPageWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Assignment.dart';
import '../main.dart';
import '../models/UserSettings.dart';

UserSettings userSettings = UserSettings(1);

class AssignmentPage extends StatefulWidget {
  final Function(dynamic) selectScreen;

  const AssignmentPage({super.key, required this.selectScreen});

  @override
  AssignmentPageState createState() => AssignmentPageState();
}

class AssignmentPageState extends State<AssignmentPage> {
  // final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _classNameController = TextEditingController();
  final _detailsController = TextEditingController();
  final _notesController = TextEditingController();
  // final _colorController = TextEditingController();

  Assignment? _currentAssignment; //declared to create save assignment
  String _dateErrorMessage =
      ''; //declared to handle dateTime format errors (temporary)
  DateTime? _selectedDate = DateTime.now();
  int? _selectedPriority;

  @override
  void initState() {
    super.initState();

    final appState = context.read<MyAppState>();
    _currentAssignment = appState.currentAssignment;
    _selectedDate = _currentAssignment?.dueDate;
    _selectedPriority = _currentAssignment?.priority;
  }

  // void _handleSave() {
  //   if (_formKey.currentState!.validate()) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Processing Data')),
  //     );

  //     _formKey.currentState!.save();
  //     FocusManager.instance.primaryFocus?.unfocus();
  //   }
  // }

  InputDecoration _boxedDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: EdgeInsets.all(16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
    );
  }

  String _priorityText(int priority) {
    switch (priority) {
      case 0:
        return ' (Low Priority)';
      case 1:
        return '';
      case 2:
        return '';
      case 3:
        return '';
      case 4:
        return ' (High Priority)';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    if (appState.currentAssignment != null) {
      _nameController.text = _currentAssignment!.name;
      _classNameController.text = _currentAssignment!.className;
      _detailsController.text = _currentAssignment!.details;
      _notesController.text = _currentAssignment!.notes;
      // _colorController.text = _currentAssignment!.color.toString();
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: _boxedDecoration('Name'),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                style: TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _classNameController,
                      decoration: _boxedDecoration('Class Name'),
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      style:
                          TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
                    ),
                  ),
                  SizedBox(width: 0.0), //To remove space between two boxes
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: TextEditingController(
                            text: _selectedDate != null
                                ? _selectedDate!
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0]
                                : '',
                          ),
                          decoration: _boxedDecoration('Due Date'),
                          style: TextStyle(
                              fontSize: UserSettings.getFontSize() * 0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _detailsController,
                decoration: _boxedDecoration('Details'),
                maxLines: 7,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                style: TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
              ),
              DropdownButtonFormField<int>(
                value: _selectedPriority,
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedPriority = newValue!;
                  });
                },
                items: List.generate(
                  5,
                  (index) => DropdownMenuItem<int>(
                    value: index,
                    child: Text('${index + 1} ${_priorityText(index)}'),
                  ),
                ),
                decoration: _boxedDecoration('Priority'),
                style: TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
              ),
              TextFormField(
                controller: _notesController,
                decoration: _boxedDecoration('Notes'),
                maxLines: 7,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                style: TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
              ),
              // TextFormField(
              //   controller: _colorController,
              //   decoration: _boxedDecoration('Color (integer)'),
              //   onTapOutside: (event) => FocusScope.of(context).unfocus(),
              //   style: TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
              // ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final appState = context.read<MyAppState>();

                      if (_nameController.text.isEmpty) {
                        setState(() {
                          _dateErrorMessage = "Please enter an assignment name";
                        });
                        return;
                      } else {
                        setState(() {
                          _dateErrorMessage = '';
                        });
                      }

                      if (_currentAssignment == null ||
                          _currentAssignment!.id.isEmpty) {
                        _currentAssignment =
                            appState.assignments.createAssignment();
                      } //creates assignment if assignment does not exist.

                      if (_nameController.text.isNotEmpty) {
                        _currentAssignment!.name = _nameController.text;
                      }

                      if (_classNameController.text.isNotEmpty) {
                        _currentAssignment!.className =
                            _classNameController.text;
                      }

                      _currentAssignment!.dueDate =
                          _selectedDate ?? DateTime.now();

                      if (_detailsController.text.isNotEmpty) {
                        _currentAssignment!.details = _detailsController.text;
                      }

                      _currentAssignment!.priority = _selectedPriority ?? 0;

                      if (_notesController.text.isNotEmpty) {
                        _currentAssignment!.notes = _notesController.text;
                      }

                      // if (_colorController.text.isNotEmpty) {
                      //   _currentAssignment!.color =
                      //       int.parse(_colorController.text);
                      // }

                      appState.assignments.saveAssignment(_currentAssignment!);
                      appState.assignments
                          .sortAssignments(); //I put this in here to make list page rendering faster. hope it doesnt fuck anything up for u (- kevin)

                      widget.selectScreen(
                          _currentAssignment); //only works if all fields are filled.
                    },
                    child: TextWidget(
                      text: 'Save',
                      multiplier: 0.7,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      final appState = context.read<MyAppState>();
                      appState.currentAssignment = null;
                      widget.selectScreen(0);
                    },
                    child: TextWidget(
                      text: 'Cancel',
                      multiplier: 0.7,
                    ),
                  ),
                ],
              ),
              if (_dateErrorMessage.isNotEmpty)
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _dateErrorMessage,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: UserSettings.getFontSize()),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
