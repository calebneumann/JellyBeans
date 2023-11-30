import 'package:app_project/models/User.dart';
import 'package:app_project/pages/SettingsPageWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import '../models/UserSettings.dart';

UserSettings userSettings = UserSettings(1);
class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key});

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController(text: User.username);
  final _passwordController = TextEditingController(text: User.password);

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: TextWidget(text: 'Processing Data', multiplier: 0.7,)),
      );

      _formKey.currentState!.save();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: TextWidget(text: 'Sign in to Canvas', multiplier: 1.0,)),
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
                    labelText: 'Username',
                    labelStyle: TextStyle(fontSize: UserSettings.getFontSize() * 0.8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }

                    return null;
                  },
                  onSaved: (newValue) => User.setUsername(newValue ?? ''),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: UserSettings.getFontSize() * 0.8)
                  ),
                  obscureText: true,
                  onEditingComplete: _handleSave,
                  onSaved: (newValue) => User.setPassword(newValue ?? ''),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    return null;
                  },
                ),
              ],
            ),
          )),
      floatingActionButton:
          ElevatedButton(onPressed: _handleSave, child: const TextWidget(text: 'Save', multiplier: 0.7,)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
