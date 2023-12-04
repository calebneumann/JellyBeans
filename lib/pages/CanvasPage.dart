// ignore_for_file: use_build_context_synchronously

import 'package:app_project/models/Assignment.dart';
import 'package:app_project/models/User.dart';
import 'package:app_project/models/UserSettings.dart';
import 'package:app_project/pages/SettingsPageWidgets/textWidget.dart';
import 'package:app_project/utils/canvas/fetchAssignments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

UserSettings userSettings = UserSettings(1);

class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key});

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController(text: User.accessToken);

  void _handleSave(Assignments assignments) async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: TextWidget(
          text: 'Getting assignments...',
          multiplier: 0.7,
        )),
      );

      _formKey.currentState!.save();
      FocusManager.instance.primaryFocus?.unfocus();

      try {
        final newAssignments = await fetchAssignments();

        final assignmentCount =
            assignments.addCanvasAssignments(newAssignments);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: TextWidget(
            text: 'Added $assignmentCount assignments',
            multiplier: 0.7,
          )),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: TextWidget(
            text: 'Failed to load assignments',
            multiplier: 0.7,
          )),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: TextWidget(
          text: 'Sync with Canvas LMS',
          multiplier: 1,
        )),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Access Token',
                    labelStyle:
                        TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Access Token';
                    }

                    if (value.length != 69) {
                      return 'Invalid Access Token';
                    }

                    return null;
                  },
                  onSaved: (newValue) => User.setAccessToken(newValue ?? ''),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  onEditingComplete: () => _handleSave(appState.assignments),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                TextWidget(
                  text:
                      "Note: The correct method to sync with Canvas LMS uses OAuth2.\nSince our accounts do not have access to Developer Keys and we do not\nhave a back end, access tokens must be generated manually.\nAccount > Profile > Settings > New Access Token",
                  multiplier: .5,
                )
              ],
            ),
          )),
      floatingActionButton: ElevatedButton(
          onPressed: () => _handleSave(appState.assignments),
          child: const TextWidget(
            text: 'Sync',
            multiplier: 0.7,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
