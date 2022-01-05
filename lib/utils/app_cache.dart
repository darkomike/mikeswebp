import 'package:mikesweb/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AppCache {


  static saveUserLoggedIn([bool? value]) async {
     AppConstants.pref = await SharedPreferences.getInstance();
     AppConstants.pref.setBool(AppConstants.isLoggedIn, value ?? false);
  }

  static saveCurrentTab([bool? value]) async {
    AppConstants.pref = await SharedPreferences.getInstance();
    AppConstants.pref.setBool(AppConstants.isLoggedIn, value ?? false);
  }





}
