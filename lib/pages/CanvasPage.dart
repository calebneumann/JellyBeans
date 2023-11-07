import 'package:app_project/models/User.dart';
import 'package:flutter/material.dart';

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
        const SnackBar(content: Text('Processing Data')),
      );

      _formKey.currentState!.save();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sign in to Canvas')),
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
          ElevatedButton(onPressed: _handleSave, child: const Text('Save')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
