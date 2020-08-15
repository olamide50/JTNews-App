import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/article.dart';
import 'screens/settings.dart';
import 'screens/newSearch.dart';
import 'screens/retrySearch.dart';
import 'screens/load.dart';
import 'package:JTNews/screens/bookmarks.dart';
import 'package:preferences/preferences.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:JTNews/screens/loadError.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefService.init(prefix: 'pref_');

  PrefService.setDefaultValues({
    'dev': 'JTAppSoft International 2020 \u00a9',
    'email': 'Email: lekansbox1@gmail.com',
    'phone': 'Phone: +234-7050430600',
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
              primarySwatch: Colors.indigo,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: theme,
              initialRoute: Load.id,
              routes: {
                Home.id: (context) => Home(),
                ArticleView.id: (context) => ArticleView(),
                Settings.id: (context) => Settings(),
                NewSearch.id: (context) => NewSearch(),
                RetrySearch.id: (context) => RetrySearch(),
                Load.id: (context) => Load(),
                Bookmarks.id: (context) => Bookmarks(),
                LoadError.id: (context) => LoadError(),
              });
        });
  }
}
