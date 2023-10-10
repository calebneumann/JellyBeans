import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
  
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text('Settings',
              style: TextStyle(fontSize: 40),
              ),
        ),
        // for (var color in appState.colors)
          ListTile(
            leading: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Enabled'),
          ),
            
            // leading: Icon(Icons.delete),
            // title: Text(color),
          ),
          
      ],
    );
  }
}