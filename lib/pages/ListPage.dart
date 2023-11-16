import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'ListPageWidgets/ListPageWidgets.dart';
import '../models/UserSettings.dart';

UserSettings userSettings = UserSettings(1);

class ListPage extends StatelessWidget {
  final Function(dynamic) selectScreen;

  const ListPage({super.key, required this.selectScreen});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onBackground,
    );

    var list = <Widget>[
      SearchFilterWidget(),
    ];
    var buffer = <Widget>[];
    var sectionYr = 0, sectionMnth = 0, sectionDay = 0;
    for (var ass in appState.assignments.getAllAssignments()) {
      if (ass.dueDate.day != sectionDay ||
          ass.dueDate.month != sectionMnth ||
          ass.dueDate.year != sectionYr) {
        list.addAll(buffer);
        buffer.clear();
      } else {
        buffer
            .add(AssignmentWidget(assignment: ass, selectScreen: selectScreen));
        continue;
      }

      if (buffer.isEmpty) {
        sectionYr = ass.dueDate.year;
        sectionMnth = ass.dueDate.month;
        sectionDay = ass.dueDate.day;

        buffer.add(SizedBox(height: 10));
        buffer.add(
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "${DateFormat.MMM().format(ass.dueDate)} $sectionDay, $sectionYr",
              style: style.apply(
                fontSizeFactor: 0.6,
                fontWeightDelta: 3,
              ), //implement
            ),
          ),
        );
        buffer
            .add(AssignmentWidget(assignment: ass, selectScreen: selectScreen));
      }
    }
    list.addAll(buffer);

    return ListView(
      children: list,
    );
  }
}
