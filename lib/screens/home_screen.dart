import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mikesweb/components/custom_textfield.dart';
import 'package:mikesweb/components/footer.dart';
import 'package:mikesweb/models/app_pages.dart';

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
  bool _showAppTitle = false;
  bool _showDrawer = false;
  bool _showSearchTitle = true;
  bool _showDashboard = false;
  bool _showCircleAvatar = true;

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _emailForUpdatesController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print("Width: $width");

    if (width <= 500) {
      setState(() {
        _showAppTitle = false;
        _showSearchTitle = false;
        _showDrawer = true;
        _showDashboard = false;
        _showCircleAvatar = true;
      });
    } else if ((width > 500) && (width <= 800)) {
      setState(() {
        _showAppTitle = true;
        _showDrawer = true;
        _showDashboard = false;
        _showSearchTitle = false;
        _showCircleAvatar = true;
      });
    } else if ((width > 800) && (width <= 1100)) {
      setState(() {
        _showAppTitle = true;
        _showDrawer = false;
        _showDashboard = true;
        _showSearchTitle = true;
        _showCircleAvatar = true;
      });
    } else {
      setState(() {
        _showAppTitle = true;
        _showDrawer = false;
        _showSearchTitle = true;
        _showDashboard = true;
        _showCircleAvatar = true;
      });
    }

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const Drawer(),
        body: Column(
          children: [
            //Nav bar
            NavBar(
                scaffoldKey: _scaffoldKey,
                showDrawer: _showDrawer,
                showAppTitle: _showAppTitle,
                showSearchTitle: _showSearchTitle,
                searchController: _searchController,
                showCircleAvatar: _showCircleAvatar),

            // Toggle search field

            _showSearchTitle == false
                ? Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            keyField: UniqueKey(),

                            hintText: "Search for anything ...",
                            suffixIcon: ElevatedButton(
                              style: const ButtonStyle(),
                              onPressed: () {},
                              child: const Text("Search"),
                            ),
                            controller: _searchController,
                            width: 0,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            Expanded(
              child: Row(
                children: [
                  _showDrawer == false
                      ? Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: height,
                            child: Container(
                              color: Colors.red,
                              child: ListView(
                                shrinkWrap: true,
                                key: UniqueKey(),
                                children: const [
                                  Text("First"),
                                  Text("First"),
                                  Text("First"),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(
                          width: 0,
                        ),
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      height: height,
                      child: Container(
                        color: Colors.blue,
                        child: ListView(
                          key: UniqueKey(),
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: 300,
                              width: 600,
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
                            SizedBox(




                              child: _showDrawer == true ? ListView(
                                shrinkWrap: true,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [Color(0xff22179c), Color(0xff22179c)])),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text:
                                              "If you have questions, suggestions or required troubleshooting, write to us at ",
                                              style: GoogleFonts.quicksand(textStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
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
                                            keyField: UniqueKey(),
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
                                    color: const Color(0xff22179c),
                                    child: Card(
                                      color: const Color(0xff22179c),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading:  const Icon(Icons.star, color: Colors.white,),
                                            hoverColor: Colors.redAccent,
                                            onTap: (){},
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
                                ],
                              ): Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [Color(0xff22179c), Color(0xff22179c)])),
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text:
                                                "If you have questions, suggestions or required troubleshooting, write to us at ",
                                                style: GoogleFonts.quicksand(textStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
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
                                              keyField: UniqueKey(),

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
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: const Color(0xff22179c),
                                      child: Card(
                                        color: const Color(0xff22179c),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              leading:  const Icon(Icons.star, color: Colors.white,),
                                              hoverColor: Colors.redAccent,
                                              onTap: (){},
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
                                    ),
                                  )
                                ],
                              )
                            ),
                            Container(
                              height: 30,
                              color: Colors.indigo,
                              child: const Center(
                                  child: Text("All rights reserved. Copyright @ 2021")),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar(
      {Key? key,
      required bool showDrawer,
      required bool showAppTitle,
      required bool showSearchTitle,
      required TextEditingController searchController,
      required bool showCircleAvatar,
      required GlobalKey<ScaffoldState> scaffoldKey})
      : _showDrawer = showDrawer,
        _showAppTitle = showAppTitle,
        _showSearchTitle = showSearchTitle,
        _searchController = searchController,
        _showCircleAvatar = showCircleAvatar,
        _scaffoldKey = scaffoldKey,
        super(key: key);

  final bool _showDrawer;
  final bool _showAppTitle;
  final bool _showSearchTitle;
  final TextEditingController _searchController;
  final bool _showCircleAvatar;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Row(
          children: [
            _showDrawer
                ? Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(
                            _scaffoldKey.currentState!.isDrawerOpen == true
                                ? Icons.clear
                                : Icons.menu)))
                : const SizedBox(),
            _showAppTitle
                ? Expanded(
                    flex: 2,
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "MikesWeb",
                          style: Theme.of(context).textTheme.headline2,
                        )),
                  )
                : const SizedBox(
                    width: 20,
                  ),
            _showSearchTitle
                ? Expanded(
                    flex: 3,
                    child: CustomTextField(
                      keyField: UniqueKey(),

                      hintText: "Search for anything ...",
                      suffixIcon: ElevatedButton(
                        style: const ButtonStyle(),
                        onPressed: () {},
                        child: const Text("Search"),
                      ),
                      controller: _searchController,
                      width: 200,
                    ))
                : const SizedBox(
                    width: 200,
                  ),
            _showCircleAvatar
                ? Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(
                        "MD",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        color: Theme.of(context).backgroundColor);
  }
}
