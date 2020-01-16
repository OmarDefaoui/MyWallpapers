package com.nordef.wallpapers;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);


    ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
    com.nordef.wallpapers.WallpaperPlugin.registerWith(shimPluginRegistry.registrarFor("com.nordef.wallpapers.WallpaperPlugin"));
  }
}
