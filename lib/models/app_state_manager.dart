
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mikesweb/utils/constants.dart';


class AppDrawerTabs {
  static const int home = 0;
  static const int inbox = 1;
  static const int explore = 2;
  static const int signUp = 3;
  static const int signIn = 4;
  static const int logOut = 5;
}

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;

  bool _loggedIn = false;
  bool _onboardingComplete = false;
  int _selectAppDrawerTab = AppDrawerTabs.home;

  bool darkMode = false;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectAppDrawerTab;

  void initializeApp() {

    Timer(
      const Duration(milliseconds: 500),
          () {

        _initialized = true;
        _selectAppDrawerTab = AppConstants.signIn;

        notifyListeners();
      },
    );
  }



  void goToSignUp(){
    _selectAppDrawerTab = AppConstants.signUp;
    _onboardingComplete = false;
    _loggedIn = false;
    notifyListeners();

  }
  void goToSignIn(){
    _selectAppDrawerTab = AppConstants.signIn;
    _onboardingComplete = false;
    _loggedIn = false;
    notifyListeners();

  }

  void logout(){
    _loggedIn = false;
    _initialized = false;
    _onboardingComplete = false;
    notifyListeners();
  }

  void goToHome(){
    _onboardingComplete = true;
    _loggedIn = true;
    notifyListeners();
  }

  void goToSelectedTab(int index){
            _selectAppDrawerTab = index;
            notifyListeners();
  }

}