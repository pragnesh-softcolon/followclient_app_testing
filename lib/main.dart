import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:followclient_app/providers/locale_provider.dart';
import 'package:followclient_app/providers/theme_provider.dart';
import 'package:followclient_app/screens/Tabs/more/app_theme_screen.dart';
import 'package:followclient_app/screens/auth/login.dart';
import 'package:followclient_app/screens/auth/signup.dart';
import 'package:followclient_app/screens/auth/splash.dart';
import 'package:followclient_app/screens/Tabs/more/language_screen.dart';
import 'package:followclient_app/theme/app_themes.dart';
import 'package:followclient_app/utils/error_screens/error_404_screen.dart';
import 'package:followclient_app/utils/language/App_localizations_delegate.dart';
import 'package:followclient_app/utils/language/all_language.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  // Create a new Zone to override print
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MyApp(), // MyApp now has access to the providers
      ));
    },
    (error, stackTrace) {
      debugPrint('Caught error: $error\nStack trace: $stackTrace');
    },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        if (!kDebugMode) {
          throw FlutterError(
              'Printing detected: "$line".\nAvoid using print statements in production mode.');
        } else {
          parent.print(zone, line); // Allow printing in release mode
        }
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GetMaterialApp(
      title: 'Follow Client',
      debugShowCheckedModeBanner: false,
      supportedLocales: AllLanguage()
          .languages
          .keys
          .map((key) => Locale(AllLanguage().languages[key]))
          .toList(),
      locale: localeProvider.locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // Add this for Cupertino support
        const AppLocalizationsDelegate(),
      ],
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.themeMode,
      home: Splash(),
      // unknown Route
      unknownRoute: GetPage(name: '/not-found', page: () => Error404Screen()),
      getPages: [
        GetPage(
          name: Splash.routeName,
          page: () => const Splash(),
        ),
        GetPage(
          name: Login.routeName,
          page: () => const Login(),
        ),
        GetPage(
          name: Signup.routeName,
          page: () => const Signup(),
        ),
        GetPage(
          name: LanguageSelectionScreen.routeName,
          page: () => const LanguageSelectionScreen(),
        ),
        GetPage(
          name: AppThemeScreen.routeName,
          page: () => const AppThemeScreen(),
        ),
      ],
    );
  }
}
