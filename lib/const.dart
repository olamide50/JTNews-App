import 'dart:ui';

import 'package:JTNews/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const String retry = 'RETRY';
const String loading = 'LOADING';
const int pageSize = 20;

final drawerWidget = Drawer(
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
        onTap: () {},
        icon: FaIcon(
          FontAwesomeIcons.star,
          color: Colors.yellow,
        ),
      ),
      SizedBox(height: 20.0),
      CustomFlatButton(
        text: 'Settings',
        onTap: () {},
        icon: FaIcon(
          FontAwesomeIcons.cog,
          color: Colors.black,
        ),
      ),
    ],
  ),
);
