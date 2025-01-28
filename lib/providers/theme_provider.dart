import 'dart:async';

import 'package:flutter/material.dart';
import 'package:followclient_app/utils/user_prefs.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  String _selectedTheme = "system";

  ThemeProvider() {
    unawaited(_loadTheme());
  }

  ThemeMode get themeMode => _themeMode;
  String get selectedTheme => _selectedTheme;

  Future<void> _loadTheme() async {
    String theme = await UserPreference().getTheme();
    String mode = await UserPreference().getMode();
    if (theme.isEmpty) {
      _themeMode = ThemeMode.system;
    } else {
      _themeMode = theme == "light" ? ThemeMode.light : ThemeMode.dark;
    }
    _selectedTheme = mode;
    notifyListeners(); // Notify listeners after loading theme
  }

  Future<void> setThemeMode(
      ThemeMode theme, String mode, BuildContext context) async {
    _themeMode = theme;
    _selectedTheme = mode;
   await UserPreference().setMode(mode);
    if (theme == ThemeMode.system) {
      _themeMode = getCurrentBrightness(context);
    }
    await UserPreference().setTheme(
      _themeMode == ThemeMode.light ? "light" : "dark",
    );
    notifyListeners();
  }

  void dummyFun(){
    notifyListeners();
  }

  ThemeMode getCurrentBrightness(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}
