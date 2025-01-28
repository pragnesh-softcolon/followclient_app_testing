import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:followclient_app/main.dart';
import 'package:followclient_app/providers/locale_provider.dart';
import 'package:followclient_app/providers/theme_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'test_helpers.dart';

void main() {
  group('MyApp Widget Test', () {
    testWidgets('renders MyApp correctly', (WidgetTester tester) async {
      // Use FakeUserPreference to prevent async issues
      final fakeUserPreference = FakeUserPreference();

      // Load the widget with mocked dependencies
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LocaleProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: const MyApp(),
        )
      );
      print("Active animations: ${tester.binding.transientCallbackCount}");

      print("Waiting for UI to settle...");
      // for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(seconds: 5));
      // }
      // await tester.pumpWidget(const Splash(),duration: Duration(seconds: 2));
      print("Checking screen...");
      // await tester.pumpAndSettle(const Duration(seconds: 5));
      when(tester.pump(const Duration(seconds: 5)));
      // Find text elements to verify screen
      final Finder splashFinder = find.byKey(Key("splash"));
      print(splashFinder.evaluate());
      if (splashFinder.evaluate().isNotEmpty) {
        print("✅ Splash Screen Found!");
      }  else {
        print("❌ Unexpected Screen!");
      }
      final Finder loginFinder = find.byWidget(Scaffold());
      print(loginFinder.evaluate());
      if (loginFinder.evaluate().isNotEmpty) {
        print("✅ Login Screen Found!");
      }  else {
        print("❌ Unexpected Screen!");
      }
    });
  });
}
