import 'dart:io';

import 'package:bubbly/utils/const.dart';

class AppRes {
  static const String appName = 'Scoutdelux';
  static const String halfMatch = '5m';
  static const String fullMatch = '15m';
  static const String imageMessage = '🖼️ Image';
  static const String videoMessage = '🎥 Video';
  static const String hashTag = '#';
  static const String atSign = '@';
  static const String look = 'Look';
  static const String textTotalCount = '175';
  static const String hintX = 'XX-XXXX-XXXXXXXX';

  static String redeemTitle(String value) {
    return '1000 shortzz = $value USD';
  }

  static String whatReport(int value) {
    return 'Report ${value == 1 ? 'Post' : 'User'}';
  }

  static String checkOutThisAmazingProfile(dynamic result) {
    return 'Check out this amazing profile $result 😋😋';
  }

  static String minimumCoinRequired =
      'Minimum ${SettingRes.minFansForLive ?? '0'} fans required to start livestream!';
  static const String privacyPolicy =
      'By continuing, you agree to  Scoutdelux\'s terms of use\nand confirm that you have read our privacy policy.';
  static String selectedLanguage = Platform.localeName.split('_')[0];
}
