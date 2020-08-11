import 'package:http/http.dart' as http;

Future<String> fetchNews(url) async {
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
}
