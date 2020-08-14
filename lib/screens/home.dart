import 'package:JTNews/network.dart';
import 'package:JTNews/screens/newSearch.dart';
import 'package:flutter/material.dart';
import 'package:JTNews/const.dart';
import 'package:JTNews/custom_widgets.dart';
import 'package:JTNews/secret.dart';
import 'article.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:JTNews/decodeSearch.dart';
import 'load.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  final List<String> source;
  final List<String> title;
  final List<String> content;
  final List<String> description;
  final List<String> imageString;
  final List<String> author;
  final List<String> time;
  final List<String> url;

  const Home(
      {this.source,
      this.title,
      this.content,
      this.description,
      this.imageString,
      this.author,
      this.time,
      this.url});
  // Class properties
  static String headerText = 'JTNews';
  static String id = 'home_screen';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  String empty = 'No info';
  bool con = true;
  String conErrorMsg = '';

  DecodeSearch decoder = DecodeSearch();

  void _getNews() async {
    try {
      _futureNews = (await fetchNews(selectedUrl));
      if (_futureNews == retry) {
        Navigator.pushNamed(context, Load.id);
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
      }
    } catch (e) {
      con = false;
      conErrorMsg = e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    source = widget.source;
    title = widget.title;
    content = widget.content;
    description = widget.description;
    imageString = widget.imageString;
    author = widget.author;
    time = widget.time;
    url = widget.url;
  }

  static String urlAll =
      'http://newsapi.org/v2/top-headlines?country=ng&apiKey=$APIKey';
  static String urlBis =
      'http://newsapi.org/v2/top-headlines?country=ng&category=business&apiKey=$APIKey';
  static String urlEnt =
      'http://newsapi.org/v2/top-headlines?country=ng&category=entertainment&apiKey=$APIKey';
  static String urlHlt =
      'http://newsapi.org/v2/top-headlines?country=ng&category=health&apiKey=$APIKey';
  static String urlSpt =
      'http://newsapi.org/v2/top-headlines?country=ng&category=sports&apiKey=$APIKey';

  String selectedUrl = urlAll;

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        selectedUrl = urlAll;
      } else if (_selectedIndex == 1) {
        selectedUrl = urlSpt;
      } else if (_selectedIndex == 2) {
        selectedUrl = urlBis;
      } else if (_selectedIndex == 3) {
        selectedUrl = urlEnt;
      } else {
        selectedUrl = urlHlt;
      }
      _getNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(title: Home.headerText),
        actions: <Widget>[
          IconButton(
              icon: FaIcon(FontAwesomeIcons.search),
              onPressed: () {
                Navigator.pushNamed((context), NewSearch.id);
              }),
        ],
      ),
      drawer: drawerWidget(context),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        iconSize: 10.0,
        items: [
          // this will be set when a new tab is tapped

          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('All'),
            // backgroundColor: Colors.lightBlue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessible_forward),
            title: Text('Sports'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            title: Text('Health'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.theaters),
            title: Text('Entertainment'),
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: SafeArea(
          child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            child: con
                ? CustomListView(
                  selector: 1,
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
                    })
                : Center(
                    child: Container(
                        child: RaisedButton(
                    child: Text('RETRY, CONNECTION ERROR: ($conErrorMsg)'),
                    onPressed: () {
                      con = true;
                      _getNews();
                    },
                  ))),
          ),
        ],
      )),
    );
  }
}
