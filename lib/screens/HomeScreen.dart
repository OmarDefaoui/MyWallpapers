import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/models/PopUpMenuItems.dart';
import 'package:wallpapers/screens/CategoriesScreen.dart';
import 'package:wallpapers/screens/SearchScreen.dart';
import 'DisplayWallpapers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  PageController _pageController;
  static var _tabPages = <Widget>[
    CategoriesScreen(),
    DisplayWallpapers(
        "https://pixabay.com/api/?key=11308358-67ad92507710cb90567e4924c" +
            "&image_type=photo&orientation=vertical&safesearch=true&order=latest"),
    DisplayWallpapers(
        "https://pixabay.com/api/?key=11308358-67ad92507710cb90567e4924c" +
            "&orientation=vertical&safesearch=true&editors_choice=true"),
    DisplayWallpapers(
        "https://pixabay.com/api/?key=11308358-67ad92507710cb90567e4924c&safesearch=true")
  ];
  static var _tabs = <TabData>[
    TabData(
      iconData: Icons.category,
      title: "Categories",
    ),
    TabData(
      iconData: Icons.new_releases,
      title: "Latest",
    ),
    TabData(
      iconData: Icons.trending_up,
      title: "Trending",
    ),
    TabData(
      iconData: Icons.all_inclusive,
      title: "All",
    )
  ];
  int _currentTab = 0;
  bool _isSearching = false;
  TextEditingController _searchController;
  String _searchInput;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
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
                "WALLPAPERS",
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
      body: PageView(
        physics: new NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentTab = index;
          });
        },
        controller: _pageController,
        children: _tabPages,
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: _currentTab,
        tabs: _tabs,
        onTabChangedListener: (position) {
          setState(() {
            _currentTab = position;
          });
          _pageController.animateToPage(
            position,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
      ),
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

  @override
  bool get wantKeepAlive => true;
}
