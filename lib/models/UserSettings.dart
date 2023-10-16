import 'package:flutter/foundation.dart';

class UserSettings extends ChangeNotifier {
  int _theme;
  double _fontSize;

  UserSettings(this._theme, this._fontSize);

  int getTheme() {
    return _theme;
  }

  double getFontSize() {
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
