import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required TextEditingController controller,
      required double width,
       double? height,
      FocusNode? focusNode,
      Function()? onTap,
      bool? enabled,
      String Function(String?)? validator,
      void Function(String?)? onChange,
      bool? obscureText,
      TextInputAction? textInputAction,
      TextInputType? keyboardType,
        double? borderRadius,
      required String hintText,
      required Widget suffixIcon})
      : _controller = controller,
        _width = width,
  _heigth = height,
        _borderRadius = borderRadius,
        _obscureText = obscureText,
        _enabled = enabled,
        _onChange = onChange,
        _textInputAction = textInputAction,
        _validator = validator,
        _keyboardType = keyboardType,
        _onTap = onTap,
        _hintText = hintText,
        _focusNode = focusNode,
        _suffixIcon = suffixIcon,
        super(key: key);

  final TextEditingController _controller;
  final double _width;
  final double? _heigth;
  final Widget _suffixIcon;
  final String _hintText;
  final bool? _obscureText;
  final bool? _enabled;
  final FocusNode? _focusNode;
  final Function()? _onTap;
  final String Function(String?)? _validator;
  final void Function(String?)? _onChange;
  final TextInputAction? _textInputAction;
  final TextInputType? _keyboardType;
  final double? _borderRadius ;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: _width,
        height: _heigth ?? 30,
        margin: const EdgeInsets.only(right: 5, top: 5, bottom: 5, left: 5),
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(_borderRadius ?? 5)),
        child: TextFormField(
          autocorrect: true,
          enabled: _enabled,
          validator: _validator,
          obscureText: _obscureText ?? false,
          focusNode: _focusNode,
          onChanged: _onChange,
          keyboardType: _keyboardType,
          textInputAction: _textInputAction,
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
