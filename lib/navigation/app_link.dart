import 'package:flutter/widgets.dart';
import 'package:mikesweb/utils/constants.dart';

class AppLink {
  static const String kHomePath = AppConstants.homePath;
  static const String kSplashPath = AppConstants.splashPath;
  static const String kSignInPath = AppConstants.signInPath;
  static const String kSignUpPath = AppConstants.signUpPath;

  static const String kTabParam = "tab";
  static const String kIdParam = "id";

  String? location;
  String? itemId;
  int? currentTab;

  AppLink({this.itemId, this.location, this.currentTab});

  static AppLink fromLocation(String? location) {
    location = Uri.decodeFull(location ?? '');

    final uri = Uri.parse(location);
    final params = uri.queryParameters;

    final currentTab = int.tryParse(params[AppLink.kTabParam] ?? "");
    final itemId = params[AppLink.kTabParam];

    final link =
        AppLink(location: uri.path, currentTab: currentTab, itemId: itemId);

    return link;
  }

  String toLocation() {
    String addKeyValPair({required String key, String? value}) =>
        value == null ? '' : '$key=$value&';

    switch (location) {
      case kHomePath:
        return kHomePath;
      case kSignInPath:
        return kSignInPath;
      case kSignUpPath:
        return kSignUpPath;
      case kSplashPath:
        return kSplashPath;
      default:
        var loc = '$kHomePath?';
        loc += addKeyValPair(key: kIdParam, value: itemId);
        return Uri.encodeFull(loc);
    }
  }
}
