//this dear partner is where the THEMES are going to go
//Themes to add: light, dark, colorblind, aaaaaaannnnd...
//CUSTOM!!! Debating whether to add a custom built list of colors or 
//somehow figure out how to add an RGB slider but we'll see...
//...we shall see...

//text should be black or white depending on the brightness of the theme
  //or always make background brighter and the appbar/navbar darker
  //like a colorful sandwich

//start with presets and get those functional, then do RGB panel
  //perfecting an RGB selected theme will be hard because of what needs to 
  //change depending on if the color is bright/dark/clashes with both white and black text

//https://pub.dev/packages/flutter_colorpicker
  //for RBG thingy

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../pages/SettingsPageWidgets/themesDropdown.dart';

//Color curTheme = Colors.pink;
class themes extends StatefulWidget{
  @override
  State<themes> createState() => _themesState();
}

class _themesState extends State<themes> {
  void changeTheme(){
  if(dropDownValue == "Light Mode"){
    print(dropDownValue);
    theme = Colors.pink;
  }
  else if(dropDownValue == "Dark Mode"){
    print(dropDownValue);
    theme = Colors.black;
  }
  else if(dropDownValue == "Colorblind Mode"){
    print(dropDownValue);
    theme = Colors.green;
  }
  else if(dropDownValue == "Custom"){
    print(dropDownValue);
    theme = customTheme;
  }
}

  @override
  Widget build(BuildContext context){
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return TextButton(
      onPressed: (){
        changeTheme();
      onThemeChanged(dropDownValue, themeNotifier);

      },
       child: Text("Set Theme"));
  }
}

void onThemeChanged(String themeString, ThemeNotifier themeNotifier) async {
    if(themeString == "Light Mode"){
      themeNotifier.setTheme(lightTheme);
    }
    else if (themeString == "Dark Mode"){
      themeNotifier.setTheme(darkTheme);
    }
}
