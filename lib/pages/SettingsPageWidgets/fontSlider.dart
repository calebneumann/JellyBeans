//To call SliderWidget, do
//SliderWidget()

import 'package:app_project/models/UserSettings.dart';
import 'package:flutter/material.dart';
import '../SettingsPage.dart';

class SliderWidget extends StatefulWidget {
  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  Widget sliderWidget() {
    return Slider(
      value: UserSettings.getFontSize(),
      max: 27,
      min: 15,
      divisions: 30,
      label: UserSettings.getFontSize().round().toString(),
      onChanged: (double value) {
        setState(() {
          userSettings.setFontSize(value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return sliderWidget();
  }
}
