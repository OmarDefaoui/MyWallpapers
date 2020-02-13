import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/utils/SetWallpaper.dart';

class ShowWallpaper extends StatefulWidget {
  final String imgPath;

  ShowWallpaper(this.imgPath);

  @override
  _ShowWallpaperState createState() => _ShowWallpaperState();
}

class _ShowWallpaperState extends State<ShowWallpaper> {
  String imgUrl;
  String home = "Home Screen", lock = "Lock Screen", both = "Both Screen";

  Stream<String> progressString;
  String res;
  bool downloading = false;
  var result = "Waiting to set wallpaper";

  @override
  void initState() {
    super.initState();
    imgUrl = widget.imgPath;
    print(imgUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Hero(
              tag: imgUrl,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  child: Image.asset('images/loading-1.gif'),
                  color: Color(0xFF21242D),
                  alignment: Alignment.center,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageUrl: imgUrl,
              ),
            ),
          ),
          Positioned.fill(
            bottom: 8,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Wrap(
                spacing: 10,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                    child: RaisedButton(
                      onPressed: () {
                        progressString =
                            SetWallpaper.imageDownloadProgress(imgUrl);
                        progressString.listen((data) {
                          setState(() {
                            res = data;
                            downloading = true;
                          });
                          print("DataReceived: " + data);
                        }, onDone: () async {
                          home = await SetWallpaper.homeScreen();
                          setState(() {
                            downloading = false;
                            home = home;
                          });
                          print("Task Done");
                        }, onError: (error) {
                          setState(() {
                            downloading = false;
                          });
                          print("Some Error");
                        });
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(home, style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                    child: RaisedButton(
                      onPressed: () {
                        progressString =
                            SetWallpaper.imageDownloadProgress(imgUrl);
                        progressString.listen((data) {
                          setState(() {
                            res = data;
                            downloading = true;
                          });
                          print("DataReceived: " + data);
                        }, onDone: () async {
                          lock = await SetWallpaper.lockScreen();
                          setState(() {
                            downloading = false;
                            lock = lock;
                          });
                          print("Task Done");
                        }, onError: (error) {
                          setState(() {
                            downloading = false;
                          });
                          print("Some Error");
                        });
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(lock, style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                    child: RaisedButton(
                      onPressed: () {
                        progressString =
                            SetWallpaper.imageDownloadProgress(imgUrl);
                        progressString.listen((data) {
                          setState(() {
                            res = data;
                            downloading = true;
                          });
                          print("DataReceived: " + data);
                        }, onDone: () async {
                          both = await SetWallpaper.bothScreen();
                          setState(() {
                            downloading = false;
                            both = both;
                          });
                          print("Task Done");
                        }, onError: (error) {
                          setState(() {
                            downloading = false;
                          });
                          print("Some Error");
                        });
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(both, style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 28,
            left: 8,
            child: FloatingActionButton(
              tooltip: 'Close',
              child: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              heroTag: 'close',
              mini: true,
              backgroundColor: Colors.black.withOpacity(0.5),
            ),
          ),
          _showProgressDialog()
        ],
      ),
    );
  }

  Widget _showProgressDialog() {
    return Positioned.fill(
      child: Center(
        child: downloading
            ? Container(
                height: 120.0,
                width: 200.0,
                child: Card(
                  color: Color(0xff323639),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(height: 20.0),
                      Text(
                        "Downloading File : $res",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            : Text(""),
      ),
    );
  }
}
