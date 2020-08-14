import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:JTNews/custom_widgets.dart';
import 'article.dart';
import 'package:JTNews/network.dart';
import 'package:JTNews/decodeSearch.dart';
import 'retrySearch.dart';
import 'package:JTNews/const.dart';
import 'package:JTNews/secret.dart';

class Search extends StatefulWidget {
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
  final int pop;

  Search({
    this.author,
    this.source,
    this.title,
    this.content,
    this.description,
    this.imageString,
    this.time,
    this.url,
    this.query,
    this.pop,
  });

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = false;
  static String querySearch;

  final searchController = TextEditingController(text: querySearch);

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
  int pop;
  String empty = 'No info';
  String selectedUrl;

  DecodeSearch decoder = DecodeSearch();
  bool con = true;
  String conErrorMsg;
  int count = 0;

  Future<void> _getNews() async {
    try {
      _futureNews = (await fetchNews(selectedUrl));
      isLoading = false;
      if (_futureNews == retry) {
        Navigator.pushNamed(context, RetrySearch.id);
      } else {
        print(_futureNews);
        news = decoder.getData(_futureNews, source, title, content, description,
            imageString, author, time, url, number, empty);

        if (news == null) {
          Navigator.pushNamed(context, RetrySearch.id);
        } else {
          source = news[0];
          title = news[1];
          content = news[2];
          description = news[3];
          imageString = news[4];
          author = news[5];
          time = news[6];
          url = news[7];
          number = news[8];

          Navigator.pushAndRemoveUntil(
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
              ),
            ),
            (route) {
              return count++ == pop + 1;
            },
          );
        }
      }
    } catch (e) {
      con = false;
      conErrorMsg = e.toString();
    }
  }

  Future<void> _fetch() async {
    querySearch = searchController.text;
    selectedUrl =
        'https://newsapi.org/v2/top-headlines?country=ng&q=$querySearch&apiKey=$APIKey';
    await _getNews();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      querySearch = widget.query;
      source = widget.source;
      title = widget.title;
      content = widget.content;
      description = widget.description;
      imageString = widget.imageString;
      author = widget.author;
      time = widget.time;
      url = widget.url;
      pop = widget.pop + 1;

      searchController.text = widget.query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.times),
          onPressed: () {
            // Navigator.popUntil(context, ModalRoute.withName(Load.id));
            // Navigator.pop(context);
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == pop;
            });
          },
        ),
        title: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextField(
              controller: searchController,
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
              isLoading = true;
              setState(() {
                _fetch();
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
              child: Expanded(
            child: isLoading
                ? CircularProgressIndicator()
                : con
                    ? Container(
                        child: RaisedButton(
                          child:
                              Text('RETRY, CONNECTION ERROR: ($conErrorMsg)'),
                          onPressed: () {
                            con = true;
                            _getNews();
                          },
                        ),
                      )
                    : CustomListView(
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
                        }),
          )),
        ),
      ),
    );
  }
}
/* Widget _selectWidget() {
    if (select == false) {
      setState(() => _widget = _body);
    } else {
      setState(() {
        _widget = CustomListView(
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
            });
      });
    }
    return _widget;
  }
} */
