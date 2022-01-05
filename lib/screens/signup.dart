import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mikesweb/components/custom_textfield.dart';
import 'package:mikesweb/models/app_pages.dart';
import 'package:mikesweb/models/app_state_manager.dart';
import 'package:mikesweb/utils/constants.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.signUpPath,
        key: ValueKey(AppPages.signUpPath),
        child: const SignUp());
  }

  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;
  bool _toggleSigningUp = false;

  final _signUpMutation = """
    mutation AddUser(\$registerInput: RegisterInput) {
      register (registerInput: \$registerInput){
      email
      token
      username
      }
    
    }
     
  
  """;

  bool isValidForm(String one, String two, String three) {
    return (one.length > 6) && (two.length > 6) && (three.length > 10)
        ? true
        : false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstants.appMainThemeColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Center(
            child: SizedBox(
              width:
                  width <= AppConstants.portraitBreakpoint ? 280 : width / 2.5,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Create your account.",
                      style: GoogleFonts.quicksand(
                          textStyle:  TextStyle(fontSize: width <= AppConstants.portraitBreakpoint ? 25 : 32, color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        borderRadius: 20,
                        height: 60,
                        validator: (String? value) {
                          return value!.trim().length < 6
                              ? "Username must have at least 6 characters!"
                              : "";
                        },
                        keyboardType: TextInputType.text,
                        controller: _usernameController,
                        width: width,
                        hintText: "Username",
                        suffixIcon: const SizedBox()),
                    CustomTextField(
                        borderRadius: 20,
                        height: 60,
                        controller: _emailController,
                        width: width,
                        validator: isEmail,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email",
                        suffixIcon: const SizedBox()),
                    CustomTextField(
                        borderRadius: 20,
                        height: 60,
                        obscureText: _showPassword,
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        validator: (String? value) {
                          return value!.length < 10
                              ? "Password must have at least 10 characters!"
                              : "";
                        },
                        width: width,
                        hintText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: Icon(_showPassword
                                ? Icons.visibility_off
                                : Icons.visibility))),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: RichText(
                          text: TextSpan(
                              text:
                                  "By signing up, I have read and accepted the ",
                              style: GoogleFonts.quicksand(
                                  textStyle: const TextStyle(fontSize: 14, color: Colors.black)),
                              children: [
                            TextSpan(
                                style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(fontSize: 16, color: Colors.red,fontWeight: FontWeight.w700)),
                                text: "Terms of Service ",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //TODO: Move to Terms Of Service
                                  }),
                             TextSpan(
                              text: "and ",style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(fontSize: 14, color: Colors.black)),

                            ),
                            TextSpan(
                                style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(fontSize: 16, color: Colors.red,fontWeight: FontWeight.w700)),
                                text: " Privacy Policy.",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //TODO: Move to Privacy Policy
                                  }),
                          ])),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Mutation(
                      options: MutationOptions(
                        document: gql(_signUpMutation),
                        onError: (OperationException? err) {
                          setState(() {
                            _toggleSigningUp = false;
                          });
                          print(err);
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: const Text('Sign Up Unsuccessful'),
                                content:
                                    Text('${err!.graphqlErrors[0].message}.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onCompleted: (resultData) {
                          // print("Result Data: $resultData");

                          resultData != null
                              ? Timer(const Duration(seconds: 5), (){

                            AppConstants.pref.setBool(AppConstants.isLoggedIn, true);
                            AppConstants.pref.setString(AppConstants.isUsername, resultData['register']['username']);


                            Provider.of<AppStateManager>(context,
                                listen: false)
                                .goToHome(resultData['register']['username']);                          })
                              : null;
                        },
                      ),
                      builder: (
                        RunMutation runMutation,
                        QueryResult? result,
                      ) {
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            height: 50,
                            width: width / 1.5,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: _toggleSigningUp == false
                                        ? AppConstants.footerColor.withOpacity(0.5)
                                        : AppConstants.footerColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  // print(_formKey.currentState!.validate());
                                  setState(() {
                                    _toggleSigningUp = true;
                                  });
                                  runMutation({
                                    "registerInput": {
                                      'username':
                                          "@" + _usernameController.text.trim(),
                                      "password":
                                          _passwordController.text.trim(),
                                      "email": _emailController.text.trim()
                                    }
                                  });
                                  // print("Soure Data $res");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        _toggleSigningUp == false ? "Sign Up":
                                        "Signing Up... ",
                                        style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                    _toggleSigningUp == true ? Container(
                                      margin: const EdgeInsets.all(10),
                                      height: 15,
                                      width: 15,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ): const SizedBox()
                                  ],
                                )

                            ));
                      },
                    ),

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
                              text: "Already have an account? ",
                              style: GoogleFonts.quicksand(
                                  textStyle:  TextStyle(fontSize: width <= AppConstants.portraitBreakpoint ? 16 : 18, color: Colors.black)),
                              children: [
                            TextSpan(
                                style: GoogleFonts.quicksand(
                                    textStyle:  TextStyle(fontSize: width <= AppConstants.portraitBreakpoint ? 16 : 18, color: AppConstants.footerColor, fontWeight: FontWeight.bold)),                                text: " Sign In",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //TODO: Move to Sign In
                                    Provider.of<AppStateManager>(context,
                                            listen: false)
                                        .goToSignIn();
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

  String isEmail(String? em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em!) ? "" : "Invalid email";
  }
}
