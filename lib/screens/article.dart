import 'package:flutter/material.dart';
import 'package:JTNews/custom_widgets.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

class ArticleView extends StatelessWidget {
  static String id = 'article_screen';
  static String headerText = 'Article';
  final String title;
  final String time;
  final String author;
  final String content;
  final String imageUrl;
  final String description;
  final String url;

  ArticleView({
    this.title,
    this.time,
    this.author,
    this.content,
    this.imageUrl,
    this.description,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppBarText(title: ArticleView.headerText),
          actions: <Widget>[
            IconButton(
                icon: FaIcon(FontAwesomeIcons.shareAlt),
                onPressed: () {
                  Share.share(title, subject: 'Breaking news: ');
                })
          ],
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Color(0xFFFBFCE1),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 21.0),
                    ),
                  ),
                  Image.network(
                    imageUrl,
                    fit: BoxFit.scaleDown,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 12.0),
                    child: Text(
                      new DateFormat('MMM d, h:mm a').format(
                        DateTime.parse(time),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Text(content, style: TextStyle(fontSize: 14.0)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 12.0),
                    child: Text(
                      'Author: $author',
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    'source: $url',
                    style: TextStyle(
                      color: Color(0xFF1E576D),
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
