import 'package:flutter/material.dart';
import 'package:my_own_flashcards/di/providers.dart';
import 'package:my_own_flashcards/view/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "セルフ単語帳",
      home: HomeScreen(),
      theme: ThemeData(brightness: Brightness.dark, fontFamily: "lanobe"),
      debugShowCheckedModeBanner: false,
    );
  }
}
