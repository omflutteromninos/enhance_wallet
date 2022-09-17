import 'dart:io';

import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/utils/view_utils/common_image_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'common_utils.dart';
import 'dimens.dart';
import 'colors.dart';
import '../../data/local/constants.dart';

final decorationBackgroundImage = BoxDecoration(
  image: DecorationImage(
    image: AssetImage(
      AssetConstants.splash_bg,
    ),
    fit: BoxFit.cover,
  ),
);

final navDrawerBackgroundDecoration = BoxDecoration(
  image: DecorationImage(
    image: AssetImage(
      AssetConstants.splash_bg,
    ),
    fit: BoxFit.cover,
  ),
);

getRoundedCornerShape({double borderRadius = dp20}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
  );
}

decorationBottomBorder() {
  return BoxDecoration(
    border: Border(
      bottom: BorderSide(
        //                   <--- left side
        color: Get.theme.disabledColor,
        width: dp1,
      ),
    ),
  );
}

getBoxCornerBox({Color color = kAccentColorOrange}) {
  return BoxDecoration(
      //color: color, borderRadius: BorderRadius.all(Radius.circular(dp10))

      border: Border.all(color: color, width: 2));
}

boxDecorationRoundBorder({Color color = primaryDark, double radius = 10}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(color: white, width: 0.25));
}

boxDecorationRoundCorner({Color color = primaryDark, double radius = 10}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

boxDecoration(
    {Color color = primaryDark, bool isGradient = false, double radius = 0}) {
  return BoxDecoration(
    color: isGradient ? null : color,
    gradient: isGradient ? linearGradientBottomToTop(color) : null,
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

boxDecorationLeftRound({Color color = primaryDark, double radius = 10}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
    ),
  );
}

boxDecorationTopRound({Color color = primaryDark, bool isGradient = false}) {
  return BoxDecoration(
    color: isGradient ? null : color,
    gradient: isGradient ? linearGradientBottomToTop(color) : null,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  );
}

//getRoundTransparentBox() {
getRoundTransparentBlackBox() {
  return BoxDecoration(
      color: black.withOpacity(0.5),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(dp10)));
}

getRoundSoftTransparentBox() {
  return BoxDecoration(
      color: Get.theme.primaryColor.withOpacity(0.03),
      borderRadius: BorderRadius.all(Radius.circular(dp10)));
}
getRoundThemeTransparentBox() {
  return BoxDecoration(
      color: Get.theme.primaryColorDark,
      borderRadius: BorderRadius.all(Radius.circular(dp10)));
}

getRoundBox({required Color color}) {
  return BoxDecoration(
      color: color, borderRadius: BorderRadius.all(Radius.circular(dp1)));
}

faqBoxDecoration(
    {Color color = primaryDark, bool isGradient = false, double radius = 0}) {
  return BoxDecoration(
    color: isGradient ? null : color,
    gradient: isGradient ? linearGradientBottomToTop(color) : null,
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

linearGradientBottomToTop(Color color) {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [color.withOpacity(0.2), color],
  );
}

CoinOverviewBoxDecoration(
    {required Color color1, required Color color2, double radius = 0}) {
  return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color1,
          color2,
        ],
      ),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
      //image: DecorationImage(image: SvgPicture.asset(AssetConstants.ic_icon)));
}

// getRoundTransparentBoxWithNidServerImage() {
//   return BoxDecoration(image: DecorationImage(
//       image: setNidImage(),
//       fit: BoxFit.cover),
//       color: white.withOpacity(0.03),
//       borderRadius: BorderRadius.all(Radius.circular(dp10)));
// }
// getRoundTransparentBoxWithServerImage() {
//   return BoxDecoration(
//       image: DecorationImage(
//           image: setProfileImage(myGlobalUser!),
//           fit: BoxFit.cover),
//       //color: white.withOpacity(0.03),
//       shape: BoxShape.rectangle,
//       borderRadius: BorderRadius.all(Radius.circular(dp10)));
// }

getRoundTransparentBoxImageFile(File image) {
  return BoxDecoration(
      image: DecorationImage(
        image: FileImage(image),
        fit: BoxFit.cover,
      ),
      color: white.withOpacity(0.03),
      borderRadius: BorderRadius.all(Radius.circular(dp10)));
}

getRoundTransparentBoxImage(String imagePath) {
  var _path = stringNullCheck(imagePath);
  return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(_path),
        fit: BoxFit.cover,
      ),
      color: white.withOpacity(0.03),
      borderRadius: BorderRadius.all(Radius.circular(dp10)));
}

getTransparentGradientBox() {
  return BoxDecoration(
      gradient: new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF202942),
          const Color(0xFF1B243D),
          // Color.fromARGB(255, 25,178,238),
          // Color.fromARGB(255, 21,236,229)
        ],
      ),
      //color: white.withOpacity(0.03),
      borderRadius: BorderRadius.all(Radius.circular(dp0)));
}

getTransparentGradientBoxWithTopRound() {
  return BoxDecoration(
      gradient: new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF202942),
          const Color(0xFF1B243D),
          // Color.fromARGB(255, 25,178,238),
          // Color.fromARGB(255, 21,236,229)
        ],
      ),
      //color: white.withOpacity(0.03),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(dp10), topRight: Radius.circular(dp10)));
}

getRoundTransparentBoxWithBorder() {
  return BoxDecoration(
      color: white.withOpacity(0.03),
      border: Border.all(color: kBorder),
      borderRadius: BorderRadius.all(Radius.circular(dp5)));
}

getRoundTransparentBoxWithBorderRadius20() {
  return BoxDecoration(
      color: white.withOpacity(0.03),
      border: Border.all(color: kBorder),
      borderRadius: BorderRadius.all(Radius.circular(dp20)));
}

getRoundTransparentBoxWithBorderRadius5() {
  return BoxDecoration(
      color: white.withOpacity(0.03),
      border: Border.all(color: kBorder),
      borderRadius: BorderRadius.all(Radius.circular(dp5)));
}

getGreyBackground() {
  return BoxDecoration(
    color: kGreyColor,
    // border: Border.all(color: kBorder),
    // borderRadius: BorderRadius.all(Radius.circular(dp5))
  );
}

getRoundCornerBoxWhite({Color color = white}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(Radius.circular(dp15)),
    boxShadow: [
      BoxShadow(
        color: black.withOpacity(0.3),
        blurRadius: 5,
        offset: Offset(0, 4), // Shadow position
      ),
    ],
  );
}

getRoundCornerBoxWithShadow({Color? color}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(Radius.circular(dp15)),
    boxShadow: [
      BoxShadow(
        color: black.withOpacity(0.3),
        blurRadius: 5,
        offset: Offset(0, 4), // Shadow position
      ),
    ],
  );
}

getRoundGradientCornerBoxWithShadow() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    gradient: LinearGradient(
      begin: Alignment(-0.96, 0.57),
      end: Alignment(1.0, 0.08),
      colors: [const Color(0xff6ee4ff), const Color(0xffb6f5ff)],
      stops: [0.0, 1.0],
    ),
    boxShadow: [
      BoxShadow(
        color: const Color(0xff27ccff),
        offset: Offset(0, 4),
        //blurRadius: 5,
      ),
    ],
  );
}

getRoundCornerBoxWhiteWithoutShadow({Color? color}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(Radius.circular(dp15)),
  );
}

getRoundCornerBoxBlack({Color color = black}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(Radius.circular(dp15)),
    boxShadow: [
      BoxShadow(
        color: black.withOpacity(0.3),
        blurRadius: 5,
        offset: Offset(0, 4), // Shadow position
      ),
    ],
  );
}

getRoundCornerBoxWhiteBottomRadius({Color color = white}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(dp15),
      bottomRight: Radius.circular(dp15),
    ),
    // boxShadow: kElevationToShadow[
    //     1]
    boxShadow: [
      BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 0,
          blurRadius: 6,
          offset: Offset(0, 10) // Shadow position
          ),
    ],
  );
}

getRoundCornerBoxWhiteTopRadius({Color color = white}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(dp15),
      topRight: Radius.circular(dp15),
    ),
    // boxShadow: kElevationToShadow[
    //     1]
    boxShadow: [
      BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 0,
          blurRadius: 6,
          offset: Offset(10, 0) // Shadow position
          // color: Colors.grey.withOpacity(0.8),
          // spreadRadius: 10,
          // blurRadius: 5,
          // offset: Offset(0, 7),
          ),
    ],
  );
}

getRoundCornerBorder({Color color = kTabBorder}) {
  return BoxDecoration(
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(dp10)));
}

getCircleCornerBorder({Color color = kDivider2}) {
  return BoxDecoration(
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(dp80));
}

getRoundCornerBorderWithBgColor({Color? bgColor}) {
  return BoxDecoration(
      color: bgColor, borderRadius: BorderRadius.all(Radius.circular(dp10)));
}

getRoundCornerWhite() {
  return BoxDecoration(
      color: white, borderRadius: BorderRadius.all(Radius.circular(dp50)));
}

getRoundCornerBorderOnlyTop(Color color) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.vertical(top: Radius.circular(dp20)));
}

getRoundCornerBorderOnlyBottom(Color color) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(dp20)));
}

getRoundCornerBorderOnlyTop2() {
  RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(dp20)));
}

getRoundedRectangleBorderTop(Color color) {
  RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(dp10), topRight: Radius.circular(dp10)),
      side: BorderSide(color: color));
}

getRoundedRectangleBorderBottom(Color color) {
  RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(dp10),
          bottomRight: Radius.circular(dp10)),
      side: BorderSide(color: color));
}

getCircleBoxWithCenterIcon(String iconPath, {Color color = white}) {
  return Container(
    alignment: Alignment.center,
    width: Get.width / 3,
    height: Get.width / 3,
    decoration: BoxDecoration(shape: BoxShape.circle, color: bgCircle
        //border: Border.all(color: Get.theme.colorScheme.secondary.withOpacity(0.9), width: dp4,),
        ),
    child: SvgPicture.asset(
      iconPath,
      width: dp40,
      height: dp40,
    ),
  );
}

getRectangleBoxWithText(String text,{
  Color? textColor,
  Color? bgColor,
}) {
  return Container(
    alignment: Alignment.center,
    height: 30,
    padding: EdgeInsets.all(4),
    width: Get.width / 4,
    decoration: BoxDecoration(
      color: bgColor,
      shape: BoxShape.rectangle,
    ),
    child: Text(
        stringNullCheck(text),
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 22,
        color: textColor,
        letterSpacing: 1.3199999999999998,
        fontWeight: FontWeight.w700,
        height: 1.2727272727272727,
      ),
      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
      textAlign: TextAlign.center,
    ),
  );
}

boxDecorationOnlyTop() {
  return BoxDecoration(
      color: Get.theme.colorScheme.secondary,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(dp50), topRight: Radius.circular(dp50)));
}

decorationRoundCornerBorder() {
  return BoxDecoration(
      border: Border.all(color: kBorder),
      //color: white.withOpacity(0.03),
      color: kCommonBackgroundColor.withOpacity(0.03),
      borderRadius: BorderRadius.all(Radius.circular(dp5)));
}
