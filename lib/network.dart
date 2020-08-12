import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> fetchNews(url) async {
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return 'retry';
    }
  } catch (e) {
    throw new HttpException(e);
  }
}
