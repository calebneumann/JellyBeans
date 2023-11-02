import 'package:flutter/foundation.dart';
class UserSettings extends ChangeNotifier {
  int _theme;
  static double _fontSize = 20;

  UserSettings(this._theme);

  int getTheme() {
    return _theme;
  }

  static double getFontSize() {
    return _fontSize;
  }

  void setTheme(int theme) {
    _theme = theme;
    notifyListeners();
  }

  void setFontSize(double fontSize) {
    _fontSize = fontSize;
    notifyListeners();
  }
}
