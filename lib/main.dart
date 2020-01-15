import 'package:flutter/material.dart';
import 'package:wallpapers/screens/HomeScreen.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wallpapers",
      home: HomeScreen(),
    );
  }
}

