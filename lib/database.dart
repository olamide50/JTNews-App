import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'news.dart';

Future<Database> getData() async {
  final Future<Database> database = openDatabase(
    // Set the path to the database.
    join(await getDatabasesPath(), 'news.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        "CREATE TABLE news(id INTEGER PRIMARY KEY, source TEXT, title TEXT, content TEXT, description TEXT, imageString TEXT, author TEXT, time TEXT, url TEXT)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  return database;
}

Future<void> insertNews(News news) async {
  // Get a reference to the database.
  final Database db = await getData();

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'news',
    news.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<News>> newsList() async {
  // Get a reference to the database.
  final Database db = await getData();

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('news');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return News(
      id: maps[i]['id'],
      source: maps[i]['source'],
      title: maps[i]['title'],
      content: maps[i]['content'],
      description: maps[i]['description'],
      imageString: maps[i]['imageString'],
      author: maps[i]['author'],
      time: maps[i]['time'],
      url: maps[i]['url'],
    );
  });
}

Future<void> deleteNews(int id) async {
  // Get a reference to the database.
  final db = await getData();

  // Remove the Dog from the Database.
  await db.delete(
    'news',
    // Use a `where` clause to delete a specific dog.
    where: "id = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}