import 'package:flutter/material.dart';
import 'app_localizations.dart';
import 'all_language.dart'; // For async operations

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AllLanguage().languages.containsValue(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
