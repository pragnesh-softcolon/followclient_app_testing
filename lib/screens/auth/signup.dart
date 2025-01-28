import 'package:flutter/material.dart';
import 'package:followclient_app/components/TextFormField/custom_text_form_field.dart';
import 'package:followclient_app/components/TextFormField/custom_text_form_field_password.dart';
import 'package:followclient_app/navigation/navigation.dart';
import 'package:followclient_app/providers/locale_provider.dart';
import 'package:followclient_app/screens/Tabs/more/app_theme_screen.dart';
import 'package:followclient_app/screens/Tabs/more/language_screen.dart';
import 'package:followclient_app/theme/dark_color.dart';
import 'package:followclient_app/theme/light_color.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  static const routeName = "/signup";

  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _showPassword = true;
  bool _showConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  RegExp namePattern = RegExp(
      r"[^\p{L}\p{M}\p{N}\p{Zs}]|[\uD800-\uDBFF][\uDC00-\uDFFF]",
      unicode: true);
  RegExp emailPattern =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  RegExp passwordPattern = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$');
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        key: Key("appBar"),
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
                  child: Text(
                      localeProvider.localizations.translate('select_theme') ??
                          'Select Theme'),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                              .translate('register_acount') ??
                          'Register Account',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      localeProvider.localizations.translate(
                              'register_to_continue_to_follow_client') ??
                          'Register to continue to Follow Client.',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ],
                ),
                // column for first name input
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(
                      localeProvider.localizations.translate('first_name') ??
                          'First name',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    CustomTextFormField(
                      hintText: localeProvider.localizations
                              .translate('first_name') ??
                          'First name',
                      controller: _firstNameController,
                      onChanged: (value) {
                        // _formKey.currentState!.validate();
                        if (value.startsWith(" ")) {
                          _firstNameController.text = value.trim();
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localeProvider.localizations
                                  .translate('empty_fname_error') ??
                              'Please enter your first name';
                        }
                        if (namePattern.hasMatch(value)) {
                          return localeProvider.localizations
                                  .translate('invalid_name_format_error') ??
                              'Please enter a valid first name';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                // column for last name input
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(
                      localeProvider.localizations.translate('last_name') ??
                          'Last name',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    CustomTextFormField(
                      hintText:
                          localeProvider.localizations.translate('last_name') ??
                              'Last name',
                      controller: _lastNameController,
                      onChanged: (value) {
                        // _formKey.currentState!.validate();
                        if (value.startsWith(" ")) {
                          _lastNameController.text = value.trim();
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localeProvider.localizations
                                  .translate('empty_last_name_error') ??
                              'Please enter your last name';
                        }
                        if (namePattern.hasMatch(value)) {
                          return localeProvider.localizations
                                  .translate('invalid_name_format_error') ??
                              'Please enter a valid last name';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                // column for email input
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(
                      localeProvider.localizations.translate('email') ??
                          'Email',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    CustomTextFormField(
                      hintText:
                          localeProvider.localizations.translate('email') ??
                              'Email',
                      controller: _emailController,
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
                          return localeProvider.localizations
                                  .translate('invalid_email_format_error') ??
                              'Please enter a valid last name';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                // column for password input
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(
                      localeProvider.localizations.translate('password') ??
                          'password',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    CustomTextFormFieldPassword(
                      hintText:
                          localeProvider.localizations.translate('password') ??
                              'password',
                      controller: _passwordController,
                      onChanged: (value) {
                        // _formKey.currentState!.validate();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localeProvider.localizations
                                  .translate('empty_password_error') ??
                              'Please enter your password';
                        }
                        if (!passwordPattern.hasMatch(value)) {
                          return localeProvider.localizations
                                  .translate('invalid_password_format_error') ??
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
                // column for confirm password input
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(
                      localeProvider.localizations
                              .translate('confirm_password') ??
                          'Confirm Password',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    CustomTextFormFieldPassword(
                      hintText: localeProvider.localizations
                              .translate('confirm_password') ??
                          'Confirm Password',
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        // _formKey.currentState!.validate();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localeProvider.localizations
                                  .translate('empty_password_error') ??
                              'Please enter your password';
                        }
                        if (!passwordPattern.hasMatch(value)) {
                          return localeProvider.localizations
                                  .translate('invalid_password_format_error') ??
                              'Password must include at least one special character, one digit, one uppercase letter, and one lowercase letter';
                        }
                        return null;
                      },
                      obscureText: _showConfirmPassword,
                      suffixIconTap: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("validate");
                    }
                  },
                  child: Text(
                    localeProvider.localizations.translate('register') ??
                        'Register',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    localeProvider.localizations
                            .translate('already_have_an_account') ??
                        'Already have an account?',
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
                            ? DarkColor()
                                .backgroundColor // Gray color for dark mode
                            : LightColor().backgroundColor),
                    // Transparent background
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: Colors.grey, // Grey border color
                          width: 1, // Border width
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigation().goBack();
                    setState(() {
                      _formKey.currentState?.reset();
                    });
                  },
                  child: Text(
                    localeProvider.localizations.translate('login') ?? 'Login',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
