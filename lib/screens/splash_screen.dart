import 'package:flutter/material.dart';
import 'package:mikesweb/models/app_pages.dart';
import 'package:mikesweb/models/app_state_manager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {

  static MaterialPage page(){
    return MaterialPage(
        name: AppPages.splashPath,
        key: ValueKey(AppPages.splashPath),
        child: const SplashScreen());
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("SplashScreen"),
      ),
    );
  }
}
