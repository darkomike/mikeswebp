import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mikesweb/components/custom_textfield.dart';
import 'package:mikesweb/models/app_pages.dart';
import 'package:mikesweb/models/app_state_manager.dart';
import 'package:provider/provider.dart';

class Page404 extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.notFoundPath,
        key: ValueKey(AppPages.notFoundPath),
        child: const Page404());
  }

  const Page404({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<Page404> {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.teal,
          onPressed: () {
            //TODO: Move to Home - Sign In

          },
          icon: const Icon(Icons.home),
          label: Text(
            "Home",
            style: GoogleFonts.quicksand(
                textStyle: const TextStyle(color: Colors.white)),
          )),
      body: SafeArea(
          child: Container(
            height: height,
            child: Center(
              child: Container(
                width: 280,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Page 404!",
                        style: Theme.of(context).textTheme.headline1,
                      ),


                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: RichText(
                            text: TextSpan(
                                text:
                                "Page Not Found! Return to ",
                                children: [
                                  TextSpan(
                                      style: GoogleFonts.quicksand(textStyle: const TextStyle(
                                          color: Colors.red, fontWeight: FontWeight.w700),),
                                      text: "Homepage",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          //TODO: Move to Home - Page 404...
                                          Provider.of<AppStateManager>(context,
                                              listen: false)
                                              .goToHome();
                                        }),


                                ])),
                      ),




                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
