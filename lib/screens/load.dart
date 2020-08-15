import 'package:flutter/material.dart';
import 'package:JTNews/network.dart';
import 'package:JTNews/decodeSearch.dart';
import 'package:JTNews/const.dart';
import 'package:JTNews/secret.dart';
import 'home.dart';
import 'package:splashscreen/splashscreen.dart';
import 'loadError.dart';

class Load extends StatefulWidget {
  static String id = 'load_screen';
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {
  String futureNews;
  static int pageSize = 20;
  List<String> source = [];
  List<String> title = [];
  List<String> content = [];
  List<String> description = [];
  List<String> imageString = [];
  List<String> author = [];
  List<String> time = [];
  List<String> url = [];
  List<Object> news = [];
  int number = pageSize;
  String empty = 'No info';
  static String selectedUrl =
      'http://newsapi.org/v2/top-headlines?country=ng&apiKey=$APIKey';
  DecodeSearch decoder = DecodeSearch();
  bool con = true;
  String conErrorMsg;

  void _getNews(String selectedUrl) async {
    try {
      futureNews = (await fetchNews(selectedUrl));
      if (futureNews == retry) {
        Navigator.popAndPushNamed(context, LoadError.id);
      } else {
        news = decoder.getData(futureNews, source, title, content, description,
            imageString, author, time, url, number, empty);

        source = news[0];
        title = news[1];
        content = news[2];
        description = news[3];
        imageString = news[4];
        author = news[5];
        time = news[6];
        url = news[7];
        int count = 0;

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Home(
                author: author,
                source: source,
                title: title,
                content: content,
                description: description,
                imageString: imageString,
                time: time,
                url: url,
              ),
            ), (route) {
          return count++ == 1;
        });
      }
    } catch (e) {
      con = false;
      conErrorMsg = e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    _getNews(selectedUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SplashScreen(
            seconds: 5,
            title: new Text(
              'JTNews Demo',
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            image: new Image.asset('assets/images/jtnews.png'),
            backgroundColor: Colors.indigo,
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            loadingText: Text('Loading...'),
            loaderColor: Colors.red),
      ),
    );
  }
}
