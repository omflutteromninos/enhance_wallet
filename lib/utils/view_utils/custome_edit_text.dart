import 'package:flutter/material.dart';

class CustomEditText extends StatelessWidget {
  final FormFieldSetter<String>? onSaved;
  final String hint;
  final bool obsecure;
  final FormFieldValidator<String>? validator;
  final TextStyle? textStyle;
  final Color borderFocusColor;
  final Color borderColor;
  final Color backGroundColor;
  final double borderSize;
  final double? height;
  final double? width;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final double? borderRadius;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;

  CustomEditText(
      {this.onSaved,
      this.hint = "",
      this.obsecure = false,
      this.validator,
      this.textStyle,
      this.borderFocusColor = Colors.transparent,
      this.borderColor = Colors.transparent,
      this.backGroundColor = Colors.transparent,
      this.borderSize = 1,
      this.height,
      this.width,
      this.cursorColor,
      this.suffixIcon,
      this.hintStyle,
      this.onTap,
      this.focusNode,
      @required this.controller,
      this.borderRadius = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: backGroundColor, borderRadius: BorderRadius.circular(8.0)),
        child: TextFormField(
          controller: controller,
          onSaved: onSaved,
          validator: validator,
          autofocus: false,
          obscureText: obsecure,
          style: textStyle,
          cursorColor: cursorColor,
          onTap: onTap,
          focusNode: focusNode,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hint,
            hintStyle: hintStyle,
            contentPadding:
                new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: borderFocusColor, width: borderSize),
                borderRadius: BorderRadius.circular(borderRadius!)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: borderSize),
                borderRadius: BorderRadius.circular(borderRadius!)),
          ),
        ));
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
