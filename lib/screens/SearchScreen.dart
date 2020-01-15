import 'package:flutter/material.dart';
import 'package:wallpapers/utils/ApiKey.dart';

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

    url = "https://pixabay.com/api/?key=$apiKey" +
        "&image_type=photo&safesearch=true&orientation=vertical&q=$query&page=";
    print(url);
  }
}
