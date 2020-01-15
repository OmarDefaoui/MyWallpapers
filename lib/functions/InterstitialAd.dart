import 'package:firebase_admob/firebase_admob.dart';
import 'package:wallpapers/utils/ApiKey.dart';

InterstitialAd createInterstitialAd(int id) {
  return InterstitialAd(
    adUnitId: id == 1
        ? interstitialAdUnit1
        : id == 2 ? interstitialAdUnit2 : interstitialAdUnit3,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event $event in $id");
    },
  );
}
