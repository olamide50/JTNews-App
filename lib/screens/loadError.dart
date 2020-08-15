import 'package:flutter/material.dart';
import 'package:JTNews/custom_widgets.dart';
import 'package:JTNews/screens/load.dart';

class LoadError extends StatefulWidget {
  static String id = 'LoadErrorScreen';
  @override
  _LoadErrorState createState() => _LoadErrorState();
}

class _LoadErrorState extends State<LoadError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(
          title: 'Bookmarks',
        ),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('RETRY (NO INTERNET)'),
          onPressed: () {
            Navigator.pushNamed(context, Load.id);
          },
        ),
      ),
    );
  }
}
