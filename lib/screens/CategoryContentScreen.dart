import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
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
    _searchController.dispose();
    super.dispose();
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
                  hintText: 'Search...',
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
              _showAction(item.title);
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

  _showAction(String title) async {
    print(title);
    switch (title) {
      case 'More apps':
        if (Platform.isAndroid) {
          AndroidIntent intent = AndroidIntent(
            action: 'action_view',
            data:
                'https://play.google.com/store/apps/dev?id=5265766386525301972',
          );
          await intent.launch();
        }
        break;
      case 'Share':
        if (Platform.isAndroid) {
          AndroidIntent intent = AndroidIntent(
            action: 'action_view',
            data:
                'https://play.google.com/store/apps/details?id=com.nordef.notes',
          );
          await intent.launch();
        }
        break;
      case 'Rate':
        if (Platform.isAndroid) {
          AndroidIntent intent = AndroidIntent(
            action: 'action_view',
            data:
                'https://play.google.com/store/apps/details?id=com.nordef.notes',
          );
          await intent.launch();
        }
        break;
      case 'Privacy policy':
        if (Platform.isAndroid) {
          AndroidIntent intent = AndroidIntent(
            action: 'action_view',
            data: 'https://www.google.com',
          );
          await intent.launch();
        }
        break;
    }
  }
}
