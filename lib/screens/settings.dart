import 'package:flutter/material.dart';
import 'package:JTNews/custom_widgets.dart';
import 'package:preferences/preferences.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class Settings extends StatefulWidget {
  // Class properties
  static String id = 'settings';
  static String headerText = 'Settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  void changeColor() {
    DynamicTheme.of(context).setThemeData(ThemeData(
        primaryColor: Theme.of(context).primaryColor == Colors.indigo
            ? Colors.red
            : Colors.indigo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (AppBarText(title: Settings.headerText)),
      ),
      body: PreferencePage([
        PreferenceTitle('Personalization'),
        RadioPreference(
          'Light Theme',
          'light',
          'ui_theme',
          isDefault: true,
          onSelect: () {
            DynamicTheme.of(context).setBrightness(Brightness.light);
          },
        ),
        RadioPreference(
          'Dark Theme',
          'dark',
          'ui_theme',
          onSelect: () {
            DynamicTheme.of(context).setBrightness(Brightness.dark);
          },
        ),
        PreferenceTitle('About'),
        PreferenceText(
          PrefService.getString('dev') ?? '',
          style: TextStyle(color: Colors.grey),
        ),
        PreferenceText(
          PrefService.getString('email') ?? '',
          style: TextStyle(color: Colors.grey),
        ),
        PreferenceText(
          PrefService.getString('phone') ?? '',
          style: TextStyle(color: Colors.grey),
        ),
      ]),
    );
  }
}
