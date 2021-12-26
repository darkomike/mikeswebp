import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
        required TextEditingController controller,
        required double width,
        required String hintText ,
        required var keyField,
        required Widget suffixIcon})
      : _controller = controller,
        _width = width,
        _hintText = hintText,
        _suffixIcon = suffixIcon,
        _keyField = keyField,
        super(key: key);

  final TextEditingController _controller;
  final double _width;
  final Widget _suffixIcon;
   final String _hintText;
   final _keyField;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget._width,

        margin: const EdgeInsets.only(right: 5, top: 5, bottom: 5, left: 5),
        padding: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: TextFormField(

          style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 18, color: Colors.black)),
          controller: widget._controller,
          key: widget._keyField,
          decoration: InputDecoration(
              hintText: widget._hintText,
              hintStyle: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 16, color: Colors.black)),

              border: InputBorder.none, suffixIcon: widget._suffixIcon),
        ));
  }
}
