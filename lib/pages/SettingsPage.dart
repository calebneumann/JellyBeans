//import 'dart:io';

import 'package:app_project/main.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'SettingsPageWidgets/themesDropdown.dart';
import 'SettingsPageWidgets/fontSlider.dart';
import 'SettingsPageWidgets/textWidget.dart';
import 'SettingsPageWidgets/fnaf.dart';
import '../models/UserSettings.dart';
//import 'package:flutter/scheduler.dart';

UserSettings userSettings = UserSettings(1);
MyHomePage home = MyHomePage();


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
          child: FnafWidget(),
        ),


        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Settings',
            style: TextStyle(fontSize: (UserSettings.getFontSize() + 20)),
          ),
        ),

        ListTile(
          leading: TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: UserSettings.getFontSize()),
            ),
            onPressed: () {
              showThemes();
            },
            child: TextWidget(
            fontSize: UserSettings.getFontSize(),
            text: "Themes",
          ),
          ),

        ),

          //toggles the themes dropdown on and off
          Visibility(
          visible: _themesState,
          child:DropDownWidget(fontSize: UserSettings.getFontSize(),),
        ),

          
        ListTile(
          leading: TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: UserSettings.getFontSize()),
            ),
            onPressed: () {
              showSlider();
            },
            child: TextWidget(
            fontSize: UserSettings.getFontSize(),
            text: "Text Size",
          ),
          ),

        ),

        //toggles the slider on and off
        
        //makes slider visible when pressing button
        Visibility( 
          visible: _sliderState,
          child: Listener( //listens for presses and drags on the slider (setState wouldn't work from another file idk why D: )
            onPointerMove: (event) => setState(() {}),
            onPointerDown: (event) => setState(() {}),
            child: SliderWidget(),
          ),
        ),

        ListTile(
          leading: TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: UserSettings.getFontSize()),
            ),
            onPressed: () async{ 
              await player.play(AssetSource('audio/FNAF.mp3')); //plays a silly FNAF noise LOL GOTTEM
              showFNAF(true);
              await Future.delayed(const Duration(seconds: 3));
              showFNAF(false);
              }, 
              
            child: TextWidget(
            fontSize: UserSettings.getFontSize(),
            text: "FNAF JUMPSCARE",
          ),
          ),
        ),

      ],
      
    );
    
  }
}
