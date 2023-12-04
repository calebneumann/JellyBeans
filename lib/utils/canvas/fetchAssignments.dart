import 'dart:convert';
import 'package:http/http.dart' as http;

import './Course.dart';
import 'package:app_project/models/User.dart';
import 'package:app_project/models/Assignment.dart';

Future<dynamic> fetchAssignments() async {
  final response = await http.get(
      Uri.parse(
          'https://unt.instructure.com/api/v1/users/self/course_nicknames?access_token=${User.accessToken}'),
      headers: {'enrollment_state': 'active', 'enrollment_type': 'student'});

  if (response.statusCode != 200) {
    throw Exception('Failed to load courses');
  }

  // var courses = Courses.fromJson(jsonDecode(response.body) as List<dynamic>);
  var courses = List<Course>.from(
      jsonDecode(response.body).map((x) => Course.fromJson(x)));

  var allAssignments = <Assignment>[];

  await Future.wait(courses.map((course) async {
    final response = await http.get(
      Uri.parse(
          'https://unt.instructure.com/api/v1/courses/${course.id}/assignments?access_token=${User.accessToken}'),
    );

    if (response.statusCode != 200) {
      // access restricted fsr so just skip
      return;
    }

    var assignments = jsonDecode(response.body) as List<dynamic>;

    for (var assignment in assignments) {
      if (assignment['due_at'] == null) {
        // we recquire a due date and if it's null then we can't use it
        return;
      }

      allAssignments.add(Assignment.fromJson(assignment, course.name));
    }

    return;
  }));

  return allAssignments;
}
