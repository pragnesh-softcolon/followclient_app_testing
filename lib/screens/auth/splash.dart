import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:followclient_app/screens/auth/login.dart';
import 'package:followclient_app/theme/light_color.dart';
import 'package:followclient_app/utils/svg_icons.dart';
import 'package:followclient_app/utils/user_prefs.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../providers/locale_provider.dart';
import '../../theme/dark_color.dart';

class Splash extends StatefulWidget {
  static const routeName = "/splash";

  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {

    // print(localeProvider.locale);
    Future.microtask(() async {
      Provider.of<LocaleProvider>(context,listen: false);
     await next();
    });
    // final localeProvider =   Provider.of<LocaleProvider>(context,listen: false);
    super.initState();
  }

  Future<void> next()  async {
    print("Next");
    String locale = await UserPreference().getLocale();
    print("KKKKKKK");
    if (locale.isNotEmpty) {
      print("Locale is not empty");
      final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
      localeProvider.changeLocale(Locale(locale));
      print("EMpty End");
    } else {
      print("locale is empty");
      print("wait");
      final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
      localeProvider.changeLocale(Locale("en"));
    }
    print("before wait");
    // await Future.delayed(Duration(seconds: 0)).then((value) {
    //   print(value);
    // },);
    // await Future.delayed(Duration(seconds: 2));
    print("navigate to login");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        print("navigate to login");
        Get.offAllNamed(Login.routeName);

      });
    });
    // await Future.delayed(Duration(seconds: 2));
    // Navigation().navigateToNextAndRemovePreviousAll(Login.routeName);
    print("navigate to login 2");
  }

  @override
  Widget build(BuildContext context) {
   // final brightness = MediaQuery.of(context).platformBrightness;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final localeProvider = Provider.of<LocaleProvider>(context,listen: true);
    // if (localeProvider.isLoader) {
    //   print("is loading");
    //   return Scaffold(body: Center(child: CircularProgressIndicator()));
    // }
    print("loading done");
    return Scaffold(
      key: Key("splash"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.2), // Custom height instead of Spacer
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SvgPicture.string(
                    themeProvider.themeMode == ThemeMode.light
                        ? SvgIcons().splashIconLight
                        : SvgIcons().splashIconDark,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.1), // Custom height instead of Spacer
              ErrorInfo(
                title: localeProvider.localizations.translate('welcome_to_follow_client') ??
                    'Welcome to Follow Client',
                description: localeProvider.localizations.translate('welcome_message') ??
                    "We're setting things up for you. This will only take a moment.",
                button: Transform.scale(
                  scale: 1.8,
                  child: SizedBox(
                    height: 90,
                    width: 90,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballClipRotateMultiple,
                        colors: themeProvider.themeMode == ThemeMode.dark
                            ? [LightColor().backgroundColor]
                            : [DarkColor().backgroundColor]),
                  ),
                ),
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.title,
    required this.description,
    this.button,
    this.btnText,
    required this.press,
  });

  final String title;
  final String description;
  final Widget? button;
  final String? btnText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16 * 2.5),
            button ??
                ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  child: Text(btnText ?? "Retry".toUpperCase()),
                ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
