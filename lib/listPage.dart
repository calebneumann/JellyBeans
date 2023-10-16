import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';



class listPage extends StatelessWidget {
  const listPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    // IconData icon;
    // if (appState.favorites.contains(pair)) {
    //   icon = Icons.favorite;
    // } else {
    //   icon = Icons.favorite_border;
    // }

    return ListView(

      //TODO: Iterate over some assignment list for these
      children: [
        Text("Jan 1"),
        AssignmentWidget(assignment: "assignment1"),
        AssignmentWidget(assignment: "assignment2"),

        Text("Dec 10"),
        AssignmentWidget(assignment: "assignment3"),
      ],
    );
  }
}

class AssignmentWidget extends StatelessWidget {
  const AssignmentWidget({
    super.key,
    required this.assignment,
  });

  final String assignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onBackground,
    );

    return Card(
      color: theme.colorScheme.background,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ExpansionTile(
          title: Text(this.assignment),
          children: [
            Row(
              children: [
                Text("notes"),
                ElevatedButton(onPressed: () => { print("test") }, child:
                  Text("edit")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}