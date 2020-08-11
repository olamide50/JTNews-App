import 'package:flutter/material.dart';

class RetrySearch extends StatelessWidget {
  static String id = 'retry_search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('JTNews'),
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Retry'),
              ),
            ),
          ),
        ));
  }
}
