import 'package:flutter/material.dart';
import 'package:JTNews/custom_widgets.dart';
import 'package:JTNews/database.dart';

class Bookmarks extends StatefulWidget {
  static String id = 'bookmarks';
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: AppBarText(title: 'Bookmarks',),
    ),
    body: SafeArea(child: Center(child: Container(),)),);
  }
}
