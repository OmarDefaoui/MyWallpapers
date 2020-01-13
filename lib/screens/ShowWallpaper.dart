import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowWallpaper extends StatefulWidget {
  String imgPath;
  ShowWallpaper(this.imgPath);

  @override
  _ShowWallpaperState createState() => _ShowWallpaperState();
}

class _ShowWallpaperState extends State<ShowWallpaper> {

final LinearGradient backgroundGradient = new LinearGradient(
      colors: [Colors.red,Colors.white,Colors.blue],
      begin: Alignment.bottomRight,
      end: Alignment.topLeft);

 @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SizedBox.expand(
        child: new Container(
          decoration: new BoxDecoration(gradient: backgroundGradient),
          child: new Stack(
            children: <Widget>[
              new Align(
                alignment: Alignment.center,
                child: new Hero(
                  tag: widget.imgPath,
                  child: Image(image: CachedNetworkImageProvider(widget.imgPath)),
                ),
              ),
              new Align(
                alignment: Alignment.topCenter,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      leading: new IconButton(
                        icon: new Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
