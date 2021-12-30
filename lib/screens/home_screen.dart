import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mikesweb/components/custom_textfield.dart';
import 'package:mikesweb/models/app_pages.dart';
import 'package:mikesweb/models/app_state_manager.dart';
import 'package:mikesweb/screens/login.dart';
import 'package:mikesweb/utils/constants.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.homePath,
        key: ValueKey(AppPages.homePath),
        child: const Home());
  }

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _showDrawer = false;
  bool _showSearchTitle = false;

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _emailForUpdatesController =
      TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  double? width;

  @override
  void initState() {
    width = AppConstants.portraitBreakpoint;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print("Width: $width");

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: width! <= AppConstants.portraitBreakpoint
          ? AppBar(

              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _showSearchTitle = !_showSearchTitle;
                      });
                    },
                    icon: const Icon(Icons.search)),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Text(
                    "MD",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
              bottom: PreferredSize(
                child: _showSearchTitle == true
                    ? CustomTextField(
                        hintText: "Search for anything ...",
                        suffixIcon: ElevatedButton(
                          style: const ButtonStyle(),
                          onPressed: () {},
                          child: const Text("Search"),
                        ),
                        controller: _searchController,
                        width: width!,
                      )
                    : const Expanded(
                        child: SizedBox(
                        height: 0,
                      )),
                preferredSize:
                    Size.fromHeight(_showSearchTitle == true ? 50 : 1),
              ),
        backgroundColor: Colors.teal,
            )
          :
          // Landscape Nav Bar
          AppBar(
            backgroundColor: Colors.teal,

            leading: const SizedBox(),
              title: Text(
                "MikesWeb",
                style: GoogleFonts.parisienne(textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ),
              actions: [
                CustomTextField(
                  hintText: "Search for anything ...",
                  suffixIcon: ElevatedButton(
                    style: const ButtonStyle(),
                    onPressed: () {},
                    child: const Text("Search"),
                  ),
                  controller: _searchController,
                  width: 400,
                ),
                const SizedBox(width: 10,),

                CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Text(
                    "MD",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text("@username", style: GoogleFonts.lobster(textStyle: const TextStyle(fontSize: 20, color: Colors.black)),)),

                const SizedBox(
                  width: 10,
                ),
              ],
            ),
      key: _scaffoldKey,
      drawer: Drawer(
        child: AppDrawer(showAppTitle:
        width! <= AppConstants.portraitBreakpoint),
      ),
      body: SizedBox(
        height: height,
        child: width! <= AppConstants.portraitBreakpoint
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      height: 300,
                      width: width,
                      child: Center(
                          child: PageView(
                            physics:const  BouncingScrollPhysics(),
                            children: const [
                              //TODO: Slide
                            ],
                          )
                      ),
                      color: Colors.green,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 500,
                      child: Center(
                          child: Text(
                        "Main",
                        style: Theme.of(context).textTheme.headline3,
                      )),
                    ),
                    Container(
                        color: AppConstants.footerColor,
                        child: width! <= AppConstants.portraitBreakpoint
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: footerContents())
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: footerContents())),
                    Container(
                      height: 30,
                      color: Theme.of(context).backgroundColor.withOpacity(0.9),
                      child: const Center(
                          child: Text("All rights reserved. Copyright @ 2021")),
                    )
                  ],
                ),
              )
            : Row(
                children: [
                  width! >= AppConstants.portraitBreakpoint
                      ? SizedBox(
                          width: AppConstants.drawerWidth,
                          height: height,
                          child: AppDrawer(
                            showAppTitle:
                                width! <= AppConstants.portraitBreakpoint,
                          ),
                        )
                      : const SizedBox(
                          width: 0,
                        ),
                  SizedBox(
                    height: height,
                    width: width! - AppConstants.drawerWidth,
                    child: ListView(
                      children: [
                        Container(
                          height: 300,
                          width: width! - AppConstants.drawerWidth,
                          color: Colors.green,
                          child: Center(
                              child: Text(
                            "Head Section",
                            style: Theme.of(context).textTheme.headline3,
                          )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          color: Colors.teal,
                          height: 500,
                          width: width! - AppConstants.drawerWidth,
                          child: Center(
                              child: Text(
                            "Main",
                            style: Theme.of(context).textTheme.headline3,
                          )),
                        ),

                        Container(
                            color: AppConstants.footerColor,
                            width: width! - AppConstants.drawerWidth,
                            child: Row(
                                children: [
                                  Container(
                                    width: width! - AppConstants.drawerWidth,

                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [AppConstants.footerColor, AppConstants.footerColor])),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      RichText(
                                        text: TextSpan(
                                          text:
                                          "If you have questions, suggestions or required troubleshooting, write to us at ",
                                          style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: " support@emart.org",
                                                style: const TextStyle(color: Colors.red),
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () {
                                                    print("Click");
                                                  },
                                                onEnter: (event) {}),
                                            const TextSpan(
                                              text:
                                              " and we will try to figure it out.\n\nPlease provide us your email for daily updates of our products and services. ",
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      CustomTextField(
                                        hintText: "Email",
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            _emailForUpdatesController.clear();
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.black,
                                          ),
                                        ),
                                        controller: _emailForUpdatesController,
                                        width: 500,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "Subscribe",
                                            style: GoogleFonts.quicksand(
                                                textStyle: const TextStyle(
                                                    fontSize: 18, fontWeight: FontWeight.w500)),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ])),
                        Container(
                          height: 30,
                          width: width! - AppConstants.drawerWidth,
                          color: Colors.black.withOpacity(0.9),
                          child:  Center(
                              child: Text(
                                  "All rights reserved. Copyright @ 2021", style: GoogleFonts.quicksand(
                                  textStyle: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),) ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  footerContents() {
    return [
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppConstants.footerColor, AppConstants.footerColor])),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
            text: TextSpan(
              text:
                  "If you have questions, suggestions or required troubleshooting, write to us at ",
              style: GoogleFonts.quicksand(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
              children: <TextSpan>[
                TextSpan(
                    text: " support@emart.org",
                    style: const TextStyle(color: Colors.red),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Click");
                      },
                    onEnter: (event) {}),
                const TextSpan(
                  text:
                      " and we will try to figure it out.\n\nPlease provide us your email for daily updates of our products and services. ",
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextField(
            hintText: "Email",
            suffixIcon: IconButton(
              onPressed: () {
                _emailForUpdatesController.clear();
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
            ),
            controller: _emailForUpdatesController,
            width: 500,
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              child: Text(
                "Subscribe",
                style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ]),
      ),
      Container(
        color: AppConstants.footerColor,
        child: Card(
          color: AppConstants.footerColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                hoverColor: Colors.teal,
                onTap: () {},
                title: Text(
                  "Facebook",
                  style: GoogleFonts.quicksand(
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      )
    ];
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key, required bool showAppTitle})
      : _showAppTitle = showAppTitle,
        super(key: key);

  final bool _showAppTitle;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _showAppTitle == true
              ? SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Text(
                        "MikesWeb",
                        style: GoogleFonts.parisienne(textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          const Divider(
            height: 5,
          ),
          ListTile(
            leading:  Icon(Icons.dashboard, color:Theme.of(context).iconTheme.color ,),

            title: const Text("Dashboard"),
            onTap: () {},

            hoverColor: Colors.teal[200],
          ),
          ListTile(
            leading:  Icon(Icons.mail, color: Theme.of(context).iconTheme.color),

            title: const Text("Inbox"),
            onTap: () {},

            hoverColor: Colors.teal[200],
          ),
          ListTile(
            leading:  Icon(Icons.explore, color: Theme.of(context).iconTheme.color),

            title: const Text("Explore"),
            onTap: () {},

            hoverColor: Colors.teal[200],
          ),
          ListTile(
            leading:  Icon(Icons.settings, color: Theme.of(context).iconTheme.color),

            title: const Text("Settings"),
            onTap: () {},

            hoverColor: Colors.teal[200],
          ),
          ListTile(
            leading:  Icon(Icons.star, color: Theme.of(context).iconTheme.color),

            title: const Text("Sign Up"),
            onTap: () {
              Provider.of<AppStateManager>(context, listen: false).goToSignUp();
              print("Sign Up Clicked");
            },

            hoverColor: Colors.teal[200],
          ),
          ListTile(
            leading:  Icon(Icons.star, color: Theme.of(context).iconTheme.color),

            title: const Text("Sign In"),
            onTap: () {
              Provider.of<AppStateManager>(context, listen: false).goToSignIn();
              print("Sign In Clicked");            },

            hoverColor: Colors.teal[200],
          ),
          ListTile(
            leading:  Icon(Icons.star, color: Theme.of(context).iconTheme.color),

            title: const Text("Log Out"),
            onTap: () {
              Provider.of<AppStateManager>(context, listen: false).logout();
              print("Logout Clicked");
            },

            hoverColor: Colors.teal[200],
          )
        ],
      ),
    );
  }
}
