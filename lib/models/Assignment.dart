import 'package:app_project/init.dart';
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
  Assignment.unnamed() : id = Uuid().v1();

  factory Assignment.fromJson(Map<String, dynamic> json, String nickname) {
    return Assignment('${json['id']}')
      ..name = json['name'] ?? 'Untitled Assignment'
      ..details = json['description'] ?? ''
      ..dueDate = DateTime.parse(json['due_at'])
      ..className = nickname;
  }

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'name': name,
      'className': className,
      'details': details,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority,
      'notes': notes,
      'color': color,
    };
  }

  static Assignment fromDb(Map<String, dynamic> db) {
    return Assignment(db['id'])
      ..name = db['name']
      ..className = db['className']
      ..details = db['details']
      ..dueDate = DateTime.parse(db['dueDate'])
      ..priority = db['priority']
      ..notes = db['notes']
      ..color = db['color'];
  }
}

class Assignments extends ChangeNotifier {
  List<Assignment> _assignments = [];

  Assignment createAssignment() {
    var assignment = Assignment.unnamed();
    _assignments.add(assignment);
    notifyListeners();

    Init.saveAssignments(_assignments);
    return assignment;
  }

  int addCanvasAssignments(List<Assignment> assignments) {
    int count = 0;

    for (var assignment in assignments) {
      if (_assignments.any((a) => a.id == assignment.id)) {
        continue;
      }

      count += 1;
      _assignments.add(assignment);
    }
    notifyListeners();

    Init.saveAssignments(_assignments);

    return count;
  }

  int deleteAssignment(String id) {
    _assignments.removeWhere((assignment) => assignment.id == id);
    notifyListeners();

    Init.saveAssignments(_assignments);

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

    Init.saveAssignments(_assignments);
  }

  void sortAssignments() {
    _assignments.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  static List<dynamic> toDb(List<Assignment> assignments) {
    return assignments.map((a) => a.toDb()).toList();
  }

  void fromDb(dynamic db) {
    _assignments = List<Assignment>.from(db?.map((x) => Assignment.fromDb(x)));
  }
}
