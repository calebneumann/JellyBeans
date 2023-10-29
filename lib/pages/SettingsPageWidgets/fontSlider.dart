//To call SliderWidget, do
//SliderWidget()


import 'package:flutter/material.dart';
//import 'package:app_project/models/UserSettings.dart';
import '../SettingsPage.dart';



class SliderWidget extends StatefulWidget{
  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  Widget sliderWidget(){
    return Slider(
      value: userSettings.getFontSize(),
      max: 45,
      min: 15,
      divisions: 30,
      label: userSettings.getFontSize().round().toString(),
      onChanged: (double value){
        setState(() {
          userSettings.setFontSize(value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return sliderWidget();
  }
}
