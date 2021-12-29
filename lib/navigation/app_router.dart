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
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if ((appStateManager.isLoggedIn == false) &&
            (appStateManager.isInitialized == true))
          SignIn.page(),
        if (appStateManager.getSelectedTab == AppDrawerTabs.signUp)
          SignUp.page(),
        if ((appStateManager.isInitialized == true) &&
            appStateManager.isOnboardingComplete == true)
          Home.page()
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
    if (appStateManager.isInitialized &&
        appStateManager.getSelectedTab == AppConstants.signIn) {
      return AppLink(location: AppLink.kSignInPath);
    }
    else if ((appStateManager.isInitialized == true) &&
        appStateManager.isOnboardingComplete == true)
    {
      return AppLink(location: AppLink.kHomePath);
    }
    else if (appStateManager.isInitialized &&
        appStateManager.getSelectedTab == AppConstants.signUp) {
      return AppLink(location: AppLink.kSignUpPath);
    } else {
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
            appStateManager.goToSignUp();
        break;
      case AppLink.kSignInPath:
            appStateManager.goToSignIn();
        break;
      case AppLink.kSplashPath:
            appStateManager.initializeApp();
        break;
      default:
        break;
    }
  }
}
