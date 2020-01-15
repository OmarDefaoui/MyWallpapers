import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:share/share.dart';
import 'package:wallpapers/utils/Constants.dart';

showAction(String title) async {
    switch (title) {
      case 'More apps':
        if (Platform.isAndroid) {
          AndroidIntent intent = AndroidIntent(
            action: 'action_view',
            data: myPlayStoreLink,
          );
          await intent.launch();
        }
        break;
      case 'Share':
        Share.share(
          'Check out this awesome wallpapers app:\n$appPlayStoreLink',
          subject: 'Wallpapers app suggestion',
        );
        break;
      case 'Rate':
        if (Platform.isAndroid) {
          AndroidIntent intent = AndroidIntent(
            action: 'action_view',
            data: appPlayStoreLink,
          );
          await intent.launch();
        }
        break;
      case 'Privacy policy':
        if (Platform.isAndroid) {
          AndroidIntent intent = AndroidIntent(
            action: 'action_view',
            data: appPrivacyPolicyLink,
          );
          await intent.launch();
        }
        break;
    }
  }
