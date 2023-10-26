import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'ListPageWidgets/ListPageWidgets.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    var list = <Widget>[
      SearchFilterWidget(),
    ];

    //DateTime prevTime;
    for (var ass in appState.assignments.getAllAssignments()){
      /*bool nullCheck = prevTime ?? false;
      //Create title date separators
      if ( nullCheck && prevTime ){
      } */
      list.add(AssignmentWidget(assignment: ass));
    }

    return ListView(children: list,);
  }
}
