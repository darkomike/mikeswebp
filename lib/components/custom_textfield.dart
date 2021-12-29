
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key,
    required TextEditingController controller,
    required double width,
    FocusNode? focusNode,
    Function()? onTap,
    bool? obscureText,
    required String hintText,

    required Widget suffixIcon})
      : _controller = controller,
        _width = width,
  _obscureText = obscureText,
        _onTap = onTap,
        _hintText = hintText,
        _focusNode = focusNode,
        _suffixIcon = suffixIcon,
        super(key: key);

  final TextEditingController _controller;
  final double _width;
  final Widget _suffixIcon;
  final String _hintText;
  final bool? _obscureText;
  final FocusNode? _focusNode;
  final Function()? _onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
        width: _width,
        height: 40,

        margin: const EdgeInsets.only(right: 5, top: 5, bottom: 5, left: 5),
        padding: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: TextFormField(
          obscureText: _obscureText ?? false,
          focusNode: _focusNode,
          obscuringCharacter: "*",
          onTap: _onTap,
          style: GoogleFonts.quicksand(
              textStyle: const TextStyle(fontSize: 18, color: Colors.black)),
          controller: _controller,
          decoration: InputDecoration(
              hintText: _hintText,
              hintStyle: GoogleFonts.quicksand(
                  textStyle:
                  const TextStyle(fontSize: 16, color: Colors.black)),
              border: InputBorder.none,
              suffixIcon: _suffixIcon),
        ));
  }

}