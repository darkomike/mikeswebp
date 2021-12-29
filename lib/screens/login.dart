import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mikesweb/components/custom_textfield.dart';
import 'package:mikesweb/models/app_pages.dart';
import 'package:mikesweb/models/app_state_manager.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.signinPath,
        key: ValueKey(AppPages.signinPath),
        child: const SignIn());
  }

  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormFieldState>();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: height,
        child: Center(
          child: Container(
            width: 280,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome back!",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    CustomTextField(
                        controller: _usernameController,
                        width: width,
                        hintText: "Username",
                        suffixIcon: const SizedBox()),
                    CustomTextField(
                        obscureText: _showPassword,
                        controller: _passwordController,
                        width: width,
                        hintText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: const Icon(Icons.star))),
                    Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(
                                    color: Colors.blue, fontSize: 16)),
                          ),
                        )),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: 50,
                        width: width / 2.5,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {},
                            child: Text("Sign In",
                                style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                        color: Colors.white, fontSize: 18))))),
                    // Container(
                    //     margin: const EdgeInsets.symmetric(vertical: 10),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10)),
                    //     height: 50,
                    //     width: width / 2.5,
                    //     child: ElevatedButton.icon(
                    //         style: ElevatedButton.styleFrom(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10))),
                    //         onPressed: () {},
                    //         icon: const Icon(Icons.ten_k),
                    //         label: Text("SIGN IN GOOGLE",
                    //             style: GoogleFonts.quicksand(
                    //                 textStyle: const TextStyle(
                    //                     color: Colors.white, fontSize: 18))))),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: RichText(
                          text: TextSpan(
                              text: "Don't have an account? ",
                              children: [
                            TextSpan(
                                style: const TextStyle(color: Colors.blue),
                                text: "Sign Up",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //TODO: Move to Sign Up
                                    Provider.of<AppStateManager>(context, listen: false)
                                        .goToSignUp();
                                  })
                          ])),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
