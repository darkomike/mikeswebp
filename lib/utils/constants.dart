
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {

  static late SharedPreferences pref;

  static Color footerColor =  const  Color(0xff22179c);
  static Color appMainThemeColor =  const  Color(0xff7fc19c);
  static double  portraitBreakpoint =   900.0;
  static double  drawerWidth =   200.0;
  static const int homeTab = 0;
  static const int inboxTab = 1;
  static const int exploreTab = 2;
  static const int signUpTab = 3;
  static const int signInTab = 4;
  static const int logOutTab = 5;

  static const String homePath = "/";
  static const String splashPath = "/splash";
  static const String signInPath = "/signin";
  static const String signUpPath = "/signup";
  static const String notFoundPath = "*";

  static const  serverUrl = "https://project-x.up.railway.app/";

  static const  isLoggedIn = "IS_LOGGED_IN";
  static const  currentTab = "CURRENT_TAB";
  static const  isInitialized = "IS_INITIALIZED";
  static const  isUsername = "IS_USERNAME";




}