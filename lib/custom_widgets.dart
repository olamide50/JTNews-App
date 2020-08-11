import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
/* import 'package:JTNews/news.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart'; */

class AppBarText extends StatelessWidget {
  AppBarText({@required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: 'Calibri',
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {this.newsImage,
      @required this.newsTitle,
      this.newsDetails,
      @required this.newsTime,
      @required this.newsSource,
      @required this.newsAuthor,
      @required this.newsUrl,
      @required this.newsContent,
      @required this.onPressed,
      @required this.onLongPressed});

  final String newsImage;
  final String newsTitle;
  final String newsDetails;
  final String newsSource;
  final String newsTime;
  final String newsAuthor;
  final String newsContent;
  final String newsUrl;
  final Function onPressed;
  final Function onLongPressed;

  @override
  Widget build(BuildContext context) {
    String altImage =
        'https://businessday.ng/wp-content/uploads/2019/10/BusinessDay-news-2-750x430.jpg';
    Image img;
    if (newsImage == 'No info') {
      img = Image.network(altImage, height: 55.0, width: 55.0);
    } else {
      img = Image.network(newsImage, height: 55.0, width: 55.0);
    }
    String time =
        new DateFormat('MMM d, h:mm a').format(DateTime.parse(newsTime));

    final Color colorDefault = Colors.black38;
    Color color = colorDefault;

    return ListTile(
      contentPadding: EdgeInsets.all(15.0),
      leading: img,
      title: Text(newsTitle),
      subtitle: Text('$time'),
      trailing: IconButton(
          icon: FaIcon(FontAwesomeIcons.star, color: color),
          onPressed: () {
            if (color == colorDefault) {
              
              {
                color = Colors.yellow;
              }
            }
          }),
      onTap: () {
        onPressed();
      },
      onLongPress: () {
        onLongPressed();
      },
    );
  }
}

class CustomFlatButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final FaIcon icon;
  final Function onTap;

  CustomFlatButton(
      {@required this.text,
      this.backgroundColor,
      @required this.icon,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        onTap();
      },
      child: Container(
        color: backgroundColor,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            icon,
            Padding(
                padding: EdgeInsets.only(left: 6.0),
                child: Text(text, style: TextStyle(fontSize: 20.0))),
          ],
        ),
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<String> source;
  final List<String> title;
  final List<String> content;
  final List<String> description;
  final List<String> imageString;
  final List<String> author;
  final List<String> time;
  final List<String> url;
  final String empty = 'No info';
  final Function onTap;

  CustomListView({
    @required this.source,
    @required this.title,
    @required this.content,
    @required this.description,
    @required this.imageString,
    @required this.author,
    @required this.time,
    @required this.url,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: title.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 5.0, color: Colors.grey),
      itemBuilder: (BuildContext context, int index) {
        return CustomListTile(
            newsImage: imageString[index],
            newsTitle: title[index],
            newsDetails: description[index],
            newsSource: source[index],
            newsTime: time[index],
            newsAuthor: author[index],
            newsContent: content[index],
            newsUrl: url[index],
            onPressed: () {
              onTap(index);
            },
            onLongPressed: null);
      },
    );
  }
}
