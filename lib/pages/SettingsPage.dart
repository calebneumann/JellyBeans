//import 'dart:io';

import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'SettingsPageWidgets/themesDropdown.dart';
import 'SettingsPageWidgets/fontSlider.dart';
import 'SettingsPageWidgets/textWidget.dart';
import 'SettingsPageWidgets/fnaf.dart';
import '../models/UserSettings.dart';
import 'dart:async';

UserSettings userSettings = UserSettings(1);
String randJump = "assets/images/CHICA.gif";
int randInt = Random().nextInt(1);
bool isGoldenFreddy = false;

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
  void turnOnFNAF(bool state){
    randInt = Random().nextInt(101); //gets random number between 0 and 100, inclusively
    if(randInt >= 0 && randInt < 25){
      randJump = "assets/images/BONNIE.gif";
    }
    else if(randInt >= 25 && randInt < 50){
      randJump = "assets/images/CHICA.gif";
    }
    else if(randInt >= 50 && randInt <75){
      randJump = "assets/images/FREDDY.gif";
    }
    else if(randInt >= 75 && randInt < 100){
      randJump = "assets/images/FOXY.gif";
    }
    //freddy has 1/101 chance to be chosen
    else{
      randJump = "assets/images/GOLDEN_FREDDY.jpg";
      //uncomment if you want the app to crash
      //isGoldenFreddy = true; 
    }



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
          child: FnafWidget(rand: randJump), //sends the randomly chose jumpscare asset
        ),


        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Settings',
            style: TextStyle(fontSize: (UserSettings.getFontSize() + 20)),
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
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
              //for testing purposes
              //getDataSource("pog", DateTime(2023, 11, 13), DateTime(2023, 11, 15), Colors.pink, "this is the description");
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
              textStyle: TextStyle(fontSize: UserSettings.getFontSize(),),
            ),

            onPressed: () { 
              player.play(AssetSource('audio/FNAF.mp3')); //plays a silly FNAF noise LOL GOTTEM
              turnOnFNAF(true);
              Timer.periodic(Duration(seconds: 3), (Timer t){
                if(!mounted){
                  t.cancel();
                  if(isGoldenFreddy){ //if golden freddy is chosen, the app crashes :)
                    exit(0);
                  }
                } else {
                  setState(() {
                    t.cancel();
                  if(isGoldenFreddy){
                    exit(0);
                  }
                  _fnafState = false;
                  });
                }
              });

            },   
            child: TextWidget(
            fontSize: UserSettings.getFontSize(),
            text: "WARNING: DON'T PRESS!",
          ),
          ),
        ),

          ],
        )

      ],
      
    );
    
  }
}
