import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'search.dart';
import 'package:JTNews/decodeSearch.dart';
import 'package:JTNews/network.dart';
import 'package:JTNews/const.dart';
import 'retrySearch.dart';
import 'package:JTNews/secret.dart';

class NewSearch extends StatefulWidget {
  static String id = 'Search';
  static String headerText = 'Search';
  @override
  _NewSearchState createState() => _NewSearchState();
}

class _NewSearchState extends State<NewSearch> {
  static String querySearch;

  String _futureNews;
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
  int pop = 1;
  String empty = 'No info';
  bool isLoading = false;
  static String _selectedUrl =
      'http://newsapi.org/v2/top-headlines?country=ng&q=$querySearch&apiKey=$APIKey';
  DecodeSearch decoder = DecodeSearch();
  bool con = true;
  String conErrorMsg;

  void _getNews(String _selectedUrl) async {
    try {
      _futureNews = (await fetchNews(_selectedUrl));
      isLoading = false;
      if (_futureNews == retry) {
        Navigator.pushNamed(context, RetrySearch.id);
      } else {
        news = decoder.getData(_futureNews, source, title, content, description,
            imageString, author, time, url, number, empty);

        source = news[0];
        title = news[1];
        content = news[2];
        description = news[3];
        imageString = news[4];
        author = news[5];
        time = news[6];
        url = news[7];

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Search(
                    author: author,
                    source: source,
                    title: title,
                    content: content,
                    description: description,
                    imageString: imageString,
                    time: time,
                    url: url,
                    query: querySearch,
                    pop: pop,
                  )),
        );
      }
    } catch (e) {
      con = false;
      conErrorMsg = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.times),
          onPressed: () {
            Navigator.pop((context));
          },
        ),
        title: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextField(
              onChanged: (value) {
                querySearch = value;
              },
              autocorrect: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Calibri',
              ),
            )),
        actions: <Widget>[
          isLoading
              ? CircularProgressIndicator()
              : FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.white70, width: 4.0),
                  ),
                  child: Text('Search',
                      style: TextStyle(color: Colors.white70, fontSize: 18.0)),
                  onPressed: () {
                    isLoading = true;
                    _getNews(_selectedUrl);
                  },
                ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: con
                ? Container()
                : RaisedButton(
                    child: Text('RETRY, CONNECTION ERROR: ($conErrorMsg)'),
                    onPressed: () {
                      con = true;
                      _getNews(_selectedUrl);
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
