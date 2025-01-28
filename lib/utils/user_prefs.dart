import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<void> setLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("locale", locale);
  }

  Future<String> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("locale") ?? 'en';
  }

  Future<void> setTheme(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("theme", locale);
  }

  Future<String> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("theme") ?? 'system';
  }

  Future<void> setMode(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("mode", locale);
  }

  Future<String> getMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("mode") ?? 'system';
  }


  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
