import 'dart:ui';
import 'package:JTNews/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'screens/settings.dart';
import 'screens/bookmarks.dart';

const String retry = 'RETRY';
const String loading = 'LOADING';
const int pageSize = 20;

Widget drawerWidget(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          padding: EdgeInsets.zero,
          child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
              child: Text('Select Option', style: TextStyle(fontSize: 45.0))),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        CustomFlatButton(
          text: 'Bookmarks',
          onTap: () {
            Navigator.popAndPushNamed(context, Bookmarks.id);
          },
          icon: FaIcon(
            FontAwesomeIcons.star,
            color: Colors.yellow,
          ),
        ),
        SizedBox(height: 20.0),
        CustomFlatButton(
          text: 'Settings',
          onTap: () {
            Navigator.popAndPushNamed(context, Settings.id);
          },
          icon: FaIcon(
            FontAwesomeIcons.cog,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
