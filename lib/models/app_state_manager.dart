
import 'dart:async';

import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;

  bool _loggedIn = true;

  bool darkMode = false;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;


  void initializeApp() {

    Timer(
      const Duration(milliseconds: 500),
          () {

        _initialized = true;

        notifyListeners();
      },
    );
  }
}