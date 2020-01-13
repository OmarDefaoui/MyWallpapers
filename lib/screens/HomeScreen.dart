import 'package:flutter/material.dart';
import 'DisplayWallpapers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  static var _tabPages = <Widget>[
    DisplayWallpapers(
        "https://pixabay.com/api/?key=11308358-67ad92507710cb90567e4924c&q=sports+car&image_type=photo&pretty=true"),
    DisplayWallpapers(
        "https://pixabay.com/api/?key=11308358-67ad92507710cb90567e4924c&q=nature&image_type=photo&pretty=true"),
    DisplayWallpapers(
        "https://pixabay.com/api/?key=11308358-67ad92507710cb90567e4924c&q=mountains&image_type=photo&pretty=true"),
    DisplayWallpapers(
        "https://pixabay.com/api/?key=11308358-67ad92507710cb90567e4924c&q=person&image_type=photo&pretty=true")
  ];
  static var _tabs = <Tab>[
    Tab(
      text: "Cars",
    ),
    Tab(
      text: "Nature",
    ),
    Tab(
      text: "Mountains",
    ),
    Tab(
      text: "Person",
    )
  ];
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabPages.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WALLPAPERS",
          style: TextStyle(
            color: Colors.yellowAccent,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: TabBarView(
        children: _tabPages,
        controller: _tabController,
      ),
      bottomNavigationBar: Material(
        color: Colors.black,
        child: TabBar(
          tabs: _tabs,
          controller: _tabController,
          labelColor: Colors.lightGreenAccent,
          indicatorColor: Colors.yellowAccent,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
