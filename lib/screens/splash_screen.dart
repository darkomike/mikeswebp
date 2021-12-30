import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mikesweb/models/app_pages.dart';
import 'package:mikesweb/models/app_state_manager.dart';
import 'package:mikesweb/utils/constants.dart';
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
    return  Scaffold(
      backgroundColor: AppConstants.appMainThemeColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("MikesWeb", style: GoogleFonts.parisienne(textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),),
            const SizedBox(height: 10,),
            Text("Welcome!", style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),),
          ],
        ),
      ),
    );
  }
}
