import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mikesweb/components/custom_textfield.dart';
import 'package:mikesweb/models/app_pages.dart';
import 'package:mikesweb/models/app_state_manager.dart';
import 'package:mikesweb/utils/constants.dart';
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
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;
  bool _toggleSigningIn = false;

  final _signInMutation = """
    mutation LoginUser(\$loginInput: LoginInput) {
      login (loginInput: \$loginInput){
      email
      token
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

      // floatingActionButton: FloatingActionButton.extended(
      //     backgroundColor: Colors.teal,
      //     onPressed: () {
      //       //TODO: Move to Home - Sign Up
      //       Provider.of<AppStateManager>(context, listen: false).goToHome();
      //     },
      //     icon: const Icon(Icons.home),
      //     label: Text(
      //       "Home",
      //       style: GoogleFonts.quicksand(
      //           textStyle: const TextStyle(color: Colors.white)),
      //     )),
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
                      "Welcome back!",
                      style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              fontSize: width <= AppConstants.portraitBreakpoint
                                  ? 25
                                  : 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
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
                                  "By signing in, I have read and accepted the ",
                              style: GoogleFonts.quicksand(
                                  textStyle: const TextStyle(
                                      fontSize: 14, color: Colors.black)),
                              children: [
                            TextSpan(
                                style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700)),
                                text: "Terms of Service ",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //TODO: Move to Terms Of Service
                                  }),
                            TextSpan(
                              text: "and ",
                              style: GoogleFonts.quicksand(
                                  textStyle: const TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ),
                            TextSpan(
                                style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700)),
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
                        document: gql(_signInMutation),
                        onError: (OperationException? err) {
                          setState(() {
                            _toggleSigningIn = false;
                          });
                          print(err);
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: const Text('Sign In Unsuccessful'),
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
                          print("Result Data: $resultData");

                          resultData != null
                              ? Timer(const Duration(seconds: 8), () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return SizedBox(
                                        height: 150,
                                        child: Dialog(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            height: 100,
                                            child: Column(
                                              children: const [
                                                CircularProgressIndicator(),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Loading...")
                                              ],
                                            ),
                                          ),
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                        ),
                                      );
                                    },
                                  );
                                  Provider.of<AppStateManager>(context,
                                          listen: false)
                                      .goToHome();
                                })
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
                                    primary: _toggleSigningIn == false
                                        ? AppConstants.footerColor
                                            .withOpacity(0.5)
                                        : AppConstants.footerColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  print(_formKey.currentState!.validate());
                                  setState(() {
                                    _toggleSigningIn = true;
                                  });
                                  var res = runMutation({
                                    "loginInput": {
                                      'username':
                                          "@" + _usernameController.text.trim(),
                                      "password":
                                          _passwordController.text.trim()
                                    }
                                  }).eagerResult;
                                  print("Soure Data $res");
                                },
                                child: Text(
                                    _toggleSigningIn == false
                                        ? "Sign In"
                                        : "Signing In...",
                                    style: GoogleFonts.quicksand(
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)))));
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
                              text: "Don't have an account? ",
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      fontSize: width <=
                                              AppConstants.portraitBreakpoint
                                          ? 16
                                          : 18,
                                      color: Colors.black)),
                              children: [
                            TextSpan(
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        fontSize: width <=
                                                AppConstants.portraitBreakpoint
                                            ? 16
                                            : 18,
                                        color: AppConstants.footerColor,
                                        fontWeight: FontWeight.bold)),
                                text: " Sign Up",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //TODO: Move to Sign Up
                                    Provider.of<AppStateManager>(context,
                                            listen: false)
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

//
// class SignIn extends StatefulWidget {
//   static MaterialPage page() {
//     return MaterialPage(
//         name: AppPages.signinPath,
//         key: ValueKey(AppPages.signinPath),
//         child: const SignIn());
//   }
//
//   const SignIn({Key? key}) : super(key: key);
//
//   @override
//   _SignInState createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormFieldState>();
//   bool _showPassword = true;
//   bool _showHome = true;
//
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       floatingActionButton: _showHome ? const SizedBox() : FloatingActionButton.extended(
//           backgroundColor: Colors.teal,
//           onPressed: () {
//             //TODO: Move to Home - Sign In
//             Provider.of<AppStateManager>(context,
//                 listen: false)
//                 .goToHome();
//           },
//           icon: const Icon(Icons.home),
//           label: Text(
//             "Home",
//             style: GoogleFonts.quicksand(
//                 textStyle: const TextStyle(color: Colors.white)),
//           )),
//       body: SafeArea(
//           child: Container(
//         height: height,
//         child: Center(
//           child: Container(
//             width: 280,
//             child: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Welcome back!",
//                       style: Theme.of(context).textTheme.headline2,
//                     ),
//                     CustomTextField(
//                         controller: _usernameController,
//                         width: width,
//                         hintText: "Username",
//                         suffixIcon: const SizedBox()),
//                     CustomTextField(
//                         obscureText: _showPassword,
//                         controller: _passwordController,
//                         width: width,
//                         hintText: "Password",
//                         suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 _showPassword = !_showPassword;
//                               });
//                             },
//                             icon:  Icon( _showPassword ? Icons.visibility_off: Icons.visibility , color: Theme.of(context).iconTheme.color, ))),
//                     Container(
//                         alignment: Alignment.centerRight,
//                         margin: const EdgeInsets.symmetric(vertical: 10),
//                         child: TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             "Forgot Password?",
//                             style: GoogleFonts.quicksand(
//                                 textStyle: const TextStyle(
//                                     color: Colors.blue, fontSize: 16)),
//                           ),
//                         )),
//
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 10),
//                       child: RichText(
//                           text: TextSpan(
//
//                               text:
//                               "By signing up, I have read and accepted the ",
//
//                               children: [
//                                 TextSpan(
//                                     style: GoogleFonts.quicksand(textStyle: const TextStyle(
//                                         color: Colors.red, fontWeight: FontWeight.w700),),
//                                     text: "Terms of Service ",
//                                     recognizer: TapGestureRecognizer()
//                                       ..onTap = () {
//                                         //TODO: Move to Terms Of Service
//                                       }),
//                                 const TextSpan(
//                                   text: "and ",
//                                 ),
//                                 TextSpan(
//                                     style: GoogleFonts.quicksand(textStyle: const TextStyle(
//                                         color: Colors.red, fontWeight: FontWeight.w700),),
//                                     text: " Privacy Policy.",
//                                     recognizer: TapGestureRecognizer()
//                                       ..onTap = () {
//                                         //TODO: Move to Privacy Policy
//                                       }),
//                               ])),
//                     ),
//                     Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10)),
//                         height: 50,
//                         width: width / 2.5,
//                         child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10))),
//                             onPressed: () {},
//                             child: Text("Sign In",
//                                 style: GoogleFonts.quicksand(
//                                     textStyle: const TextStyle(
//                                         color: Colors.white, fontSize: 18))))),
//                     // Container(
//                     //     margin: const EdgeInsets.symmetric(vertical: 10),
//                     //     decoration: BoxDecoration(
//                     //         borderRadius: BorderRadius.circular(10)),
//                     //     height: 50,
//                     //     width: width / 2.5,
//                     //     child: ElevatedButton.icon(
//                     //         style: ElevatedButton.styleFrom(
//                     //             shape: RoundedRectangleBorder(
//                     //                 borderRadius: BorderRadius.circular(10))),
//                     //         onPressed: () {},
//                     //         icon: const Icon(Icons.ten_k),
//                     //         label: Text("SIGN IN GOOGLE",
//                     //             style: GoogleFonts.quicksand(
//                     //                 textStyle: const TextStyle(
//                     //                     color: Colors.white, fontSize: 18))))),
//
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 10),
//                       child: RichText(
//                           text: TextSpan(
//                               text: "Don't have an account? ",
//                               children: [
//                             TextSpan(
//                                 style: const TextStyle(color: Colors.blue),
//                                 text: "Sign Up",
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     //TODO: Move to Sign Up
//                                     Provider.of<AppStateManager>(context,
//                                             listen: false)
//                                         .goToSignUp();
//                                   })
//                           ])),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }
