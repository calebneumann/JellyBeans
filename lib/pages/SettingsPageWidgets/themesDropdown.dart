//To call DropDownWidget, do
//DropDownWidget(fontSize: userSettings.getFontSize);

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../main.dart';
import '../SettingsPageWidgets/textWidget.dart';

Color customTheme = Colors.pink;
bool darkMode = false;
bool curColor = false;
Color _color = Colors.pink;

//list of themes in dropdown menu
List<String> themesList = <String>[
  "Light Mode",
  "Dark Mode",
  "Colorblind Mode",
  "Custom"
];
String dropDownValue = themesList.first;

bool h = false;

class DropDownWidget extends StatefulWidget {
  final double fontSize;
  DropDownWidget({Key? key, required this.fontSize}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {

  Color chosenColor = Colors.pink;

  void changeColor(Color color) {
    setState(() => _color = color);
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20),
                child: DropdownMenu(
                  initialSelection: dropDownValue,
                  enableSearch: false,
                  width: 200,
                  onSelected: (String? value) {
                    setState(() {
                      dropDownValue = value!;
                    });
                    if (dropDownValue == "Custom") {
                      curColor = true;
                    } else {
                      curColor = false;
                    }
                  },
                  textStyle: TextStyle(fontSize: widget.fontSize - 5.0),
                  dropdownMenuEntries:
                      themesList.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                )),
            Visibility(
                visible: curColor,
                child: Column(
                  children: [
                    SizedBox(
                      width: 42.0,
                      height: 42.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: customTheme,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                      child: Column(
                                    children: <Widget>[
                                      ColorPicker(
                                          pickerColor: _color,
                                          onColorChanged: changeColor),
                                      //DarkModeToggle(),
                                    ],
                                  )),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('Got it'),
                                      onPressed: () {
                                        setState(() {
                                          theme = _color;
                                          customTheme = _color;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child:
                            TextWidget(text: "Choose Color", multiplier: 0.6))
                  ],
                ))
          ],
        ),
      ],
    );
  }
}

class DarkModeToggle extends StatefulWidget {
  const DarkModeToggle({super.key});

  @override
  State<DarkModeToggle> createState() => _DarkModeToggleState();
}

class _DarkModeToggleState extends State<DarkModeToggle> {
  String isOn = "Off";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
          // This bool value toggles the switch.
          value: darkMode,
          onChanged: (bool value) {
            // This is called when the user toggles the switch.
            setState(() {
              darkMode = value;
              if (darkMode == false) {
                isOn = "Off";
              } else {
                isOn = "On";
              }
            });
          },
        ),
        Text("Dark Mode: $isOn"),
      ],
    );
  }
}
