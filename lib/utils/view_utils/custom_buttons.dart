import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

import 'colors.dart';
import 'common_widget.dart';
import '../../data/local/constants.dart';
import 'text_utils.dart';
import 'decorations.dart';

/*

Widget buttonOnlyIcon(Icon icon, VoidCallback onPressCallback,
    {String iconPath = "", double size = dp20, bool isColorDark = false}) {
  return IconButton(
    onPressed: onPressCallback,
    icon: iconPath.isNotEmpty
        ? SvgPicture.asset(
            iconPath,
            width: size,
            height: size,
          )
        : icon,
  );
}
*/

Widget appBarMenuIcon(BuildContext context) {
  return Container(
    // height: dp50,
    // width: dp50,
    // padding: EdgeInsets.all(8),
    // decoration: getRoundCornerBoxWithShadow(color: white),
    child: buttonOnlyIcon2(
        onPressCallback: () {
          Scaffold.of(context).openDrawer();
        },
        iconPath: AssetConstants.ic_category,
        size: dp25),
  );
}
// Widget appBarMenuIcon(BuildContext context) {
//   return Container(
//     height: dp50,
//     width: dp50,
//     padding: EdgeInsets.all(8),
//     decoration: getRoundCornerBoxWithShadow(color: white),
//     child: buttonOnlyIcon(onPressCallback: () {
//       Scaffold.of(context).openDrawer();
//     }, iconPath: AssetConstants.ic_category, size: dp25),
//   );
// }

Widget appBarMenuIconBlack() {
  return Container(
    height: dp50,
    width: dp50,
    padding: EdgeInsets.all(8),
    decoration: getRoundCornerBoxWithShadow(color: black),
    child: InkWell(
      onTap: () {
        Get.back();
      },
      child: buttonOnlyIconColor(
          onPressCallback: () {
            Get.back();
          },
          color: white,
          iconPath: AssetConstants.ic_arrow_left,
          size: dp25),
    ),
  );
}

Widget buttonRoundedFill(
  String text,
  VoidCallback onPressCallback, {
  double width = 0,
  Color? textColor,
  Color? bgColor,
  Color? borderColor,
}) {
  double buttonWidth = width == 0 ? Get.width : width;
  var bgColorL = bgColor ?? Get.theme.colorScheme.secondary;
  var borderColorL = borderColor ?? bgColorL;
  var textColorL = textColor ?? Get.theme.primaryColorDark;
  return Container(
      margin: const EdgeInsets.all(10),
      height: 50,
      width: buttonWidth,
      child: ElevatedButton(
          child: AutoSizeText(text,
              style: Get.textTheme.button!.copyWith(color: textColorL)),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(bgColorL),
              backgroundColor: MaterialStateProperty.all<Color>(bgColorL),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      side: BorderSide(color: borderColorL)))),
          onPressed: onPressCallback));
}

Widget buttonOnlyIcon(VoidCallback? onPressCallback,
    {String iconPath = "", double size = 15, Color? iconColor, Color bgColor = Colors.transparent}) {
  return Material(
    color: Colors.transparent,
    child: IconButton(
      iconSize: size,
      padding: EdgeInsets.zero,
      onPressed: onPressCallback,
      icon: iconPath.isNotEmpty
          ? iconPath.contains(".svg")
              ? SvgPicture.asset(
                  iconPath,
                  //width: size,
                  //height: size,
                  color: iconColor,
                )
              : Image.asset(
                  iconPath,
                  //width: size,
                  //height: size,
                  color: iconColor,
                )
          : const SizedBox(),
    ),
  );
}

Widget buttonOnlyIcon2(
    {Icon? icon,
    VoidCallback? onPressCallback,
    String iconPath = "",
    double? size,
    Color? iconColor}) {
  return Material(
    color: Colors.transparent,
    child: IconButton(
      onPressed: onPressCallback,
      icon: iconPath.isNotEmpty
          ? iconPath.contains(".svg")
              ? SvgPicture.asset(
                  iconPath,
                  width: size,
                  height: size,
                  color: iconColor,
                )
              : Image.asset(
                  iconPath,
                  width: size,
                  height: size,
                  color: iconColor,
                )
          : Container(),
    ),
  );
}

Widget buttonOnlyIconColor(
    {Icon? icon,
    VoidCallback? onPressCallback,
    Color? color,
    String? iconPath = "",
    double size = dp20,
    bool isColorDark = false}) {
  return IconButton(
    onPressed: onPressCallback,
    icon: iconPath!.isNotEmpty
        ? iconPath.contains(".svg")
            ? SvgPicture.asset(
                iconPath,
                width: size,
                color: color,
                height: size,
              )
            : Image.asset(
                iconPath,
                width: size,
                height: size,
              )
        : icon!,
  );
}

Widget buttonRoundedMain(
    {required String text,
    VoidCallback? onPressCallback,
    Color? textColor,
    Color? bgColor,
    double width = dp0}) {
  double buttonWidth = width == 0 ? Get.width : width;
  return Container(
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
      height: dp50,
      width: buttonWidth,
      child: ElevatedButton(
          child: AutoSizeText(text,
              style: Get.theme.textTheme.button!
                  .copyWith(color: kButtonTextColor)),
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(kAccentColorOrange),
              backgroundColor:
                  MaterialStateProperty.all<Color>(kAccentColorOrange),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(dp5)),
                      side: BorderSide(color: kAccentColorOrange)))),
          onPressed: onPressCallback));
}
/*Widget buttonRoundedMain(
    {String text,
    VoidCallback onPressCallback,
    Color? textColor,
    Color bgColor,
    double width = dp0}) {
  double buttonWidth = width == 0 ? Get.width : width;
  return Container(
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
      height: dp60,
      width: buttonWidth,
      child: ElevatedButton(
          child: AutoSizeText(text,
              style: Get.theme.textTheme.button.copyWith(color: textColor)),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(bgColor),
              backgroundColor: MaterialStateProperty.all<Color>(bgColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(dp5)),
                      side: BorderSide(color: bgColor)))),
          onPressed: onPressCallback));
}*/

Widget textButton(
    {required String text,
    VoidCallback? onPressCallback,
    Color? textColor,
    Color? bgColor,
    double width = dp0}) {
  double buttonWidth = width == 0 ? Get.width : width;
  return InkWell(
    onTap: onPressCallback,
    child: Container(
        margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
        //height: dp60,
        padding: EdgeInsets.symmetric(vertical: dp15),
        width: buttonWidth,
        child: textBodyNormal16(text: text, maxLines: 1)),
  );
}

Widget buttonRoundedWithBorder(
    {required String text,
    double margin = dp15,
    VoidCallback? onPressCallback,
    Color? textColor = kAccentColorOrange,
    Color? bgColor = kCommonBackgroundColor,
    Color? borderColor = kAccentColorOrange,
    double width = dp0}) {
  double buttonWidth = width == 0 ? Get.width : width;
  return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      height: dp50,
      width: buttonWidth,
      child: ElevatedButton(
          child: AutoSizeText(text,
              style: Get.theme.textTheme.button!.copyWith(color: textColor)),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(bgColor!),
              backgroundColor: MaterialStateProperty.all<Color>(bgColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(dp5)),
                      side: BorderSide(color: borderColor!)))),
          onPressed: onPressCallback));
}
Widget buttonRoundedWithIcon(String text,String iconPath, VoidCallback onPressCallback,
    {double width = 0, Color? textColor, Color? bgColor, Color? borderColor}) {
  double buttonWidth = width == 0 ? Get.width : width;
  var bgColorL = bgColor ?? Get.theme.colorScheme.secondary;
  var borderColorL = borderColor ?? bgColorL;
  var textColorL = textColor ?? Get.theme.primaryColorDark;
  return Container(
      margin: const EdgeInsets.all(10),
      height: 50,
      width: buttonWidth,
      child: ElevatedButton.icon(
        icon: SvgPicture.asset(
          iconPath,
          height: 25,
        ),
        label: AutoSizeText(text, style: Get.textTheme.button!.copyWith(color: textColorL, fontSize: 14), maxLines: 1,),
        onPressed: onPressCallback,
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(bgColorL),
            backgroundColor: MaterialStateProperty.all<Color>(bgColorL),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)), side: BorderSide(color: borderColorL)))),
      ));
}

// getRoundTransparentBoxWithBorder() {
//   return BoxDecoration(
//       color: white.withOpacity(0.03),
//       border: Border.all(color: kBorder),
//       borderRadius: BorderRadius.all(Radius.circular(dp5)));
// }
Widget buttonIconWithBorder(String iconPath, VoidCallback onPress, {Color? iconColor}) {
  return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 0.25)),
      child: buttonOnlyIcon(onPress, iconPath: iconPath, iconColor: iconColor));
}
//
// Widget buttonRoundedCopyRefCode(String btnText,
//     {required String text,
//     String? iconPath,
//     VoidCallback? onPressCallback}) {
//   return Container(
//       margin: EdgeInsets.all(dp0),
//       padding: EdgeInsets.all(dp0),
//       decoration: getRoundTransparentBoxWithBorder(),
//       height: dp50,
//       width: Get.width,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: InkWell(
//               onTap: onPressCallback,
//               // child: imageView(iconPath: iconPath),
//               child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: dp15),
//                   height: dp50,
//                   decoration: getGreyBackground(),
//                   child: Center(
//                       child: textBodyNormal14(text: btntext, maxLines: 1))),
//             ),
//           ),
//           Expanded(
//               child: Align(
//                   alignment: Alignment.center,
//                   child: textSubtitleNormal14(text: text, maxLines: 1))),
//         ],
//       ));
// }

Widget buttonText(String text,VoidCallback action, {double fontSize = dp16}) {
  return Container(
    margin: EdgeInsets.only(right: dp10, left: dp10),
    alignment: Alignment.centerLeft,
    child: TextButton(
      onPressed: action,
      child: AutoSizeText(
        text,
        style: TextStyle(
            color: Get.theme.primaryColorLight,
            fontWeight: FontWeight.normal,
            fontSize: fontSize),
      ),
    ),
  );
}

Widget buttonVerticalRoundedOnly(String button, bool isTop,
    {VoidCallback? buttonAction,
    Color? textColor,
    Color? bgColor,
    double width = dp0}) {
  double buttonWidth = width == 0 ? Get.width : width;
  return Container(
    decoration: isTop
        ? getRoundCornerBorderOnlyTop(bgColor!)
        : getRoundCornerBorderOnlyBottom(bgColor!),
    margin: EdgeInsets.only(left: 16, right: 16),
    height: dp60,
    width: buttonWidth,
    child: ElevatedButton(
        child: AutoSizeText(button,
            presetFontSizes: [20, 18, 16],
            style: Get.theme.textTheme.button!
                .copyWith(color: textColor, fontWeight: FontWeight.normal)),
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(bgColor),
          backgroundColor: MaterialStateProperty.all<Color>(bgColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(isTop
              ? getRoundedRectangleBorderTop(bgColor)
              : getRoundedRectangleBorderBottom(bgColor)),
        ),
        onPressed: buttonAction),
  );
}

Widget buttonIconWithRoundBg(String iconPath,
    {VoidCallback? onPress,
    Color? iconColor,
    Color? bgColor,
    double size = 25,
    double padding = 10}) {
  var bgColorL = bgColor ?? Get.theme.colorScheme.secondary;
  var iconColorL = iconColor ?? bgColorL;
  return RawMaterialButton(
    onPressed: onPress,
    fillColor: bgColorL.withOpacity(0.3),
    elevation: 0,
    child: SvgPicture.asset(
      iconPath,
      color: iconColorL,
      width: size,
      height: size,
    ),
    padding: EdgeInsets.all(padding),
    shape: const CircleBorder(),
  );
}
