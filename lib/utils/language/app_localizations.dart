import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  late Map<String, dynamic> _localizedStrings;

  Future<bool> load() async {
    final languageCode = locale.languageCode;
    // var request = http.Request(
    //     'GET',
    //     Uri.parse(
    //         'https://raw.githubusercontent.com/pragnesh-softcolon/multi-language/main/$languageCode.json'));
    //
    // http.StreamedResponse response = await request.send();
    // String jsonMap = await response.stream.bytesToString();
    // if (response.statusCode == 200) {
    //   if (jsonMap.isEmpty) {
    //     return false;
    //   }
    //   _localizedStrings = json.decode(jsonMap);
    //   print("success");
    //   return true;
    //
    // } else {
    //   print("Error : $jsonMap");
    //   return false;
    // }
    String jsonMap = await rootBundle.loadString('assets/lang/$languageCode.json');
    if (jsonMap.isEmpty) {
      return false;
    }
    _localizedStrings = json.decode(jsonMap);
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
