import 'news.dart';

class Bookmark {
  String source;
  String title;
  String content;
  String description;
  String imageString;
  String author;
  String time;
  String url;
  int id;

  Bookmark(
      {this.source,
      this.title,
      this.content,
      this.description,
      this.imageString,
      this.author,
      this.time,
      this.url,
      this.id});

  Map toJson() => {
        'source': source,
        'title': title,
        'content': content,
        'description': description,
        'imageString': imageString,
        'author': author,
        'time': time,
        'url': url,
        'id': id,
      };
}

class Converter {
  News object;
  Converter([this.object]);

  Map toJson() {
    Map object = this.object != null ? this.object.toMap() : null;
    return {'object': object};
  }
}
