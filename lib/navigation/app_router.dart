import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mikesweb/models/app_pages.dart';
import 'package:mikesweb/models/app_state_manager.dart';
import 'package:mikesweb/navigation/app_link.dart';
import 'package:mikesweb/screens/home_screen.dart';
import 'package:mikesweb/screens/login.dart';
import 'package:mikesweb/screens/signup.dart';
import 'package:mikesweb/screens/splash_screen.dart';
import 'package:mikesweb/utils/constants.dart';

class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;

  AppRouter({required this.appStateManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [

        // if(Platform.isAndroid && appStateManager.isInitialized ) SplashScreen.page(),
        if (appStateManager.getSelectedTab == AppConstants.signUpTab) SignUp.page(),
        if (appStateManager.getSelectedTab == AppConstants.signInTab) SignIn.page(),
        if (appStateManager.getSelectedTab == AppConstants.homeTab) Home.page(username: AppConstants.pref.getString(AppConstants.isUsername)),
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      print(route.settings.name);
      return false;
    }

    if (route.settings.name == AppPages.homePath) {
      print(route.settings.name);
    }

    if (route.settings.name == AppPages.signUpPath) {

      print(route.settings.name);
    }
    if (route.settings.name == AppPages.signinPath) {
      print(route.settings.name);
    }

    print(route.settings.name);

    return true;
  }

  AppLink getCurrentPath() {
    if (
        appStateManager.getSelectedTab == AppConstants.signInTab) {
      return AppLink(location: AppLink.kSignInPath);
    }

    else if (appStateManager.getSelectedTab == AppConstants.signUpTab) {
      return AppLink(location: AppLink.kSignUpPath);
    }
    else if (appStateManager.getSelectedTab == AppConstants.homeTab ) {
      return AppLink(location: AppLink.kHomePath);
    }
    else {

      return AppLink(location: AppLink.kHomePath);
    }

  }

  @override
  AppLink get currentConfiguration => getCurrentPath();

  @override
  Future<void> setNewRoutePath(AppLink newLink) async {
    switch (newLink.location) {
      case AppLink.kHomePath:
            appStateManager.goToHome();
        break;
      case AppLink.kSignUpPath:
            AppConstants.pref.getBool(AppConstants.isLoggedIn) == true ?  appStateManager.goToHome() : appStateManager.goToSignUp();
        break;
      case AppLink.kSignInPath:
        AppConstants.pref.getBool(AppConstants.isLoggedIn) == true ?  appStateManager.goToHome() : appStateManager.goToSignIn();
        break;
      default:

        break;
    }
  }
}
