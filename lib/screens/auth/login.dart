import 'package:flutter/material.dart';
import 'package:followclient_app/components/TextFormField/custom_text_form_field.dart';
import 'package:followclient_app/components/TextFormField/custom_text_form_field_password.dart';
import 'package:followclient_app/navigation/navigation.dart';
import 'package:followclient_app/screens/Tabs/more/app_theme_screen.dart';
import 'package:followclient_app/screens/auth/signup.dart';
import 'package:followclient_app/screens/Tabs/more/language_screen.dart';
import 'package:followclient_app/theme/dark_color.dart';
import 'package:followclient_app/theme/light_color.dart';
import 'package:provider/provider.dart';
import '../../providers/locale_provider.dart';
import '../../utils/user_prefs.dart';

class Login extends StatefulWidget {
  static const routeName = "/login";

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showPassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegExp passwordPattern = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$');

  RegExp emailPattern =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  List<String> choices = ["dark", "light", "system"];

  @override
  void initState() {
   // load();
    print("Login screen");
    Future.microtask(() async {
      Provider.of<LocaleProvider>(context,listen: false);
      await load();
    });
    // TODO: implement initState
    super.initState();
  }

  Future<void> load() async {
    try {
      print("load");
      final locale = await UserPreference().getLocale();
      print(locale);
      if (locale.isNotEmpty) {
        final localeProvider = Provider.of<LocaleProvider>(
            context, listen: false);
        localeProvider.changeLocale(Locale(locale));
      } else {
        await UserPreference().setLocale('en');
      }
    }catch(e){
      print(e);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return Scaffold(
        appBar: AppBar(
          key: Key("APPBAR"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == "Select Language") {
                  await Navigation().next(LanguageSelectionScreen.routeName);
                } else if (value == "Select Theme") {
                  await Navigation().next(AppThemeScreen.routeName);
                }
                setState(() {
                  _formKey.currentState?.reset();
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: "Select Language",
                    child: Text(localeProvider.localizations
                            .translate('select_language') ??
                        'Select Language'),
                  ),
                  PopupMenuItem<String>(
                    value: "Select Theme",
                    child: Text(localeProvider.localizations
                            .translate('select_theme') ??
                        'Select Theme'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localeProvider.localizations
                                  .translate('welcome_back') ??
                              'Welcome back!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          localeProvider.localizations.translate(
                                  'signin_to_continue_to_follow_client') ??
                              'Sign in to continue to Follow Client',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text(
                          localeProvider.localizations.translate('email') ??
                              'Email',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        CustomTextFormField(
                          hintText:
                              localeProvider.localizations.translate('email') ??
                                  'Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            // _formKey.currentState!.validate();
                            if (value.startsWith(" ")) {
                              _emailController.text = value.trim();
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return localeProvider.localizations
                                      .translate('empty_email_error') ??
                                  'Please enter your last name';
                            }
                            if (!emailPattern.hasMatch(value)) {
                              return localeProvider.localizations.translate(
                                      'invalid_email_format_error') ??
                                  'Please enter a valid last name';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text(
                          localeProvider.localizations.translate('password') ??
                              'Password',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        CustomTextFormFieldPassword(
                          hintText: localeProvider.localizations
                                  .translate('password') ??
                              'Password',
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            // _formKey.currentState!.validate();
                            if (value.startsWith(" ")) {
                              _passwordController.text = value.trim();
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return localeProvider.localizations
                                      .translate('empty_password_error') ??
                                  'Please enter your password';
                            }
                            if (!passwordPattern.hasMatch(value)) {
                              return localeProvider.localizations.translate(
                                      'invalid_password_format_error') ??
                                  'Password must include at least one special character, one digit, one uppercase letter, and one lowercase letter';
                            }
                            return null;
                          },
                          obscureText: _showPassword,
                          suffixIconTap: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 1,
                      children: [
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       value: _rememberMe,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           _rememberMe = !_rememberMe;
                        //         });
                        //       },
                        //       activeColor: brightness == Brightness.light
                        //           ? DarkColor().backgroundColor
                        //           : LightColor().backgroundColor,
                        //       checkColor: brightness == Brightness.light
                        //           ? LightColor().backgroundColor
                        //           : DarkColor().backgroundColor,
                        //     ),
                        //     Text(
                        //       "Remember me",
                        //       style:
                        //           Theme.of(context).textTheme.titleSmall!.copyWith(
                        //                 fontWeight: FontWeight.normal,
                        //               ),
                        //     ),
                        //   ],
                        // ),
                        InkWell(
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _formKey.currentState?.reset();
                            });
                          },
                          child: Text(
                            localeProvider.localizations
                                    .translate('forgot_password') ??
                                'Forgot Password?',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color:
                                        Theme.of(context)
                                                    .brightness ==
                                                Brightness.dark
                                            ? Colors.grey
                                            : Colors.blue,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decorationThickness: 2.0,
                                    height: 1.5,
                                    decorationColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.grey
                                            : Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: Text(
                        localeProvider.localizations.translate('login') ??
                            'Login',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        localeProvider.localizations
                                .translate('dont_have_account') ??
                            "Don't have an account?",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).brightness == Brightness.dark
                                ? DarkColor().backgroundColor
                                : LightColor().backgroundColor),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await Navigation().next(Signup.routeName);
                        setState(() {
                          _formKey.currentState?.reset();
                        });
                      },
                      child: Text(
                        localeProvider.localizations.translate('signup') ??
                            'SignUp',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
