import 'dart:io';

import 'package:app_project/main.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gif/flutter_gif.dart';


const List<String> themes = <String>["Light Mode", "Dark Mode", "Colorblind Mode", "Custom", "Secret debugging suprise :)"];
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}
class _SettingsPageState extends State<SettingsPage>{
  final player = AudioPlayer();
  String dropDownValue = themes.first;
  double textSize = 20;
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
            style: TextStyle(fontSize: (textSize + 20)),
          ),
        ),

        ListTile(
          leading: TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: textSize),
            ),
            onPressed: () {
              showThemes();
            },
            child: const Text("Themes"),
          ),

        ),

          //toggles the themes dropdown on and off
          Visibility(
          visible: _themesState,
          child:DropdownMenu(
          initialSelection: themes.first, 
          onSelected: (String? value){
            setState(() {
              dropDownValue = value!;
              if(dropDownValue == "Secret debugging suprise :)"){
                showFNAF(true);
              }
              else{
                showFNAF(false);
              }

            });
          },
          dropdownMenuEntries: themes.map<DropdownMenuEntry<String>>((String value){
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
        ),


        ListTile(
          leading: TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: textSize),
            ),
            onPressed: () {
              showSlider();
            },
            child: const Text("Text Size"),
          ),

        ),

        //toggles the slider on and off
        Visibility( 
          visible: _sliderState,
          child:Slider(
          value: textSize,
          max: 45,
          min: 15,
          divisions: 30,
          label: textSize.round().toString(),
          onChanged: (double value){
            setState(() {
              textSize = value;
            });
          },
        ),
        ),





        ListTile(
          leading: TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: textSize),
            ),
            onPressed: () async{ 
              await player.play(AssetSource('audio/FNAF.mp3')); //plays a silly FNAF noise LOL GOTTEM
              showFNAF(true);
              await Future.delayed(const Duration(seconds: 3));
              showFNAF(false);
              }, 
              
            child: Text("FNAF JUMPSCARE",
            style: TextStyle(fontSize: textSize),),
          ),
        ),
      ],
    );
  }
}

