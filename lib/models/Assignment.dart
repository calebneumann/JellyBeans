import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Assignment {
  final String id;
  String name = '';
  String className = '';
  String details = '';
  DateTime dueDate = DateTime.now();
  int priority = 0;
  String notes = '';
  int color = 0;

  Assignment(this.id);
  Assignment.unnamed() : this.id = Uuid().v1();
}

class Assignments extends ChangeNotifier {
  List<Assignment> _assignments = [];

  Assignment createAssignment() {
    var assignment = new Assignment.unnamed();
    _assignments.add(assignment);
    notifyListeners();
    return assignment;
  }

  Assignment createCanvasAssignment(String id) {
    var assignment = new Assignment(id);
    _assignments.add(assignment);
    notifyListeners();
    return assignment;
  }

  int deleteAssignment(String id) {
    _assignments.removeWhere((assignment) => assignment.id == id);
    notifyListeners();
    return _assignments.length;
  }

  Assignment getAssignment(String assignmentId) {
    return _assignments
        .firstWhere((assignment) => assignment.id == assignmentId);
  }

  List<Assignment> getAllAssignments() {
    return _assignments;
  }

  void saveAssignment(Assignment assignment) {
    var index = _assignments.indexWhere((a) => a.id == assignment.id);

    if (index == -1) {
      throw 'Tried to save a non-existent assignment';
    }

    _assignments[index] = assignment;
    notifyListeners();
  }

  void sortAssignments(){
    _assignments.sort( (a, b) => a.dueDate.compareTo(b.dueDate) );
  }
}
