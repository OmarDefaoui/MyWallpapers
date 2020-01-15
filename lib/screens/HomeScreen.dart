import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/functions/ShowAction.dart';
import 'package:wallpapers/models/PopUpMenuItems.dart';
import 'package:wallpapers/screens/CategoriesScreen.dart';
import 'package:wallpapers/screens/SearchScreen.dart';
import 'package:wallpapers/utils/ApiKey.dart';
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
    DisplayWallpapers("https://pixabay.com/api/?key=$apiKey" +
        "&image_type=photo&orientation=vertical&safesearch=true&order=latest&page="),
    DisplayWallpapers("https://pixabay.com/api/?key=$apiKey" +
        "&orientation=vertical&safesearch=true&editors_choice=true&page="),
    DisplayWallpapers("https://pixabay.com/api/?key=$apiKey&safesearch=true&page=")
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
                _showActionBarTitle(),
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

  String _showActionBarTitle() {
    try {
      if (_pageController.page == 0.0)
        return "CATEGORIES";
      else
        return "WALLPAPERS";
    } catch (error) {
      return "CATEGORIES";
    }
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

  @override
  bool get wantKeepAlive => true;
}
