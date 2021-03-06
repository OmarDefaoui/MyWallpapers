import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';

class SetWallpaper {
  static const MethodChannel _channel = const MethodChannel('wallpaper');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> homeScreen() async {
    final String resultvar =
    await _channel.invokeMethod('HomeScreen', 'myimage.jpeg');
    return resultvar;
  }

  static Future<String> lockScreen() async {
    final String resultvar =
    await _channel.invokeMethod('LockScreen', 'myimage.jpeg');
    return resultvar;
  }

  static Future<String> bothScreen() async {
    final String resultvar =
    await _channel.invokeMethod('Both', 'myimage.jpeg');
    return resultvar;
  }

  static Stream<String> imageDownloadProgress(String url) async* {
    StreamController<String> streamController = new StreamController();
    try {
      final dir = await getExternalStorageDirectory();
      print(dir);
      Dio dio = new Dio();
      dio
          .download(
        url,
        "${dir.path}/myimage.jpeg",
        onReceiveProgress: (int received, int total) {
          streamController
              .add(((received / total) * 100).toStringAsFixed(0) + "%");
        },
      )
          .then((Response response) {})
          .catchError((ex) {
        streamController.add(ex.toString());
      })
          .whenComplete(() {
        streamController.close();
      });
      yield* streamController.stream;
    } catch (ex) {
      throw ex;
    }
  }

  static cropImage(File imageFile) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    return croppedImage;
  }
}
