import 'dart:convert';

class DecodeSearch {
  DecodeSearch();

  getData(
    String data,
    List<String> source,
    List<String> title,
    List<String> content,
    List<String> description,
    List<String> imageString,
    List<String> author,
    List<String> time,
    List<String> url,
    int number,
    String empty,
  ) {
    source.clear();
    title.clear();
    content.clear();
    description.clear();
    imageString.clear();
    author.clear();
    time.clear();
    url.clear();
    var decoder = jsonDecode(data);
    int numb = decoder['totalResults'];
    if (number > numb) {
      number = numb;
    }    if (number != 0) {
      for (int i = 0; i < number; i++) {
        String sourceData = decoder['articles'][i]['source']['name'];
        if (sourceData != null) {
          source.add(sourceData);
        } else {
          source.add(empty);
        }

        String titleData = decoder['articles'][i]['title'];
        if (titleData != null) {
          title.add(titleData);
        } else {
          title.add(empty);
        }

        String contentData = decoder['articles'][i]['content'];
        if (contentData != null) {
          content.add(contentData);
        } else {
          content.add(empty);
        }

        String descriptionData = decoder['articles'][i]['description'];
        if (descriptionData != null) {
          description.add(descriptionData);
        } else {
          description.add(empty);
        }

        String imageStringData = decoder['articles'][i]['urlToImage'];
        if (imageStringData != null) {
          imageString.add(imageStringData);
        } else {
          imageString.add(empty);
        }

        String authorData = decoder['articles'][i]['author'];
        if (authorData != null) {
          author.add(authorData);
        } else {
          author.add(empty);
        }

        String timeData = decoder['articles'][i]['publishedAt'];
        if (timeData != null) {
          time.add(timeData);
        } else {
          time.add(empty);
        }

        String urlData = decoder['articles'][i]['url'];
        if (urlData != null) {
          url.add(urlData);
        } else {
          url.add(empty);
        }

        
      }
      return [
          source,
          title,
          content,
          description,
          imageString,
          author,
          time,
          url,
          number
        ];
    } else {
      return null;
    }
  }
}
