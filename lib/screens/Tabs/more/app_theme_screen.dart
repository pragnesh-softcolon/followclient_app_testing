import 'dart:async';

import 'package:flutter/material.dart';
import 'package:followclient_app/providers/locale_provider.dart';
import 'package:followclient_app/providers/theme_provider.dart';
import 'package:followclient_app/theme/dark_color.dart';
import 'package:followclient_app/theme/light_color.dart';
import 'package:provider/provider.dart';

class AppThemeScreen extends StatefulWidget {
  static const routeName = "/theme-selection";

  const AppThemeScreen({super.key});

  @override
  State<AppThemeScreen> createState() => _AppThemeScreenState();
}

class _AppThemeScreenState extends State<AppThemeScreen> {
  List<String> modes = ["Light Mode", "Dark Mode", "System Theme"];
  List<String> multiLanguageKey = ["light_mode", "dark_mode", "system_theme"];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final localeProvider = Provider.of<LocaleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        key: const Key('appBar'),
        elevation: 0,
        title: Text(
          key: const Key('appBar-text'),
          localeProvider.localizations.translate('select_theme') ??
              'Select Theme',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            ListView.builder(
              key: const Key('listview-builder'),
              shrinkWrap: true,
              itemCount: modes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    key: Key('listview-builder-inkwell-$index'),
                    onTap: () async {
                      switch (modes[index]) {
                        case "Light Mode":
                          themeProvider.setThemeMode(
                              ThemeMode.light, "light", context);
                          await Future.delayed(Duration(milliseconds: 150));
                          themeProvider.dummyFun();

                          break;
                        case "Dark Mode":
                          themeProvider.setThemeMode(
                              ThemeMode.dark, "dark", context);
                          await Future.delayed(Duration(milliseconds: 150));
                          themeProvider.dummyFun();
                          break;
                        case "System Theme":
                          themeProvider.setThemeMode(
                              ThemeMode.system, "system", context);
                          await Future.delayed(Duration(milliseconds: 150));
                          themeProvider.dummyFun();
                          break;
                        default:
                          themeProvider.setThemeMode(
                              ThemeMode.system, "system", context);
                          await Future.delayed(Duration(milliseconds: 150));
                          themeProvider.dummyFun();
                          break;
                      }
                    },
                    child: Card(
                      key: Key('listview-builder-card-$index'),
                      // elevation: isSelected ? 2 : 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: modes[index]
                                  .toLowerCase()
                                  .contains(themeProvider.selectedTheme)
                              ? LightColor().buttonColor
                              : DarkColor().borderColor,
                          width:
                              modes[index].contains(themeProvider.selectedTheme)
                                  ? 2
                                  : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                key: Key('listview-builder-language-$index'),
                                localeProvider.localizations
                                        .translate(multiLanguageKey[index]) ??
                                    'Select Theme',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ),
                          if (modes[index]
                              .toLowerCase()
                              .contains(themeProvider.selectedTheme)) ...[
                            Icon(
                              key: Key('listview-builder-selected-icon-$index'),
                              Icons.check_circle,
                              size: 24,
                            ),
                          ] else ...[
                            Icon(
                              key: Key(
                                  'listview-builder-unselected-icon-$index'),
                              Icons.circle_outlined,
                              size: 24,
                            ),
                          ],
                          Container(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
