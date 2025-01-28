import 'package:flutter/material.dart';
import 'package:followclient_app/navigation/navigation.dart';
import 'package:followclient_app/providers/theme_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import '../../../../providers/locale_provider.dart';
import '../../../../utils/language/all_language.dart';
import '../../../utils/language/app_localizations.dart';
import '../../../../theme/light_color.dart';
import '../../../../theme/dark_color.dart';

class LanguageSelectionScreen extends StatefulWidget {
  static const routeName = "/language-selection";

  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      key: const Key('scaffold'),
      appBar: AppBar(
        key: const Key('appBar'),
        elevation: 0,
        title: Text(
          key: const Key('appBar-text'),
          localeProvider.localizations.translate('select_language') ??
              'Select Language',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              key: const Key('appBar-icon-button'),
              onPressed: () {},
              icon: Icon(
                key: const Key('appBar-icon-button-icon'),
                Icons.notification_add_outlined,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.builder(
              key: const Key('listview-builder'),
              itemCount: AllLanguage().languages.length,
              itemBuilder: (context, index) {
                final languageKey =
                    AllLanguage().languages.keys.elementAt(index);
                final isSelected = AllLanguage().languages[languageKey] ==
                    localeProvider.selectedLanguageKey;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    key: Key('listview-builder-inkwell-$index'),
                    onTap: () async {
                      if (AllLanguage().languages[languageKey] !=
                          localeProvider.selectedLanguageKey) {
                        try {
                          await localeProvider.changeLocale(
                            Locale(AllLanguage().languages[languageKey]),
                          );
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(localeProvider.localizations
                                        .translate('language_change_error') ??
                                    'Failed to change language'),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: Card(
                      key: Key('listview-builder-card-$index'),
                      // elevation: isSelected ? 2 : 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected
                              ? LightColor().buttonColor
                              : DarkColor().borderColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                key: Key('listview-builder-language-$index'),
                                languageKey,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ),
                          if (isSelected) ...[
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
          ),
          if (localeProvider.isLoader) ...[
            Container(
              height: double.infinity,
              width: double.infinity,
              color:themeProvider.themeMode == ThemeMode.dark?DarkColor().backgroundColor.withValues(alpha: 0.5): LightColor().backgroundColor.withValues(alpha: 0.5),
              child: Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballClipRotateMultiple,
                    colors: themeProvider.themeMode == ThemeMode.dark
                        ? [LightColor().backgroundColor]
                        : [DarkColor().backgroundColor],
                  ),
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}
