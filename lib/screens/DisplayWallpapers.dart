import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpapers/screens/ShowWallpaper.dart';

class DisplayWallpapers extends StatefulWidget {
  final String url;
  DisplayWallpapers(this.url);

  @override
  _DisplayWallpapersState createState() => _DisplayWallpapersState();
}

class _DisplayWallpapersState extends State<DisplayWallpapers>
    with AutomaticKeepAliveClientMixin {
  int _currentPage = 0, _totalItems = 0;
  bool isDataLoaded = false, _isLoadingMore = false, _isError = false;
  List data = List();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print('called again');
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) &&
          !_isLoadingMore &&
          _totalItems != data.length) {
        _isLoadingMore = true;
        getJsonData();
      }
    });
    getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError)
      //return error form with retry button
      return Container(
        color: Colors.black,
        child: Center(
          child: Text(
            'Error',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
            ),
          ),
        ),
      );

    if (isDataLoaded)
      return Container(
        color: Colors.black,
        child: StaggeredGridView.countBuilder(
          controller: _scrollController,
          addAutomaticKeepAlives: true,
          padding: EdgeInsets.all(4.0),
          crossAxisCount: 4,
          itemCount: data.length + 1,
          itemBuilder: (context, i) {
            if (i == data.length) {
              if (_totalItems == i) return SizedBox.shrink();
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            String imgPath = data[i]['largeImageURL'];
            return Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                child: Hero(
                  tag: imgPath,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      child: Image.asset('images/loading-1.gif'),
                      color: Color(0xFF21242D),
                      alignment: Alignment.center,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageUrl: imgPath,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShowWallpaper(imgPath)));
                },
              ),
            );
          },
          staggeredTileBuilder: (i) => StaggeredTile.count(2, i.isEven ? 2 : 3),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      );
    else
      //show progress bar while loading data
      return Container(
        child: Center(
            child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.yellowAccent))),
        color: Colors.black,
      );
  }

  Future<String> getJsonData() async {
    print('fetch data call');
    _currentPage += 1;
    var response = await http.get(
      Uri.encodeFull(widget.url + _currentPage.toString()),
    );

    var convertDataToJson;
    try {
      convertDataToJson = json.decode(response.body);
    } catch (error) {
      setState(() {
        _isError = true;
      });
      return "error";
    } finally {
      _totalItems = convertDataToJson['totalHits'];
      setState(() {
        data.addAll(convertDataToJson['hits']);
        isDataLoaded = true;
        _isLoadingMore = false;
      });
    }

    return "Success";
  }

  @override
  bool get wantKeepAlive => true;
}
