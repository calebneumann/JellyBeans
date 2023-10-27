import 'dart:io';

import 'package:app_project/main.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'SettingsPageWidgets/themesDropdown.dart';
import 'SettingsPageWidgets/fontSlider.dart';
import 'SettingsPageWidgets/textWidget.dart';
import 'SettingsPageWidgets/fnaf.dart';
import '../models/UserSettings.dart';

UserSettings userSettings = UserSettings(1, 20);

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}
class _SettingsPageState extends State<SettingsPage>{
  final player = AudioPlayer();
  bool _sliderState = false; //slider is not shown by default
  bool _themesState= false; //slider is not shown by default
  bool _fnafState = false;



  void showSlider(){
    setState(() {
      _sliderState = !_sliderState;
    });
  }
    void showThemes(){
    setState(() {
      _themesState = !_themesState;
    });
  }
      void showFNAF(bool state){

    setState(() {
      _fnafState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        
        Visibility( 
          visible: _fnafState,
          child: Image.asset(
            "assets/images/BONNIE.gif",
            height: 500.0,
            width: 500.0,
            fit: BoxFit.fill,
            alignment: Alignment.center,
                
          ),
        ),


        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Settings',
            style: TextStyle(fontSize: (userSettings.getFontSize() + 20)),
          ),
        ),

        ListTile(
          leading: TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: userSettings.getFontSize()),
            ),
            onPressed: () {
              showThemes();
            },
            child: TextWidget(
            fontSize: userSettings.getFontSize(),
            text: "Themes",
          ),
          ),

        ),

          //toggles the themes dropdown on and off
          Visibility(
          visible: _themesState,
          child:DropDownWidget(),
        ),


        ListTile(
          leading: TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: userSettings.getFontSize()),
            ),
            onPressed: () {
              showSlider();
            },
            child: TextWidget(
            fontSize: userSettings.getFontSize(),
            text: "Text Size",
          ),
          ),

        ),

        //toggles the slider on and off
        
        Visibility( 
          visible: _sliderState,
          child:SliderWidget(),
        ),

        



        ListTile(
          leading: TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: userSettings.getFontSize()),
            ),
            onPressed: () async{ 
              await player.play(AssetSource('audio/FNAF.mp3')); //plays a silly FNAF noise LOL GOTTEM
              showFNAF(true);
              await Future.delayed(const Duration(seconds: 3));
              showFNAF(false);
              }, 
              
            child: TextWidget(
            fontSize: userSettings.getFontSize(),
            text: "FNAF JUMPSCARE",
          ),
          ),
        ),
      ],
    );
  }
}

