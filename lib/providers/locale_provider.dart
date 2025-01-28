import 'dart:async';
import 'package:flutter/material.dart';
import 'package:followclient_app/utils/language/app_localizations.dart';
import 'package:followclient_app/utils/user_prefs.dart';

class LocaleProvider extends ChangeNotifier {
  AppLocalizations _localizations = AppLocalizations(Locale('en'));
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  AppLocalizations get localizations => _localizations;

  String _selectedLanguageKey = "en";

  String get selectedLanguageKey => _selectedLanguageKey;
  bool _isLoader = true;

  bool get isLoader => _isLoader;

  LocaleProvider() {
    Future.microtask(() async {
      await _loadLocalization();
    },);
  }

  Future<void> _loadLocalization() async {
    print("1");
    String languageCode = "en";
    UserPreference().getLocale().then(
      (value) {
        languageCode = value;
      },
    );
    print("2");
    if (languageCode.isEmpty) {
      print("3");
      languageCode = "en";
      print("4");
      notifyListeners();
    }
    print("5");
    AppLocalizations newLocalization = AppLocalizations(Locale(languageCode));
    print("6");
    bool isLoaded = await newLocalization.load();
    print("7");
    if (isLoaded) {
      print("8");
      _locale = Locale(languageCode);
      _localizations = newLocalization;
      _selectedLanguageKey = languageCode;
      print("9");
      notifyListeners();
    }
  }

  bool get hasStoredLocale {
    return _locale != const Locale('en');
  }

  void setLoader(bool value) {
    _isLoader = value;
    notifyListeners();
  }

  Future<void> changeLocale(Locale locale) async {
    print("1");
    setLoader(true);
    print("2");
    _locale = locale;
    print("3");
    UserPreference().setLocale(locale.languageCode);
    print("4");
    AppLocalizations newLocalization = AppLocalizations(locale);
    print("5");
    bool isLoaded = await newLocalization.load();
    print("6");
    if (isLoaded) {
      print("7");
      _localizations = newLocalization;
      print("8");
      _selectedLanguageKey = locale.languageCode;
      print("9");
      setLoader(false);
    }
    setLoader(false);
    print("10");

  }
}
