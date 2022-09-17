import 'package:auto_size_text/auto_size_text.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common_utils.dart';
import 'dimens.dart';
import 'colors.dart';

Widget textAutoSize(String? text,
    {VoidCallback? onTap,
    double hMargin = dp10,
    int maxLines = 1,
    Color? color,
    FontWeight fontWeight = FontWeight.w600,
    double? width,
    TextAlign? textAlign = TextAlign.start,
    double fontSize = dp16,
    lineHeight}) {
  var colorL = color ?? Get.theme.primaryColor;
  var widthL = width ?? Get.width;
  return Container(
    width: widthL,
    //color: Colors.red,
    //margin: EdgeInsets.only(left: hMargin, right: hMargin),
    child: InkWell(
      child: AutoSizeText(
        text!,
        maxLines: maxLines,
        minFontSize: dp10,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: Get.textTheme.headline5!.copyWith(
            color: colorL,
            fontWeight: fontWeight,
            fontSize: fontSize,
            height: 1.3),
      ),
      onTap: onTap,
    ),
  );
}

// Widget textWithCopyButton(String btnText, String text) {
//   return Container(
//       margin: const EdgeInsets.all(10),
//       decoration: boxDecorationRoundBorder(color: Colors.transparent),
//       height: 50,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//               height: 50,
//               alignment: Alignment.center,
//               decoration: boxDecorationLeftRound(radius: dp5),
//               child: textAutoSize(btnText, maxLines: 1, width: 50, textAlign: TextAlign.center, onTap: (){
//                 copyToClipboard(text);
//               })
//           ),
//           Expanded(child: Align(alignment: Alignment.center, child: textAutoSize(text, maxLines: 2))),
//         ],
//       ));
// }
Widget textWithCopyButton(String btnText, String text) {
  return Container(
      //margin: const EdgeInsets.all(10),
      margin: EdgeInsets.all(dp0),
      padding: EdgeInsets.all(dp0),
      decoration: getRoundTransparentBoxWithBorder(),
      height: 50,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: dp7),
              height: dp50,
              decoration: getGreyBackground(),
              child: textAutoSize(btnText,
                  fontSize: dp14,
                  fontWeight: FontWeight.bold,
                  maxLines: 1,
                  width: 50,
                  textAlign: TextAlign.center, onTap: () {
                copyToClipboard(text);
              })),
          Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: textAutoSize(text,
                      textAlign: TextAlign.center,
                      fontSize: dp14,
                      fontWeight: FontWeight.normal,
                      color: Get.theme.primaryColor.withOpacity(0.60),
                      maxLines: 2))),
        ],
      ));
}
Widget textWithCopyButton2(String btnText, String text) {
  return Container(
      margin: const EdgeInsets.all(10),
      decoration: boxDecorationRoundBorder(color: Colors.transparent),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 50,
              alignment: Alignment.center,
              decoration: boxDecorationLeftRound(radius: dp5),
              child: textAutoSize(btnText, maxLines: 1, width: 50, textAlign: TextAlign.center, onTap: (){
                copyToClipboard(text);
              })
          ),
          Expanded(child: Align(alignment: Alignment.center, child: textAutoSize(text, maxLines: 2))),
        ],
      ));
}
Widget textAutoSizeSubtitle(String text,
    {VoidCallback? onTap,
    double hMargin = dp10,
    int maxLines = 1,
    Color? color,
    FontWeight fontWeight = FontWeight.w700,
    double? width,
    TextAlign? textAlign = TextAlign.start,
    double fontSize = dp16}) {
  var colorL = color ?? Get.theme.primaryColor.withOpacity(0.60);
  var widthL = width ?? Get.width;
  return Container(
    width: widthL,
    //color: Colors.red,
    margin: EdgeInsets.only(left: hMargin, right: hMargin),
    child: InkWell(
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        minFontSize: dp10,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: Get.textTheme.headline5!.copyWith(
            color: colorL, fontWeight: fontWeight, fontSize: fontSize),
      ),
      onTap: onTap,
    ),
  );
}

Widget textSpan(String title, String subTitle, {int maxLines = 1, Color? color, TextAlign textAlign = TextAlign.center}) {
  var colorL = color ?? Get.theme.primaryColor;
  return AutoSizeText.rich(
    TextSpan(
      text: title,
      style: Get.textTheme.bodyText2!.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
      children: <TextSpan>[
        TextSpan(
          text: subTitle,
          style: Get.textTheme.subtitle1!.copyWith(fontSize: 12, fontWeight: FontWeight.w100, color: colorL),
        ),
      ],
    ),
    maxLines: maxLines,
    textAlign: textAlign,

  );
}
Widget textSpanSameSizeText(String title, String subTitle, {int maxLines = 1, Color? color, TextAlign textAlign = TextAlign.center}) {
  var colorL = color ?? Get.theme.primaryColor;
  return AutoSizeText.rich(
    TextSpan(
      text: title,
      style: Get.textTheme.bodyText2!.copyWith(fontSize: 14, fontWeight: FontWeight.normal,color: colorL),
      children: <TextSpan>[
        TextSpan(
          text: subTitle,
          style: Get.textTheme.bodyText2!.copyWith(fontSize: 14, fontWeight: FontWeight.normal, color: colorL),
        ),
      ],
    ),
    maxLines: maxLines,
    textAlign: textAlign,

  );
}
Widget textTitleLarge(String text,{
  bool isWhite = false,
}) {
  return Container(
    margin: EdgeInsets.only(left: dp10, right: dp10),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: isWhite
          ? Get.theme.textTheme.headline5
          : Get.theme.textTheme.headline1,
    ),
  );
}

Widget textNormalCenter22({required String text,int? maxLines}) {
  return Container(
    //margin: EdgeInsets.only(left: dp10),
    child: AutoSizeText(
      text,
      //softWrap: true,
      presetFontSizes: [22, 20, 18],
      textAlign: TextAlign.center,
      style: Get.theme.textTheme.headline1,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget textNormalCenter32({required String text,int? maxLines}) {
  return Container(
    //margin: EdgeInsets.only(left: dp10),
    child: AutoSizeText(
      text,
      //softWrap: true,
      presetFontSizes: [32, 26, 22],
      textAlign: TextAlign.center,
      style: Get.theme.textTheme.headline1!.copyWith(color: kAccentColorOrange),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget textBodyNormalWhite20({required String text,Color? textColor, int? maxLines}) {
  return Container(
    //margin: EdgeInsets.only(left: dp10),
    child: Flexible(
      child: AutoSizeText(
        text,
        //softWrap: true,
        presetFontSizes: [22, 20,18],
        textAlign: TextAlign.left,
        style: Get.theme.textTheme.headline2!.copyWith(color: white,fontWeight: FontWeight.w900),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}

Widget textBodyNormalWhite14(
    {required String text,
    int? maxLines,
    Color? textColor = textColor,
    double leftMargin = dp0}) {
  return Container(
    alignment: Alignment.centerLeft,
    width: Get.width,
    margin: EdgeInsets.only(left: leftMargin, right: dp0),
    child: AutoSizeText(
      text,
      maxLines: maxLines,
      presetFontSizes: [14, 12, 10],
      style: Get.theme.textTheme.bodyText1!.copyWith(color: white),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget textBodyNormal22({required String text,int? maxLines}) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: dp0, right: dp0),
    child: AutoSizeText(
      text,
      presetFontSizes: [22, 20, 18],
      maxLines: maxLines,
      style: Get.theme.textTheme.bodyText1,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget textBodyBold16({required String text,int? maxLines, Color? textColor}) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: dp0, right: dp0),
    child: AutoSizeText(
      text,
      presetFontSizes: [16, 14, 12],
      maxLines: maxLines,
      style: Get.theme.textTheme.bodyText2!.copyWith(color: textColor),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget textBodyNormal16(
    {required String text,
    int? maxLines,
    Color? textColor,
    VoidCallback? onPressCallback,
    TextAlign? textAlign}) {
  return Container(
    margin: EdgeInsets.only(left: dp0, right: dp0),
    child: AutoSizeText(
      text,
      maxLines: maxLines,
      presetFontSizes: [16, 14],
      style: Get.theme.textTheme.bodyText1!.copyWith(color: textColor),
      //textAlign: TextAlign.left,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget textBodyNormal14({required String text,int? maxLines, TextAlign? textAlign,Color? textColor}) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: dp0, right: dp0),
    child: AutoSizeText(
      text,
      maxLines: maxLines,
      presetFontSizes: [14, 12, 10],
      style: Get.theme.textTheme.bodyText1!.copyWith(color: textColor),
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
Widget textBodyNormal12({required String text,int? maxLines, TextAlign? textAlign,Color? textColor}) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: dp0, right: dp0),
    child: AutoSizeText(
      text,
      maxLines: maxLines,
      presetFontSizes: [ 12, 10],
      style: Get.theme.textTheme.bodyText1!.copyWith(color: textColor,fontSize: 12),
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget textBodyBold14({required String text, int? maxLines,
    TextAlign? textAlign, TextDirection? textDirection, Alignment alignment = Alignment.centerLeft}) {
  return Container(
    alignment: alignment,
    margin: EdgeInsets.only(left: dp0, right: dp0),
    child: AutoSizeText(
      text,
      presetFontSizes: [14, 12, 10],
      maxLines: maxLines,
      style: Get.theme.textTheme.bodyText2,
      textAlign: textAlign,
      textDirection: textDirection,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget textSubtitleNormal12({required String text,int? maxLines, Color? textColor}) {
  return Container(
    margin: EdgeInsets.only(left: dp0, right: dp0),
    child: AutoSizeText(
      text,
      maxLines: maxLines,
      presetFontSizes: [12, 10],
      style: Get.theme.textTheme.bodyText1!.copyWith(color: textColor, height: 2),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget textSubtitleNormalFor12({required String text,int? maxLines, Color? textColor}) {
  return Container(
    margin: EdgeInsets.only(left: dp0, right: dp0),
    child: AutoSizeText(
      text,
      maxLines: maxLines,
      presetFontSizes: [12, 10],
      style: Get.theme.textTheme.bodyText1!.copyWith(color: textColor, height: 1),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget textSubtitleNormal14({required String text,int? maxLines}) {
  return Container(
    margin: EdgeInsets.only(left: dp0, right: dp0),
    child: AutoSizeText(
      text,
      maxLines: maxLines,
      presetFontSizes: [14, 12, 10],
      style: Get.theme.textTheme.subtitle1,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget textSubtitle(String text,
    {TextAlign? textAlign,
    double margin = dp10,
    bool isBold = true,
    int? maxLines = 1}) {
  return Container(
    margin: EdgeInsets.only(left: margin, right: margin),
    child: Text(
      text,
      textAlign: textAlign,
      style: isBold
          ? Get.theme.textTheme.subtitle1
          : Get.theme.textTheme.subtitle2,
      maxLines: maxLines,
    ),
  );
}

Widget textSubtitle1(
    {required String text,
    TextAlign? textAlign,
      double? fontSize,
    //FontSize? fontSize,
    double margin = 0,
    int? maxLines}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin),
    child: AutoSizeText(
      text,
      maxLines: maxLines,
      presetFontSizes: [12, 10],
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: Get.theme.textTheme.subtitle1,
    ),
  );
}

Widget textSubtitle2(
    {required String text,
    TextAlign? textAlign,
      double? fontSize,
    //FontSize? fontSize,
    double? margin,
    int? maxLines}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin!),
    child: AutoSizeText(
      text,
      presetFontSizes: [14, 12],
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
      style: Get.theme.textTheme.subtitle2,
    ),
  );
}

// Widget textTitleMid(String text,
//     {VoidCallback onTap, double margin = dp10, double width, int? maxLines = 1, Color? textColor}) {
//   double widthC = width == 0 ? Get.width : width;
//   var style =
//   textColor == null ? Get.theme.textTheme.headline2 : Get.theme.textTheme.headline2.copyWith(color: textColor);
//   return Container(
//     margin: EdgeInsets.only(left: margin, right: margin),
//     width: widthC,
//     child: InkWell(
//       child: Text(
//         text,
//         style: style,
//         maxLines: maxLines,
//         overflow: TextOverflow.ellipsis,
//       ),
//       onTap: onTap,
//     ),
//   );
// }

Widget textMoveable(
    {required String text,int? maxLines, Color? textColor, double leftMargin = dp10}) {
  return Container(
    alignment: Alignment.centerLeft,
    width: Get.width,
    margin: EdgeInsets.only(left: leftMargin, right: dp5),
    child: AutoSizeText(
      text,
      maxLines: maxLines,
      presetFontSizes: [14, 12, 10],
      style: Get.theme.textTheme.bodyText1!.copyWith(color: textColor),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget textTitleLargeMain(
    String title, double fontSize, TextAlign textAlign, Color? textColor,
    {int? maxLines}) {
  return Container(
    margin: EdgeInsets.only(left: 0, right: 0),
    child: AutoSizeText(
      title,
      maxLines: maxLines,
      minFontSize: 10,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: Get.theme.textTheme.headline1!
          .copyWith(fontSize: fontSize, color: textColor),
    ),
  );
}

Widget textTitleMid(String text,
    {VoidCallback? onTap,
    double margin = dp0,
    int? maxLines,
    Color? subTitleColor,
    double? width,
    TextAlign textAlign = TextAlign.center}) {
  return Container(
    width: width,
    margin: EdgeInsets.only(left: margin, right: margin),
    child: InkWell(
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        presetFontSizes: [18, 16, 14],
        style: Get.theme.textTheme.headline4!.copyWith(color: subTitleColor),
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
      ),
      onTap: onTap,
    ),
  );
}

Widget textTitleMidForCode(
    {required String text,
    VoidCallback? onTap,
    double margin = dp10,
    double? width,
    int? maxLines = 1,
    Color? textColor}) {
  double? widthC = width == 0 ? Get.width : width;
  var style = textColor == null
      ? Get.theme.textTheme.headline2
      : Get.theme.textTheme.headline2!.copyWith(color: textColor);
  return Container(
    margin: EdgeInsets.only(left: margin, right: margin),
    width: widthC,
    child: InkWell(
      child: Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    ),
  );
}

Widget textTitleMidBold(String text,
    {VoidCallback? onTap, double margin = dp10, int? maxLines}) {
  return Container(
    //margin: EdgeInsets.only(left: margin, right: margin),
    child: InkWell(
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        presetFontSizes: [18, 16, 14],
        overflow: TextOverflow.ellipsis,
        style: Get.theme.textTheme.headline4!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    ),
  );
}

Widget textTitleMidNormal(
    String title, double fontSize, TextAlign textAlign, Color? textColor,
    {VoidCallback? onTap, double margin = dp10, int? maxLines}) {
  return Container(
    //margin: EdgeInsets.only(left: margin, right: margin),
    child: InkWell(
      child: AutoSizeText(
        title,
        textAlign: textAlign,
        maxLines: maxLines,
        presetFontSizes: [16, 14, 12],
        overflow: TextOverflow.ellipsis,
        style: Get.theme.textTheme.headline4!
            .copyWith(fontSize: fontSize, color: textColor),
      ),
      onTap: onTap,
    ),
  );
}

Widget textTitleMidWhiteOfflineText(String text,
    {VoidCallback? onTap, double margin = dp10, int? maxLines}) {
  return Container(
    margin: EdgeInsets.only(left: margin, right: margin),
    child: InkWell(
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        presetFontSizes: [26, 22, 18],
        overflow: TextOverflow.ellipsis,
        style: Get.theme.textTheme.headline2!
            .copyWith(color: white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    ),
  );
}

Widget textTitleBigWhite(String text,{VoidCallback? onTap, int? maxLines}) {
  return Container(
    child: InkWell(
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        presetFontSizes: [25, 20, 16],
        overflow: TextOverflow.ellipsis,
        style: Get.theme.textTheme.headline2!
            .copyWith(color: white, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    ),
  );
}

Widget textTitleMidWhite(String text,{VoidCallback? onTap, int? maxLines}) {
  return Container(
    child: InkWell(
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        presetFontSizes: [18, 14, 12],
        overflow: TextOverflow.ellipsis,
        style: Get.theme.textTheme.headline2!
            .copyWith(color: white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    ),
  );
}

Widget textTitleSmallWhite(String text,{VoidCallback? onTap, int? maxLines}) {
  return Container(
    child: InkWell(
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        presetFontSizes: [18, 14, 12],
        overflow: TextOverflow.ellipsis,
        style:
            Get.theme.textTheme.headline2!.copyWith(color: white, fontSize: 15),
      ),
      onTap: onTap,
    ),
  );
}

Widget textTitleMidWhiteSubtitle(String text,
    {VoidCallback? onTap, double? margin, int? maxLines}) {
  return Container(
    margin: EdgeInsets.only(left: margin!, right: margin),
    child: InkWell(
      child: AutoSizeText(
        text,
        presetFontSizes: [18, 14, 12],
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: Get.theme.textTheme.bodyText2!.copyWith(
            color: white, fontSize: 14, fontWeight: FontWeight.normal),
      ),
      onTap: onTap,
    ),
  );
}

Widget textTitleMidGreySubtitle(String text,
    {VoidCallback? onTap, double margin = dp10, int? maxLines}) {
  return Container(
    margin: EdgeInsets.only(left: margin, right: margin),
    child: InkWell(
      child: AutoSizeText(
        text,
        presetFontSizes: [18, 14, 12],
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: Get.theme.textTheme.bodyText2,
      ),
      onTap: onTap,
    ),
  );
}

Widget textTitleSmall(String text,
    {VoidCallback? onTap,
    double margin = dp10,
    TextAlign textAlign: TextAlign.center,
    bool isBold = true}) {
  return Container(
    margin: EdgeInsets.only(left: margin, right: margin),
    child: InkWell(
      child: Text(
        text,
        style: isBold
            ? Get.theme.textTheme.headline5
            : Get.theme.textTheme.headline6,
        textAlign: textAlign,
      ),
      onTap: onTap,
    ),
  );
}

Widget textUnderLineSuccess(
    {required String text,
    VoidCallback? onTap,
    double margin = dp10,
    int? maxLines,
    Color color = white}) {
  return Container(
    margin: EdgeInsets.only(left: margin, right: margin),
    child: InkWell(
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        presetFontSizes: [14, 12],
        style: Get.theme.textTheme.bodyText1!
            .copyWith(color: kGreenColor, decoration: TextDecoration.underline),
      ),
      onTap: onTap,
    ),
  );
}

Widget textUnderLineRejected(
    {required String text,
    VoidCallback? onTap,
    double margin = dp10,
    int? maxLines,
    Color color = white}) {
  return Container(
    margin: EdgeInsets.only(left: margin, right: margin),
    child: InkWell(
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        presetFontSizes: [14, 12],
        style: Get.theme.textTheme.bodyText1!
            .copyWith(color: kRedColor, decoration: TextDecoration.underline),
      ),
      onTap: onTap,
    ),
  );
}

Widget textTitleItemUnderLine(String text,
    {double margin = dp10, int? maxLines}) {
  return Container(
    margin: EdgeInsets.only(left: margin, right: margin),
    child: AutoSizeText(
      text,
      presetFontSizes: [16, 14, 12],
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: Get.theme.textTheme.headline3!.copyWith(color: white),
    ),
  );
}

Widget textSubtitleDetails(String text,
    {TextAlign? textAlign, double margin = dp10, int? maxLines}) {
  return Container(
    margin: EdgeInsets.only(left: margin, right: margin, top: margin / 2),
    child: AutoSizeText(
      text,
      textAlign: textAlign,
      presetFontSizes: [18, 14, 12],
      overflow: TextOverflow.ellipsis,
      style: Get.theme.textTheme.subtitle1,
      maxLines: maxLines,
    ),
  );
}

Widget textBodyText(String text,
    {TextAlign? textAlign,
    double margin = dp10,
    bool isBold = true,
    double opacity = 1}) {
  return Container(
    margin: EdgeInsets.only(left: margin, right: margin),
    child: Opacity(
      opacity: opacity,
      child: Text(
        text,
        textAlign: textAlign,
        style: isBold
            ? Get.theme.textTheme.bodyText1
            : Get.theme.textTheme.bodyText2,
      ),
    ),
  );
}

Widget textAccent(String text,
    {TextAlign? textAlign,
    double margin = dp10,
    int? maxLines = 1,
    double fontSize = dp14}) {
  return Container(
    margin: EdgeInsets.only(
      left: margin,
      right: margin,
    ),
    child: Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.roboto(
          color: Get.theme.colorScheme.secondary,
          fontSize: fontSize,
          fontWeight: FontWeight.normal),
      maxLines: maxLines,
    ),
  );
}

// Widget textSpan(String main, String clickAble, VoidCallback onTap,
//     {int? maxLines}) {
//   return AutoSizeText.rich(
//     TextSpan(
//       text: main,
//       style: Get.textTheme.subtitle1,
//       children: <TextSpan>[
//         TextSpan(text: "  "),
//         TextSpan(
//             text: clickAble,
//             style: Get.textTheme.headline2,
//             recognizer: TapGestureRecognizer()..onTap = onTap),
//       ],
//     ),
//     maxLines: maxLines,
//   );
// }

Widget textSpanNumberMinute(
    {String? main,
    String? textLittle,
    VoidCallback? onTap,
    int? maxLines,
    Color? textColor}) {
  return AutoSizeText.rich(
    TextSpan(
      text: main,
      style: Get.textTheme.headline1!.copyWith(fontSize: 30, color: textColor),
      children: <TextSpan>[
        TextSpan(text: "  "),
        TextSpan(
            text: textLittle,
            style: Get.textTheme.headline1!
                .copyWith(fontSize: 13, color: textColor),
            recognizer: TapGestureRecognizer()..onTap = onTap),
      ],
    ),
    maxLines: maxLines,
  );
}

Widget textSpanWithUnderline(String main, String clickAble, VoidCallback onTap,
    {int? maxLines}) {
  return AutoSizeText.rich(
    TextSpan(
      text: main,
      style: Get.textTheme.subtitle1!
          .copyWith(decoration: TextDecoration.underline),
      children: <TextSpan>[
        TextSpan(text: "  "),
        TextSpan(
            text: clickAble,
            style: Get.textTheme.subtitle1!
                .copyWith(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()..onTap = onTap),
      ],
    ),
    maxLines: maxLines,
  );
}

Widget textBody(String text,
    {TextAlign? textAlign, double margin = dp10, int? maxLines}) {
  return Container(
    margin: EdgeInsets.only(left: margin, right: margin, top: margin / 2),
    child: AutoSizeText(
      text,
      textAlign: textAlign,
      presetFontSizes: [20, 18, 16],
      overflow: TextOverflow.ellipsis,
      style: Get.theme.textTheme.bodyText1,
      maxLines: maxLines,
    ),
  );
}
