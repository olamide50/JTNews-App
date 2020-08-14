import 'package:flutter/material.dart';
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
        body: SafeArea(
          child: Center(
            child: Container(child: Column(children: <Widget>[
              Text('This Demo News App is made by'),
              Text('JTAppSoft International'),
              Text('Developer: '),
              Text('Olalekan Olamide'),
              Text('Source Code:'),
              Text('https://github.com/olamide50/JTNews-App')
            ],))
          ),
        ));
  }
}
