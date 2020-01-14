import 'package:flutter/material.dart';

import 'DisplayWallpapers.dart';

class SearchScreen extends StatefulWidget {
  final String keyword;
  SearchScreen({this.keyword});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query, url;

  @override
  void initState() {
    super.initState();
    _setupUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.keyword,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: DisplayWallpapers(url),
    );
  }

  _setupUrl() {
    query = widget.keyword.replaceAll(' ', '+');

    url = "https://pixabay.com/api/?key=11308358-67ad92507710cb90567e4924c" +
        "&image_type=photo&safesearch=true&orientation=vertical&q=$query&page=";
    print(url);
  }
}
