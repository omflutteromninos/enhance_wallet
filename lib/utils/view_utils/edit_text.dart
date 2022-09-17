import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'colors.dart';
import 'common_utils.dart';
import 'dimens.dart';





Widget textFieldBorderedMain(
    {TextEditingController? controller,
    required String text,
    String? hintText,
    double? width,
    TextInputType? textInputType,
    bool viewEnabled = true}) {
  if (controller != null && text != null && text.isNotEmpty) {
    controller.text = text;
  }
  return Container(
      height: dp50,
      //margin: EdgeInsets.all(10),
      width: width,
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        enabled: viewEnabled,
        style: Get.theme.textTheme.bodyText2,
        maxLines: 1,
        cursorColor: Get.theme.primaryColorLight,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          fillColor: white.withOpacity(0.03),
          hintText: hintText,
          hintStyle: Get.theme.textTheme.subtitle2,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kBorder),
              borderRadius: BorderRadius.all(Radius.circular(dp5))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: kBorder),
              borderRadius: BorderRadius.all(Radius.circular(dp5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(dp5)),
              borderSide: BorderSide(color: kThemeTextColor)),
        ),
      ));
}

Widget textFieldBordered120(
    {TextEditingController? controller,
    String? hint,
    double? width,
    TextInputType? textInputType}) {
  return Container(
      height: dp120,
      //margin: EdgeInsets.all(10),
      width: width,
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        style: Get.theme.textTheme.bodyText1,
        maxLines: 5,
        cursorColor: Get.theme.primaryColorLight,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          fillColor: white.withOpacity(0.03),
          hintText: hint,
          hintStyle: Get.theme.textTheme.subtitle2,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kBorder),
              borderRadius: BorderRadius.all(Radius.circular(dp5))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: kBorder),
              borderRadius: BorderRadius.all(Radius.circular(dp5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(dp5)),
              borderSide: BorderSide(color: kThemeTextColor)),
        ),
      ));
}



textFieldBorder({bool isError = false}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(dp10)),
    borderSide: BorderSide(
        width: 1,
        color: isError ? Colors.red : Get.theme.colorScheme.secondary),
  );
}

textFieldBorderSearch({bool isError = false}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(dp10)),
    borderSide: BorderSide(width: 1, color: isError ? Colors.red : greyBorder),
  );
}

Widget buildTextFieldIcon(String iconPath, VoidCallback action, Color color) {
  return InkWell(
    onTap: action,
    child: Padding(
        padding: EdgeInsets.all(dp15),
        child: SvgPicture.asset(
          iconPath,
          color: color,
        )),
  );
}

Widget buildTextFieldIconLeftDot(
    String iconPath, VoidCallback action, Color color) {
  return InkWell(
    onTap: action,
    child: Padding(
        padding: EdgeInsets.all(19),
        child: SvgPicture.asset(
          iconPath,
          color: color,
        )),
  );
}

Widget buildTextFieldIconLeftDot2(
    String iconPath, VoidCallback action, Color color) {
  return InkWell(
    onTap: action,
    child: Padding(
        padding: EdgeInsets.all(3),
        child: SvgPicture.asset(
          iconPath,
          color: color,
        )),
  );
}

int radioGroupValue = -1;


