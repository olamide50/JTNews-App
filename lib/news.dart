class News {
  final String status;
  final int totalResults;
  final ArticleList articles;

  News({this.status, this.totalResults, this.articles});

  factory News.fromJson(Map<String, dynamic> json) {
    /* var list = json['articles'] as List;
    List<ArticleList> articleList =
        list.map((i) => ArticleList.fromJson(i)).toList(); */
    return News(
        articles: ArticleList.fromJson(json['articles']),
        status: json['status'],
        totalResults: json['totalResults']);
  }
}

class Source {
  final String id;
  final String name;

  Source({this.id, this.name});
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    /* var list = json['sources'] as List;
    List<Source> sourceList = list.map((i) => Source.fromJson(i)).toList(); */
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}

class ArticleList {
  final List<Article> articles;
  ArticleList({this.articles});

  factory ArticleList.fromJson(List<dynamic> json) {
    List<Article> articles = List<Article>();
    articles = json.map((i) => Article.fromJson(i)).toList();
    return new ArticleList(articles: articles);
  }
}
