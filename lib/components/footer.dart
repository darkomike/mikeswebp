import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_textfield.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
    required this.width,
    required TextEditingController emailForUpdatesController,
  })  : _emailForUpdatesController = emailForUpdatesController,
        super(key: key);

  final double width;
  final TextEditingController _emailForUpdatesController;

  void toFacebook() {}

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: ListView(
          shrinkWrap: true,
          children: [

            Container(
              height: 30,
              color: Colors.indigo,
              child: const Center(
                  child: Text("All rights reserved. Copyright @ 2021")),
            )
          ],
        ));
  }

  Container buildContacts() {
    return Container(
      color: const Color(0xff22179c),
      child: Card(
        color: const Color(0xff22179c),
        child: Column(
          children: [
            Expanded(
                child: ListTile(
              leading: const Icon(Icons.star),
              hoverColor: Colors.redAccent,
              onTap: toFacebook,
              title: Text(
                "Facebook",
                style: GoogleFonts.quicksand(
                    textStyle:
                        const TextStyle(fontSize: 20, color: Colors.white)),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
