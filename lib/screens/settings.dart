import 'package:flutter/material.dart';
import 'package:JTNews/const.dart';
import 'package:JTNews/custom_widgets.dart';

class Settings extends StatefulWidget {
  // Class properties
  static String id = 'settings';
  static String headerText = 'Settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (AppBarText(title: Settings.headerText)),
        ),
        drawer: drawerWidget,
        body: Container(
          child: ListView(),
        ));
  }
}
