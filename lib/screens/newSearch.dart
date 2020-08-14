import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:JTNews/decodeSearch.dart';
import 'package:JTNews/network.dart';
import 'package:JTNews/const.dart';
import 'retrySearch.dart';
import 'package:JTNews/secret.dart';
import 'package:JTNews/custom_widgets.dart';
import 'article.dart';

class NewSearch extends StatefulWidget {
  static String id = 'Search';
  static String headerText = 'Search';

  final List<String> author,
      source,
      title,
      content,
      description,
      imageString,
      time,
      url;
  final String query;
  NewSearch({
    this.author,
    this.source,
    this.title,
    this.content,
    this.description,
    this.imageString,
    this.time,
    this.url,
    this.query,
  });
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
  static String _selectedUrl;
  DecodeSearch decoder = DecodeSearch();
  bool con = true;
  String conErrorMsg;
  final searchController = TextEditingController(text: querySearch);

  void _getNews(String _selectedUrl) async {
    try {
      _futureNews = (await fetchNews(_selectedUrl));

      if (_futureNews == retry) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(context, RetrySearch.id);
      } else {
        setState(() {
          isLoading = false;
        });
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

        setState(() {});
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

    //setState(() {});
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
                controller: searchController,
                /* onChanged: (value) {
                  querySearch = value;
                  if (querySearch == null) {
                    querySearch = 'all';
                  }
                }, */
                autocorrect: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Calibri',
                ),
              )),
          actions: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.white70, width: 4.0),
              ),
              child: Text('Search',
                  style: TextStyle(color: Colors.white70, fontSize: 18.0)),
              onPressed: () {
                querySearch = searchController.text;
                _selectedUrl =
      'http://newsapi.org/v2/top-headlines?country=ng&q=$querySearch&apiKey=$APIKey';
                isLoading = true;
                _getNews(_selectedUrl);
              },
            ),
          ],
        ),
        body: SafeArea(
            child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : source.length == 0
                  ? Text('No item found. Try another search query.')
                  : Container(
                      child: CustomListView(
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
                        },
                      ),
                    ),
        )));
  }
}
