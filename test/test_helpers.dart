import 'package:followclient_app/utils/user_prefs.dart';

class FakeUserPreference extends UserPreference {
  String _fakeLocale = "en";

  @override
  Future<String> getLocale() async {
    return _fakeLocale; // Return default "en" immediately
  }

  @override
  Future<void> setLocale(String locale) async {
    _fakeLocale = locale;
  }
}
