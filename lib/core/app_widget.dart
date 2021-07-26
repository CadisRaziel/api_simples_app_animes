import 'package:anime_flix/page/anime.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api anime',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Animes(),
     debugShowCheckedModeBanner: false,
    );
  }
}