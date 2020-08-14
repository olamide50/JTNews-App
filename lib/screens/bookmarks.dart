import 'package:flutter/material.dart';
import 'package:JTNews/custom_widgets.dart';
import 'package:JTNews/database.dart';
import 'article.dart';
import 'package:JTNews/news.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class Bookmarks extends StatefulWidget {
  static String id = 'bookmarks';
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  List<String> source = [];
  List<String> title = [];
  List<String> content = [];
  List<String> description = [];
  List<String> imageString = [];
  List<String> author = [];
  List<String> time = [];
  List<String> url = [];
  //Future<List<Object>> news;
  Object newsObject;
  List<int> id = [];

  Future<void> assignData() async {
    var data = await getNewsList();
    int length = data.length;
    id.clear();
    source.clear();
    title.clear();
    content.clear();
    description.clear();
    imageString.clear();
    author.clear();
    time.clear();
    url.clear();

    for (int i = 0; i < length; i++) {
      id.add(data[i].toMap()['id']);
      source.add(data[i].toMap()['source']);
      title.add(data[i].toMap()['title']);
      content.add(data[i].toMap()['content']);
      description.add(data[i].toMap()['description']);
      imageString.add(data[i].toMap()['imageString']);
      author.add(data[i].toMap()['author']);
      time.add(data[i].toMap()['time']);
      url.add(data[i].toMap()['url']);
    }

    setState(() {
      
    });
  }

  Future<List<News>> getNewsList() async {
    List<News> data = await newsList();
    return data;
  }

  @override
  void initState() {
    super.initState();
    assignData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(
          title: 'Bookmarks',
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Container(
            child: CustomListView(
                id: id,
                selector: 2,
                source: source,
                title: title,
                content: content,
                description: description,
                imageString: imageString,
                author: author,
                time: time,
                url: url,
                onTap: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleView(
                        author: author[index],
                        title: title[index],
                        content: content[index],
                        description: description[index],
                        imageUrl: imageString[index],
                        time: time[index],
                        url: url[index],
                      ),
                    ),
                  );
                })),
      )),
    );
  }
}
