import 'package:flutter/material.dart';
import 'package:mikesweb/models/app_pages.dart';
import 'package:mikesweb/models/app_state_manager.dart';
import 'package:mikesweb/navigation/app_link.dart';
import 'package:mikesweb/screens/home_screen.dart';
import 'package:mikesweb/screens/splash_screen.dart';

class AppRouter extends RouterDelegate<AppLink> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
   final GlobalKey<NavigatorState> navigatorKey;

   final AppStateManager appStateManager;

  AppRouter({
    required this.appStateManager
}) : navigatorKey = GlobalKey<NavigatorState>(){
    appStateManager.addListener(notifyListeners);
  }


  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (appStateManager.isInitialized == false) SplashScreen.page(),

        if ((appStateManager.isInitialized == true) && appStateManager.isLoggedIn) Home.page(),
      ],
    );
  }


  bool _handlePopPage(Route<dynamic> route, result){
    if (!route.didPop(result)){
      return false;
    }

    if (route.settings.name == AppPages.homePath){
      print(route.settings.name);
    }

    print(route.settings.name);


    return true;


  }

  AppLink getCurrentPath(){
    if (appStateManager.isInitialized == false) {
      return AppLink(location: AppLink.kSplashPath);
    }
    else if (appStateManager.isInitialized == true) {
      return AppLink(location: AppLink.kHomePath);
    }
    else {
      return AppLink(location: AppLink.kSplashPath);

    }


  }

  @override
  AppLink get currentConfiguration => getCurrentPath();

  @override
  Future<void> setNewRoutePath(AppLink newLink) async{
    switch(newLink.location){
      case AppLink.kHomePath:
        break;
      default:
        break;
    }
  }
}
