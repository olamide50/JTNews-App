class News {
  final int id;
  final String source;
  final String title;
  final String content;
  final String description;
  final String imageString;
  final String author;
  final String time;
  final String url;

  News(
      {this.id,
      this.source,
      this.title,
      this.content,
      this.description,
      this.imageString,
      this.author,
      this.time,
      this.url});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'source': source,
      'title': title,
      'content': content,
      'description': description,
      'imageString': imageString,
      'author': author,
      'time': time,
      'url': url,
    };
  }
}
