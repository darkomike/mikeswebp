
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mikesweb/utils/constants.dart';




class AppStateManager extends ChangeNotifier {



  final bool _initialized = AppConstants.pref.getBool(AppConstants.isInitialized) ?? false;
  bool _loggedIn = AppConstants.pref.getBool(AppConstants.isLoggedIn) ?? false;
  String  _username = AppConstants.pref.getString(AppConstants.isUsername) ?? "";
  int _selectAppDrawerTab = AppConstants.pref.getInt(AppConstants.currentTab) ?? AppConstants.homeTab;



  bool darkMode = false;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  String get isUsername => _username;
  int get getSelectedTab => _selectAppDrawerTab;





  void goToSignUp(){
    AppConstants.pref.setInt(AppConstants.currentTab, AppConstants.signUpTab);
    _selectAppDrawerTab =  AppConstants.pref.getInt(AppConstants.currentTab)!;
    notifyListeners();

  }
  void goToSignIn(){
    AppConstants.pref.setInt(AppConstants.currentTab, AppConstants.signInTab);
    _selectAppDrawerTab =  AppConstants.pref.getInt(AppConstants.currentTab)!;

    notifyListeners();

  }

  void logout(){
    AppConstants.pref.setInt(AppConstants.currentTab, AppConstants.homeTab);
    AppConstants.pref.setBool(AppConstants.isLoggedIn, false);
    AppConstants.pref.setString(AppConstants.isUsername, '');


   _loggedIn =   AppConstants.pref.getBool(AppConstants.isLoggedIn)!;

    _selectAppDrawerTab =     AppConstants.pref.getInt(AppConstants.currentTab)!;

    notifyListeners();
  }

  void goToHome(
      [String? username]
      ){


    AppConstants.pref.setInt(AppConstants.currentTab, AppConstants.homeTab);
    AppConstants.pref.setString(AppConstants.isUsername, username!);
    _username = username;
    _loggedIn =   AppConstants.pref.getBool(AppConstants.isLoggedIn)!;
    _selectAppDrawerTab =     AppConstants.pref.getInt(AppConstants.currentTab)!;


    notifyListeners();
  }



}