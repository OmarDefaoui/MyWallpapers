import 'package:flutter/material.dart';
import 'package:wallpapers/functions/ShowAction.dart';
import 'package:wallpapers/models/PopUpMenuItems.dart';
import 'package:wallpapers/screens/DisplayWallpapers.dart';

import 'SearchScreen.dart';

class CategoryContentScreen extends StatefulWidget {
  final String url, title;
  CategoryContentScreen({this.title, this.url});

  @override
  _CategoryContentScreenState createState() => _CategoryContentScreenState();
}

class _CategoryContentScreenState extends State<CategoryContentScreen> {
  bool _isSearching = false;
  TextEditingController _searchController;
  String _searchInput;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  border: InputBorder.none,
                  hintText: 'Search wallpaper...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        if (_searchInput.trim().isNotEmpty)
                          _searchWallpapers(_searchInput.trim());
                        else
                          _clearSearch();
                      }),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: _clearSearch,
                  ),
                  filled: true,
                ),
                onSubmitted: (input) {
                  if (input.trim().isNotEmpty)
                    _searchWallpapers(input.trim());
                  else
                    _clearSearch();
                },
                onChanged: (input) {
                  _searchInput = input;
                },
              )
            : Text(
                '${widget.title[0].toUpperCase()}${widget.title.substring(1)}',
                style: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
          ),
          PopupMenuButton<PopUpMenuItems>(
            onSelected: (item) {
              showAction(item.title);
            },
            itemBuilder: (BuildContext context) {
              return popUpMenuItems.map((PopUpMenuItems item) {
                return PopupMenuItem<PopUpMenuItems>(
                  value: item,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        item.icon,
                        color: Colors.lightBlue,
                      ),
                      SizedBox(width: 10),
                      Text(item.title),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: DisplayWallpapers(widget.url),
    );
  }

  _searchWallpapers(String keyword) {
    print('search wallpapers');
    _clearSearch();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SearchScreen(
          keyword: keyword,
        ),
      ),
    );
  }

  void _clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _isSearching = false;
    });
  }
}
