import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_demo/services/api_service.dart';
import 'package:rest_api_demo/views/note_list_page.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => ApiService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesListPage(),
    );
  }
}
