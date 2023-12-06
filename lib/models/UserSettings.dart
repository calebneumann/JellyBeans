import 'package:app_project/init.dart';
import 'package:flutter/foundation.dart';
import 'Themes.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class UserSettings extends ChangeNotifier {
  int _theme;
  static String _startTheme = "Light Mode";

  static double _fontSize = 20;
  static ThemeData _startThemeData = lightTheme;
  UserSettings(this._theme);

  static String getTheme() {
    return _startTheme;
  }

  static ThemeData getThemeData() {
    if (getTheme() == "Light Mode") {
      //theme = Colors.pink;
      _startThemeData = lightTheme;
      print("came light mode");
    } else if (getTheme() == "Dark Mode") {
      //theme = Colors.black;
      _startThemeData = darkTheme;
      print("came dark mode");
    } else if (getTheme() == "Colorblind Mode") {
      //theme = Colors.black;
      _startThemeData = customThemeData;
      print("came colorblind mode");
    }
    return _startThemeData;
  }

  static double getFontSize() {
    return _fontSize;
  }

  void setTheme(String theme) {
    _startTheme = theme;
    notifyListeners();

    Init.saveSettings(toDb());
  }

  void setFontSize(double fontSize) {
    _fontSize = fontSize;
    notifyListeners();

    Init.saveSettings(toDb());
  }

  Map<String, dynamic> toDb() {
    return {
      'theme': _startTheme,
      'fontSize': _fontSize,
    };
  }
}
