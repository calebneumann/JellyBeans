import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class calendarPage extends StatefulWidget {
  const calendarPage({super.key});

  @override
  State<calendarPage> createState() => _calendarPageState();
}

class _calendarPageState extends State<calendarPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have ' '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () {
                appState.deleteSingle(pair);
                setState(() {});
              },
            ),

            // leading: Icon(Icons.delete),
            title: Text(pair.asLowerCase),
          ),
        ElevatedButton.icon(
          onPressed: () {
            appState.deleteList();
            setState(() {});
          },
          icon: const Icon(
            // <-- Icon
            Icons.delete,
            size: 24.0,
          ),
          label: const Text('Delete List'), // <-- Text
        ),
      ],
    );
  }
}
