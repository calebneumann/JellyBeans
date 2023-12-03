import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'ListPageWidgets/ListPageWidgets.dart';
import '../models/UserSettings.dart';
import '../../models/Filters.dart';

UserSettings userSettings = UserSettings(1);

class ListPage extends StatefulWidget {
  final Function(dynamic) selectScreen;

  const ListPage({super.key, required this.selectScreen});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  var searchQuery = "";
  var listFilters = Filters();

  void searchList(String query){
    setState(() {
      searchQuery = query;
    });
  }

  void filterList(Filters filters){
    setState(() {
      listFilters = filters;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onBackground,
    );

    // *** Very confusing code that populates list page with widgets (Search Bar, Assignments, Date seperators) *** //
    var list = <Widget>[
      SearchFilterWidget(applySearch: searchList, applyFilters: filterList,),               // Add Search bar widget first
    ];
    var buffer = <Widget>[];                                                      // Everything in @buffer to be pushed into @list. Note that it starts EMPTY
    var sectionYr = 0, sectionMnth = 0, sectionDay = 0;

    //Filter by filters
    var assignments = appState.assignments.getAllAssignments().where( (a) => 
      (a.dueDate.isAfter(listFilters.startDate) && a.dueDate.isBefore(listFilters.endDate)) || (a.priority > listFilters.minPriority && a.priority < listFilters.minPriority) 
    ).toList();

    //Search by query
    assignments = assignments.where( (a) => 
      a.name.contains(searchQuery) || a.notes.contains(searchQuery) || a.details.contains(searchQuery) 
    ).toList();

    for (var ass in assignments) {
      if (ass.dueDate.day != sectionDay ||                                          // If new date, push everything in @buffer into @list and clear @buffer
          ass.dueDate.month != sectionMnth ||
          ass.dueDate.year != sectionYr) {
        list.addAll(buffer);
        buffer.clear();
      } else {                                                                      // Else same date, add the assignment to @buffer and CONTINUE
        buffer.add(AssignmentWidget(assignment: ass, selectScreen: widget.selectScreen));
        continue;
      }

      if (buffer.isEmpty) {                                                         // If @buffer is empty, add a date seperator and add the assignment to @buffer
        sectionYr = ass.dueDate.year;
        sectionMnth = ass.dueDate.month;
        sectionDay = ass.dueDate.day;

        buffer.add(SizedBox(height: 10));
        buffer.add(
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "${DateFormat.MMM().format(ass.dueDate)} $sectionDay, $sectionYr",
              style: style.apply(fontSizeFactor: UserSettings.getFontSize() / 27, fontWeightDelta: 3), //implement
            ),
          ),
        );
        buffer.add(AssignmentWidget(assignment: ass, selectScreen: widget.selectScreen));
      }
    }
    list.addAll(buffer);                                                          // Finally, add everything currently in @buffer to @list 
    // *** Trust me it works *** //

    return ListView(
      children: list,
    );
  }
}
