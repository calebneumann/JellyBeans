import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'ListPageWidgets/ListPageWidgets.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      //TODO: Iterate over some assignment list for these
      children: [
        SearchFilterWidget(),
        Text("Jan 1"),
        AssignmentWidget(assignment: "assignment1"),
        AssignmentWidget(assignment: "assignment2"),
        Text("Dec 10"),
        AssignmentWidget(assignment: "assignment3"),
      ],
    );
  }
}
