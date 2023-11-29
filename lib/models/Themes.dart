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
import '../pages/SettingsPageWidgets/textWidget.dart';

//Color curTheme = Colors.pink;
MaterialColor customMaterial =
    CustomMaterialColor(customTheme.red, customTheme.green, customTheme.blue)
        .mdColor;

//Made custom themes a list bc colors would not change if values were changed as a global variable.
//So I have it create new ThemeData to send to main.dart and then clear the list it was put in
//to delete that instance and then a new one is put in to replace it if the custom theme were to change.
List<ThemeData> customList = <ThemeData>[];

class themes extends StatefulWidget {
  @override
  State<themes> createState() => _themesState();
}

class _themesState extends State<themes> {
  void changeTheme() {
    if (dropDownValue == "Light Mode") {
      print(dropDownValue);
      theme = Colors.pink;
    } else if (dropDownValue == "Dark Mode") {
      print(dropDownValue);
      theme = Colors.black;
    } else if (dropDownValue == "Colorblind Mode") {
      print(dropDownValue);
      theme = Colors.black;
    } else if (dropDownValue == "Custom") {
      print(dropDownValue);
      theme = customTheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return TextButton(
        onPressed: () {
          changeTheme();
          onThemeChanged(dropDownValue, themeNotifier);
        },
        child: TextWidget(text: "Set Theme", multiplier: 1.0));
  }
}

void onThemeChanged(String themeString, ThemeNotifier themeNotifier) async {
  Brightness changeMode = Brightness.light;
  if (themeString == "Light Mode") {
    themeNotifier.setTheme(lightTheme);
  } else if (themeString == "Dark Mode") {
    themeNotifier.setTheme(darkTheme);
  } else if (themeString == "Custom") {
    customList.clear();
    customMaterial = CustomMaterialColor(
            customTheme.red, customTheme.green, customTheme.blue)
        .mdColor;
    if (darkMode == true) {
      changeMode = Brightness.dark;
    } else {
      changeMode = Brightness.light;
    }
    customList.add(ThemeData(
      primarySwatch: customMaterial,
      primaryColor: customTheme,
      brightness: changeMode,
      dividerColor: customTheme,
    ));
    print(customList.length);
    themeNotifier.setTheme(customList.first);
  } else if (themeString == "Colorblind Mode") {
    themeNotifier.setTheme(customThemeData);
  }
}

class CustomMaterialColor {
  final int r;
  final int g;
  final int b;

  CustomMaterialColor(this.r, this.g, this.b);

  MaterialColor get mdColor {
    Map<int, Color> color = {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };
    return MaterialColor(Color.fromRGBO(r, g, b, 1).value, color);
  }
}

//STICKING CUSTOMIZED THEMES HERE
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: theme),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: Colors.blueGrey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  dividerColor: Colors.black12,
);

ThemeData customThemeData = ThemeData(
  useMaterial3: true,
  primarySwatch: Colors.blueGrey,
  primaryColor: Colors.black,
  dividerColor: Colors.black12,
);
