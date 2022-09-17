import 'dart:io';
import 'dart:ui';
import 'package:cPocket/data/models/buy_coin/buy_coin_and_phase_information.dart';
import 'package:cPocket/data/models/buy_coin/buy_coin_history.dart';
import 'package:cPocket/data/models/general_settings.dart';
import 'package:cPocket/data/models/membership/all_membership_plans.dart';
import 'package:cPocket/data/models/membership/membership_bonus_history.dart';
import 'package:cPocket/data/models/send_receive_pending_coin/coin_history_response.dart';
import 'package:cPocket/data/models/my_refferal.dart';
import 'package:cPocket/data/models/notification/app_notification_response.dart';
import 'package:cPocket/data/models/profile/user_club_infos.dart';
import 'package:cPocket/data/models/swap_coin/swap_coin_history.dart';
import 'package:cPocket/data/models/transaction.dart';
import 'package:cPocket/data/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../image_util.dart';
import 'alert_dialog_util.dart';
import 'colors.dart';
import '../../data/local/constants.dart';
import 'common_image_methods.dart';
import 'common_utils.dart';
import 'custom_buttons.dart';
import 'text_utils.dart';
import 'decorations.dart';
import 'dimens.dart';

Widget viewTopLogoText({String? title, String? subTitle}) {
  return SizedBox(
    height: dp200,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        imageView(imagePath: AssetConstants.ic_logo, height: dp90, width: dp90),
        VSpacer15(),
        textAutoSize(stringNullCheck(title),
            textAlign: TextAlign.center, fontSize: dp24),
        VSpacer10(),
        textAutoSize(stringNullCheck(subTitle),
            textAlign: TextAlign.center,
            fontSize: dp14,
            fontWeight: FontWeight.normal),
      ],
    ),
  );
}

Widget viewProfilePhotoWithName(User user) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      showCircleAvatar(stringNullCheck(user.photo)),
      VSpacer15(),
      textAutoSize("Welcome_user_name".trParams({"name": getUserName(user)})),
    ],
  );
}

Widget viewProfilePhoto(User user) {
  return showCircleAvatar(stringNullCheck(user.photo));
}

Widget viewClubPlanPhoto(UserClubInfo userClubInfo) {
  return showCircleAvatar(stringNullCheck(userClubInfo.planImage));
}

Widget viewClubPlanPhoto2(UserClubInfo userClubInfos) {
  return imageView(imagePath: stringNullCheck(userClubInfos.planImage));
}
//
// Widget listTitleWithLeftIconRightArrow(
//     String title, String iconPath1, String iconPath2, VoidCallback action,
//     {Color? iconColor}) {
//   return Container(
//     //height: dp50,
//     //color: Colors.blue,
//     child: InkWell(
//       onTap: action,
//       child: Row(
//         children: [
//           Align(
//               alignment: Alignment.centerLeft,
//               child: buttonOnlyIcon(
//                   onPressCallback: action, iconPath: iconPath1, size: dp18)),
//           Expanded(child: textTitleMid(title)),
//           Row(
//             //crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               buttonOnlyIcon(
//                   onPressCallback: action,
//                   iconPath: iconPath2,
//                   size: dp15,
//                   iconColor: iconColor)
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }

// Widget faqBox({
//   String? titleText,
//   String? expandedText,
//   VoidCallback? action,
// }) {
//   return Container(
//     decoration: getRoundSoftTransparentBox(),
//     child: ExpansionTile(
//       title: textBodyBold16(text: titletext, maxLines: 1),
//       backgroundColor: Colors.transparent,
//       collapsedIconColor: kThemeTextColor,
//       collapsedBackgroundColor: Colors.transparent,
//       iconColor: kThemeTextColor,
//       tilePadding: EdgeInsets.only(left: dp10),
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: dp10),
//           child: Column(
//             children: [
//               VSpacer10(),
//               textBodyNormal14(text: expandedtext, maxLines: 2),
//               VSpacer10(),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

Widget dropDownList(List<String> items, String selectedValue, String hint,
    Function(String value) onChange,
    {double? width}) {
  double widthL = width ?? Get.width - 80;
  return Container(
    margin: const EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 5),
    padding: const EdgeInsets.only(left: 15, top: 0, right: 5, bottom: 0),
    //padding: const EdgeInsets.symmetric(horizontal: 10),
    height: 50,
    width: Get.width,
    decoration: boxDecorationRoundBorder(
        color: Get.theme.primaryColorDark.withOpacity(0.5)),
    child: DropdownButton<String>(
      value: selectedValue.isEmpty ? null : selectedValue,
      hint: textAutoSize(hint,
          fontSize: dp12, color: Get.theme.primaryColor, width: widthL),
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      elevation: 10,
      dropdownColor: kLightTextFieldColor,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      style: Get.textTheme.subtitle1,
      underline: Container(height: dp0, color: Colors.transparent),
      menuMaxHeight: Get.height - 200,
      onChanged: (value) {
        onChange(value!);
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: textAutoSize(value,
              fontSize: dp12, color: Get.theme.primaryColor, width: widthL),
        );
      }).toList(),
    ),
  );
}

Widget dropDownList2(List<String> items, String selectedValue, String hint,
    Function(String value) onChange,
    {double? width}) {
  double widthL = width ?? Get.width - 105;
  return Container(
    margin: const EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 5),
    padding: const EdgeInsets.only(left: 12, top: 0, right: 5, bottom: 0),
    //padding: const EdgeInsets.symmetric(horizontal: 10),
    height: 50,
    width: Get.width,
    decoration: boxDecorationRoundBorder(
        color: Get.theme.primaryColorDark.withOpacity(0.5)),
    child: DropdownButton<String>(
      value: selectedValue.isEmpty ? null : selectedValue,
      hint: textAutoSize(hint,
          fontSize: dp12, color: Get.theme.primaryColor, width: widthL),
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      elevation: 10,
      dropdownColor: kLightTextFieldColor,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      style: Get.textTheme.subtitle1,
      underline: Container(height: dp0, color: Colors.transparent),
      menuMaxHeight: Get.height - 200,
      onChanged: (value) {
        onChange(value!);
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: textAutoSize(value,
              fontSize: dp12, color: Get.theme.primaryColor, width: widthL),
        );
      }).toList(),
    ),
  );
}

Widget switchOnOff(bool selectedValue, Function(bool) onChange,
    {double height = 30}) {
  return Row(
    children: [
      const SizedBox(
        width: dp10,
      ),
      FlutterSwitch(
        width: height * 2,
        height: height,
        valueFontSize: height / 2,
        toggleSize: height - 10,
        value: selectedValue,
        toggleColor: Get.theme.primaryColorDark,
        activeToggleColor: Get.theme.colorScheme.secondary,
        activeTextColor: Get.theme.primaryColorDark,
        inactiveTextColor: Get.theme.primaryColorDark,
        activeColor: Get.theme.primaryColor,
        inactiveColor: Get.theme.primaryColor,
        borderRadius: height / 2,
        padding: 3,
        showOnOff: true,
        activeText: "On".tr,
        inactiveText: "Off".tr,
        onToggle: (val) {
          onChange(val);
        },
      ),
    ],
  );
}

//
// Widget frontImageUploadRectangleBox({BuildContext? context,
//   String? iconPath,
//   VoidCallback? action,
// }) {
//   return InkWell(
//     onTap: () {
//       getImageWide(isGallery: false);
//       //showImageChooserWide(context);
//     },
//     child: Container(
//       alignment: Alignment.center,
//       width: Get.width,
//       height: dp170,
//       decoration: getRoundTransparentBox(),
//       child: Obx(() {
//         return Container(
//             alignment: Alignment.center,
//             width: Get.width,
//             height: dp170,
//             decoration: getRoundTransparentBoxWithServerImage(),
//             child: imageView(
//                 imagePath: AssetConstants.ic_upload, height: dp65));
//       }),
//     ),
//     //verificationBox(iconPath: AssetConstants.ic_upload),
//   );
// }
// Widget backImageUploadRectangleBox({
//   String? iconPath,
//   VoidCallback? action,
// }) {
//   return InkWell(
//     onTap: () {
//       getImageWide(isGallery: false);
//     },
//     child: Container(
//       alignment: Alignment.center,
//       width: Get.width,
//       height: dp170,
//       decoration: getRoundTransparentBox(),
//       child: Obx(() {
//         return Container(
//             alignment: Alignment.center,
//             width: Get.width,
//             height: dp170,
//             decoration: getRoundTransparentBoxWithServerImage(),
//             child: imageView(
//                 imagePath: AssetConstants.ic_upload, height: dp65));
//       }),
//     ),
//     //verificationBox(iconPath: AssetConstants.ic_upload),
//   );
// }

Widget verificationBox({
  String? iconPath,
  VoidCallback? action,
}) {
  return InkWell(
    onTap: action,
    child: Container(
        width: Get.width,
        height: dp170,
        padding: EdgeInsets.symmetric(vertical: dp50),
        decoration: getRoundSoftTransparentBox(),
        child: imageView(imagePath: iconPath!)),
  );
}
// Widget verificationBoxNidFrontServerImage({
//   String? iconPath,
//   VoidCallback? action,
// }) {
//   return InkWell(
//     onTap: action,
//     child: Container(
//         width: Get.width,
//         height: dp170,
//         padding: EdgeInsets.symmetric(vertical: dp50),
//         decoration: getRoundTransparentBoxWithNidServerImage(),
//         child: imageView(imagePath: iconPath!)),
//   );
// }

Widget googleAuthenticationIconBox({
  String? iconPath,
  VoidCallback? action,
}) {
  return InkWell(
    onTap: action,
    child: Container(
        alignment: Alignment.center,
        width: dp200,
        height: dp200,
        //padding: EdgeInsets.symmetric(vertical: dp50),
        decoration: getRoundSoftTransparentBox(),
        child: imageView(imagePath: iconPath!)),
  );
}

// Widget listTitleSelectLanguage(String title, String subTitle, String iconPath1,
//     String iconPath2, VoidCallback action) {
//   return Container(
//     // height: dp50,
//     //color: Colors.blue,
//     child: InkWell(
//       onTap: action,
//       child: Row(
//         children: [
//           Align(
//               alignment: Alignment.centerLeft,
//               child: buttonOnlyIcon(
//                   onPressCallback: action, iconPath: iconPath1, size: dp18)),
//           Expanded(child: textTitleMid(title)),
//           Row(
//             //crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               subTitle.isNotEmpty
//                   ? Opacity(
//                       opacity: 0.3,
//                       child: textTitleMid(subTitle, margin: dp0),
//                     )
//                   : Container(),
//               buttonOnlyIcon(
//                   onPressCallback: action, iconPath: iconPath2, size: dp15)
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }

Widget listTitleWithLeftIcon(
    String title, String iconPath, Color color, VoidCallback action,
    {Color? iconColor}) {
  return Container(
    //height: dp50,
    child: InkWell(
      onTap: action,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buttonOnlyIcon2(
              onPressCallback: action,
              iconPath: iconPath,
              size: dp18,
              iconColor: iconColor),
          textBodyNormal16(text: title, maxLines: 1),
        ],
      ),
    ),
  );
}

Widget listTitleWithLeftIconExpansionTile({
  String? title,
  String? menu1,
  String? menu2,
  String? menu3,
  String? menu4,
  String? iconPath,
  VoidCallback? actionMenu1,
  VoidCallback? actionMenu2,
  VoidCallback? actionMenu3,
  VoidCallback? actionMenu4,
}) {
  return ExpansionTile(
    title: Row(
      children: [
        imageView(imagePath: iconPath!, width: dp18),
        HSpacer15(),
        textBodyNormal16(text: title!, maxLines: 1),
      ],
    ),
    collapsedIconColor: kThemeTextColor,
    iconColor: kAccentColorOrange,
    childrenPadding: EdgeInsets.symmetric(horizontal: dp0),
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: dp60),
        child: Column(
          children: [
            textButton(text: menu1!, onPressCallback: actionMenu1!),
            VSpacer10(),
            textButton(text: menu2!, onPressCallback: actionMenu2!),
            VSpacer10(),
            textButton(text: menu3!, onPressCallback: actionMenu3!),
            VSpacer10(),
            textButton(text: menu4!, onPressCallback: actionMenu4!),
          ],
        ),
      ),
    ],
  );
}

Widget listTitleWithArrow(String title, String iconPath, VoidCallback action) {
  return Container(
    height: dp50,
    //color: Colors.blue,
    child: InkWell(
      onTap: action,
      child: Row(
        children: [
          Expanded(child: textTitleMid(title)),
          buttonOnlyIcon2(
              onPressCallback: action, iconPath: iconPath, size: dp20)
        ],
      ),
    ),
  );
}

Widget genderList(
    {String? title,
    String iconPath2 = "",
    VoidCallback? action,
    Color? subTitleColor}) {
  return Container(
    padding: EdgeInsets.only(left: dp10, right: dp10),
    height: dp50,
    decoration: decorationRoundCornerBorder(),
    child: InkWell(
      onTap: action,
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title!.isNotEmpty
              ? textBodyBold14(
                  text: title,
                )
              : Container(),
          //buttonOnlyIcon(onPressCallback: action, iconPath: iconPath2, size: dp15)
          iconPath2.isNotEmpty
              ? Icon(
                  Icons.keyboard_arrow_down,
                  size: dp20,
                  color: kThemeTextColor,
                )
              : HSpacer15(),
        ],
      ),
    ),
  );
}

Widget listTitleWithRightCancelIcon(
    String title, String subTitle, String iconPath2, VoidCallback action) {
  return Container(
    padding: EdgeInsets.all(16),
    //height: 70,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: textTitleMidWhite(title, maxLines: 2),
            ),
            InkWell(
              onTap: action,
              child: SvgPicture.asset(
                iconPath2,
                width: 15,
                color: white,
              ),
            ),
          ],
        ),
        VSpacer5(),
        Align(
          alignment: Alignment.centerLeft,
          child: textTitleSmallWhite(subTitle, maxLines: 2),
        ),
      ],
    ),
  );
}

Widget listTitleWithRightCancelIconWithTopIcon(
    {String? title,
    String? subTitle,
    String? iconPathTop,
    String? iconPath2,
    VoidCallback? action}) {
  return Container(
    padding: EdgeInsets.all(16),
    //height: 70,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: action,
            child: SvgPicture.asset(
              iconPath2!,
              width: 15,
              color: white,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: imageView(
            imagePath: iconPathTop!,
            width: 60,
          ),
        ),
        VSpacer10(),
        Align(
          alignment: Alignment.centerLeft,
          child: textTitleBigWhite(title!, maxLines: 2),
        ),
        VSpacer5(),
        Align(
          alignment: Alignment.centerLeft,
          child: textTitleSmallWhite(subTitle!, maxLines: 2),
        ),
        VSpacer20(),
      ],
    ),
  );
}

Widget rightCancelIcon(String iconPath2, VoidCallback action) {
  return ListTile(
    trailing: InkWell(
      onTap: () {
        Get.back();
      },
      child: SvgPicture.asset(
        iconPath2,
        width: 15,
        color: white,
      ),
    ),
  );
}

Widget tagView(
    List<String> list, List<int> selectedIndexes, Function(int index) onSelect,
    {bool isSingleItem = true}) {
  print("tagView list $list");
  bool _startDirection = true;
  bool _horizontalScroll = false;
  return Tags(
    ///heightHorizontalScroll: 60 * (_fontSize / 14),
    // itemCount: list.length-1, // to hide Credit card view
    itemCount: list.length,
    alignment: WrapAlignment.start,
    spacing: 0,
    runSpacing: 0,
    // textDirection: TextDirection.ltr,
    // direction: Axis.vertical,
    // horizontalScroll: _horizontalScroll,
    // verticalDirection: _startDirection ? VerticalDirection.up : VerticalDirection.down,
    itemBuilder: (index) {
      final item = list[index];
      return ItemTags(
        key: Key(index.toString()),
        index: index,
        title: item,
        pressEnabled: true,
        alignment: MainAxisAlignment.start,
        border: Border.all(color: Colors.transparent),
        elevation: 0,
        color: Colors.transparent,
        textColor: Get.theme.primaryColor,
        activeColor: Colors.transparent,
        singleItem: isSingleItem,
        splashColor: Colors.transparent,
        combine: ItemTagsCombine.withTextAfter,
        image: selectedIndexes.contains(index)
            ? ItemTagsImage(
                child: SvgPicture.asset(
                AssetConstants.icTickSquare,
                color: Colors.green,
                width: 22,
              ))
            : ItemTagsImage(
                child: SvgPicture.asset(
                AssetConstants.icBoxSquare,
                color: Get.theme.primaryColor,
                width: 22,
              )),

        /// icon: index == selectedIndex ? ItemTagsIcon(icon: Icons.check_box,)
        ///     : ItemTagsIcon(icon: Icons.check_box_outline_blank,),
        ///textScaleFactor: utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
        textStyle: Get.textTheme.bodyText1!
            .copyWith(fontWeight: FontWeight.w100, fontSize: 14),
        onPressed: (item) {
          onSelect(item.index!);
        },
      );
    },
  );
}

// Widget imageView(
//     {String imagePath = "",
//     double? iconWidthSize,
//     double? iconHeightSize,
//     VoidCallback? onPressCallback,
//     Color? iconColor}) {
//   return InkWell(
//     onTap: onPressCallback,
//     child: Container(
//       // width: widthSize,
//       // height: heightSize,
//       child: imagePath.isNotEmpty
//           ? imagePath.contains(".svg")
//               ? SvgPicture.asset(
//                   imagePath,
//                   fit: BoxFit.contain,
//                   width: iconWidthSize,
//                   height: iconHeightSize,
//                   color: iconColor,
//                 )
//               : Image.asset(
//                   imagePath,
//                   fit: BoxFit.contain,
//                   width: iconWidthSize,
//                   height: iconHeightSize,
//                 )
//           : Container(),
//     ),
//   );
// }

Widget tradingScriptView() {
  return Container(
    height: dp50,
    //alignment: Alignment.center,
    width: Get.width,
    //color: Get.theme.primaryColorDark.withOpacity(0.2),
    padding: const EdgeInsets.only(top: 5),
    child: WebView(
      initialUrl: "",
      javascriptMode: JavascriptMode.unrestricted,
      zoomEnabled: false,
      onWebViewCreated: (WebViewController webViewController) async {
        webViewController
            .loadUrl(await htmlString(Platform.isAndroid ? AssetConstants.pathHtmlTrading : AssetConstants.pathHtmlTradingIos));
      },
    ),
  );

  ///textMarquee(),
}

Widget imageViewWithRoundedBoxWithText({
  required String text,
  String? iconPath,
  double? iconWidthSize,
  double? iconHeightSize,
  VoidCallback? onPressCallback,
}) {
  return InkWell(
    onTap: onPressCallback,
    child: Container(
      // width:dp140,
      // height: dp140,
      width: Get.width / 2.3,
      height: Get.width / 2.3,
      padding: EdgeInsets.symmetric(vertical: dp15, horizontal: dp15),
      decoration: getRoundTransparentBoxWithBorderRadius20(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageView(
              imagePath: iconPath!,
              width: iconWidthSize,
              height: iconHeightSize),
          VSpacer25(),
          textBodyNormal16(text: text, textAlign: TextAlign.center)
        ],
      ),
    ),
  );
}

Widget iconViewWithRoundedBoxWithText(
    {String? text,
    IconData? icon,
    VoidCallback? onPressCallback,
    Color? iconColor,
    double? iconSize}) {
  return InkWell(
    onTap: onPressCallback,
    child: Container(
       padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 1),
      height: 18,
      decoration: boxDecorationRoundBorder(
          color: Get.theme.primaryColor.withOpacity(0.15),radius: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon!,
            size: iconSize,
            color: iconColor,
          ),
          HSpacer5(),
          textSubtitleNormalFor12(text: text!,textColor: Colors.white),
          //textAutoSize(text!, fontSize: 12, fontWeight: FontWeight.w100,width: 50)
        ],
      ),
    ),
  );
}

Widget iconView(
    {IconData? icon,
    VoidCallback? onPressCallback,
    Color? iconColor,
    double? iconSize}) {
  return InkWell(
    onTap: onPressCallback,
    child: Icon(
      icon!,
      size: iconSize,
      color: iconColor,
    ),
  );
}

// Widget featuredItem({bool isFavorite = false}) {
//   return Container(
//     decoration: getRoundCornerBox(),
//     alignment: Alignment.center,
//     margin: EdgeInsets.all(dp10),
//     height: dp120,
//     child: InkWell(
//       onTap: (){
//         Get.to(() =>ProductDetailsPage());
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Stack(
//             children: [
//               isFavorite
//                   ? Positioned(
//                   right: 0,
//                   child: SvgPicture.asset(
//                     AssetConstants.ic_favorite_fill,
//                     color: Get.theme.colorScheme.secondary,
//                   ))
//                   : Spacer(),
//               Image.asset(AssetConstants.img_item_demo,
//                   width: dp80, height: dp80, fit: BoxFit.cover),
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               textSubtitle("Hotel & House",
//                   textAlign: TextAlign.start, margin: 0),
//               textTitleMid("Khan Housing Apartment", margin: 0),
//               textSubtitle("12 Mar,Wed, 4.30 pm",
//                   textAlign: TextAlign.start, margin: 0),
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }

// Widget buildSearchBox() {
//   return Container(
//       margin: EdgeInsets.only(left: dp15, top: dp10, right: dp15, bottom: dp10),
//       height: dp60,
//       child: TextField(
//         decoration: InputDecoration(
//           filled: false,
//           hintText: "Search your item".tr,
//           hintStyle: TextStyle(color: Colors.grey),
//           suffixIcon: InkWell(
//             onTap: () {},
//             child: Padding(
//                 padding: EdgeInsets.all(dp10),
//                 child: SvgPicture.asset(
//                   AssetConstants.ic_search,
//                   color: kAccentTextColorDark,
//                 )),
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(dp10),
//             borderSide: BorderSide(
//               width: dp1,
//               style: BorderStyle.solid,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Get.theme.colorScheme.secondary),
//             borderRadius: BorderRadius.circular(dp10),
//           ),
//         ),
//       ));
// }

Widget buildCustomDivider() {
  return Container(
    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
    child: Divider(
      height: 1,
      color: dividerColor,
      thickness: 2,
    ),
  );
}

Widget horizontalDivider({Color color = kDivider2, double margin = 0}) {
  return Container(
    margin: EdgeInsets.only(left: margin, right: margin),
    child: Divider(
      height: 1,
      color: color,
      thickness: 1,
    ),
  );
}

Widget buildCustomDividerTwoButton() {
  return Container(
    padding: EdgeInsets.all(0),
    child: Divider(
      height: 1,
      color: dividerColor3,
      thickness: 1,
    ),
  );
}

void openUrlInBrowser(String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    throw "Could not launch $url";
}

Widget getCountry(
    {double? width, String? initialValue, ValueChanged<String>? onChanged}) {
  String initialSelection = DefaultValue.country;
  if (initialValue != null && initialValue.isNotEmpty) {
    initialSelection = initialValue;
  }
  return Container(
    //margin: EdgeInsets.all(dp10),
    padding: EdgeInsets.only(left: dp0, right: dp10),
    height: dp50,
    width: width,
    decoration: decorationRoundCornerBorder(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CountryCodePicker(
          showFlag: false,
          showCountryOnly: true,
          initialSelection: initialSelection,
          textStyle: Get.theme.textTheme.bodyText2,
          showOnlyCountryWhenClosed: true,
          onInit: (value) {},
          onChanged: (value) {
            onChanged!(value.name!);
          },
        ),
        Icon(
          Icons.keyboard_arrow_down,
          size: dp20,
          color: kThemeTextColor,
        ),
      ],
    ),
  );
}

Widget selectCarCustomListTile(
  BuildContext context,
  //String iconPath,
  VoidCallback onPressCallback,
  String title,
  String subTitle,
  String amount, {
  String iconPath = "",
}) {
  return Container(
    height: 80,
    padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
    child: InkWell(
      onTap: onPressCallback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: imageView(imagePath: iconPath),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: textTitleMidNormal(
                          title, dp18, TextAlign.left, black),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: textTitleMidNormal(
                          amount, dp18, TextAlign.right, black),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: textTitleMidNormal(
                        subTitle, dp16, TextAlign.left, black)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget myTripsCustomListTile(
  BuildContext context,
  //String iconPath,
  VoidCallback onPressCallback,
  String title,
  String subTitle,
  String amount, {
  String iconPath = "",
}) {
  return Container(
    height: 80,
    padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
    child: InkWell(
      onTap: onPressCallback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: imageView(imagePath: iconPath),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: textTitleMidNormal(
                          title, dp18, TextAlign.left, black),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: textTitleMidNormal(
                          amount, dp18, TextAlign.right, black),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: textTitleMidNormal(
                        subTitle, dp16, TextAlign.left, black)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customListTileWithoutIcon(
  BuildContext context,
  VoidCallback onPressCallback,
  String title,
  String subTitle,
  String amount,
) {
  return Container(
    height: 50,
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: InkWell(
      onTap: onPressCallback,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: textTitleMidNormal(title, dp18, TextAlign.left, black),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child:
                      textTitleMidNormal(amount, dp18, TextAlign.right, black),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.topLeft,
                child:
                    textTitleMidNormal(subTitle, dp16, TextAlign.left, black)),
          ),
        ],
      ),
    ),
  );
}

Widget twoTextItem(String title, String? value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        title,
        style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700),
      ),
      Text(
        stringNullCheck(value),
        style: Get.textTheme.bodyText1!
            .copyWith(fontWeight: FontWeight.w100, fontSize: dp12),
      ),
    ],
  );
}

Widget qrView(String data, {Color backgroundColor = Colors.transparent}) {
  return QrImage(
    data: data,
    version: QrVersions.auto,
    backgroundColor: Colors.white,
    size: dp150,
  );
}

Widget notificationItemView(AppNotificationResponse appNotificationResponse) {
  return InkWell(
    onTap: () {
      notificationItemExpandView(appNotificationResponse, buttonAction: () {
        Get.back();
      });
    },
    child: Container(
      //decoration: getRoundCornerBox(color: white),
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: dp10, right: dp15),
      height: dp100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 1,
              child: imageView(imagePath: AssetConstants.ic_notification2)),
          // CircleAvatar(
          //   radius: 40,
          //   backgroundImage: AssetImage(AssetConstants.ic_notification1),
          // ),
          HSpacer5(),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //width: Get.width - dp130,
                  child: textAutoSize(
                      // text: "Nunc rutrum amet vitae morbi pellentesque at praesent soda les turp is turpis.",
                      stringNullCheck(appNotificationResponse.title),
                      maxLines: 1,
                      fontSize: dp14,
                      fontWeight: FontWeight.bold),
                ),
                VSpacer10(),
                // textSubtitle1(
                //   //text: "2 Hour ago",
                //   text: appNotificationResponse.createdAt.toString(),
                //   margin: 0,
                // ),

                textSubtitle1(
                    text: formatDate(appNotificationResponse.createdAt,
                        format: dateTimeFormatYyyyMMDdHhMm),
                    margin: 0),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget depositItem() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp10),
    //height: dp200,
    child: InkWell(
      onTap: () {
        //Get.to(() =>BuyCoinHistoryDetailsPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Address : "),
              VSpacer5(),
              textBodyNormal14(text: "2NCzoqbY7CXitVwwiNDq9MqvjDJV4DcBj3Q"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Amount : "),
              textBodyNormal14(text: "12.000078"),
            ],
          ),
          VSpacer5(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Tran. Hash : "),
              VSpacer5(),
              textBodyNormal14(text: "2NCzoqbY7CXitVwwiNDq9MqvjDJV4DcBj3Q"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Status : "),
              textUnderLineSuccess(text: "Success"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Created At : "),
              textBodyNormal14(text: "2021-01-24  12:50:17"),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget withdrawItem() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp10),
    //height: dp200,
    child: InkWell(
      onTap: () {
        //Get.to(() =>BuyCoinHistoryDetailsPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Address : "),
              VSpacer5(),
              textBodyNormal14(text: "2NCzoqbY7CXitVwwiNDq9MqvjDJV4DcBj3Q"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Amount : "),
              textBodyNormal14(text: "12.000078"),
            ],
          ),
          VSpacer5(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Tran. Hash : "),
              VSpacer5(),
              textBodyNormal14(text: "2NCzoqbY7CXitVwwiNDq9MqvjDJV4DcBj3Q"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Status : "),
              textUnderLineRejected(text: "Rejected"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Created At : "),
              textBodyNormal14(text: "2021-01-24  12:50:17"),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget allDepositAndWithdrawItem() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp10),
    //height: dp200,
    child: InkWell(
      onTap: () {
        //Get.to(() =>BuyCoinHistoryDetailsPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Address : "),
              VSpacer5(),
              textBodyNormal14(text: "2NCzoqbY7CXitVwwiNDq9MqvjDJV4DcBj3Q"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Amount : "),
              textBodyNormal14(text: "12.000078"),
            ],
          ),
          VSpacer5(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Tran. Hash : "),
              VSpacer5(),
              textBodyNormal14(text: "2NCzoqbY7CXitVwwiNDq9MqvjDJV4DcBj3Q"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Status : "),
              textUnderLineSuccess(text: "Success"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Created At : "),
              textBodyNormal14(text: "2021-01-24  12:50:17"),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget transactionItem(DepositOrWithdraw transaction) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp5),
    width: Get.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textAutoSize("Address_colon".tr,
            fontSize: 14, fontWeight: FontWeight.w700, lineHeight: 1.9),
        VSpacer2(),
        textAutoSize(stringNullCheck(transaction.address),
            fontSize: 12,
            fontWeight: FontWeight.w100,
            lineHeight: 1.3,
            maxLines: 2),
        VSpacer2(),
        textSpan("Amount_colon".tr, transaction.amount.toString()),
        VSpacer2(),
        textAutoSize("Tran_Hash_colon".tr,
            fontSize: 14, fontWeight: FontWeight.w700, lineHeight: 1.9),
        VSpacer2(),
        textAutoSize(stringNullCheck(transaction.transactionHash),
            fontSize: 12,
            fontWeight: FontWeight.w100,
            lineHeight: 1.3,
            maxLines: 2),
        VSpacer2(),
        textSpan("Status_colon".tr, getUserStatus(transaction.status),
            color: getStatusColor(transaction.status)),
        VSpacer2(),
        textSpan(
            "Created_At_colon".tr,
            formatDate(transaction.updatedAt,
                format: dateTimeFormatDdMMMMYyyyHhMm)),
      ],
    ),
  );
}

Widget referenceItem(Reference reference) {
  return Container(
    // padding: const EdgeInsets.all(dp10),
    // decoration: boxDecorationRoundCorner(color: Get.theme.primaryColorDark.withOpacity(0.5)),
    // margin: const EdgeInsets.symmetric(vertical: dp5, horizontal:dp10),
    // width: Get.width,
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp5),
    width: Get.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textSpan("Full_Name_colon".tr, stringNullCheck(reference.fullName)),
        VSpacer2(),
        textSpan("Email_colon".tr, stringNullCheck(reference.email)),
        VSpacer2(),
        textSpan("Level_colon".tr, stringNullCheck(reference.level)),
        VSpacer2(),
        textSpan(
            "Joining_Date_colon".tr,
            formatDate(reference.joiningDate,
                format: dateTimeFormatDdMMMMYyyyHhMm)),
        //const SizedBox(height: Dimens.dp2),
        //textSpan("Balance_colon".tr, stringNullCheck("20239.3497")),
      ],
    ),
  );
}

Widget earningItem(Earning earning) {
  var decoration = earning.yearMonth == null
      ? getTransparentGradientBoxWithTopRound()
      : getTransparentGradientBox();
  // ? boxDecorationTopRound(color: Get.theme.primaryColorDark.withOpacity(0.5), isGradient: true)
  // : boxDecoration(color: Get.theme.primaryColorDark.withOpacity(0.5), isGradient: true);
  var text1 = earning.yearMonth == null
      ? "Period".tr
      : stringNullCheck(earning.yearMonth);
  var text2 = earning.totalAmount == null
      ? "Commissions".tr
      : earning.totalAmount.toString();
  return Container(
    decoration: decoration,
    padding: const EdgeInsets.symmetric(vertical: dp10, horizontal: dp10),
    margin: const EdgeInsets.only(left: dp10, right: dp10),
    height: dp50,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: textAutoSize(text1,
                fontSize: dp12, textAlign: TextAlign.center)),
        Expanded(
            flex: 1,
            child: textAutoSize(text2,
                fontSize: dp12, textAlign: TextAlign.center)),
      ],
    ),
  );
}

Widget buyCoinHistoryItem(BuyCoinHistory buyCoinHistory) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp14, vertical: dp5),
    width: Get.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textAutoSize("Address_colon".tr,
            fontSize: 14, fontWeight: FontWeight.w700, lineHeight: 1.9),
        VSpacer2(),
        textAutoSize(stringNullCheck(buyCoinHistory.address),
            fontSize: 12,
            fontWeight: FontWeight.w100,
            lineHeight: 1.3,
            maxLines: 2),
        VSpacer5(),
        textSpan("Coin_amount_colon".tr, stringNullCheck(buyCoinHistory.coin)),
        VSpacer5(),
        textSpan(
            "Coin_name_colon".tr, stringNullCheck(buyCoinHistory.coinType)),
        VSpacer5(),
        textSpan(
            "Payment_Type_colon".tr, stringNullCheck(buyCoinHistory.coinType)),
        VSpacer5(),
        // textSpan("Status_colon".tr, getUserStatus(buyCoinHistory.status),
        //     color: getStatusColor(buyCoinHistory.status)),
        textSpan("Status_colon".tr, getUserStatusString(buyCoinHistory.status),
            color: getStatusColorString(buyCoinHistory.status)),
        // textSpan("Status_colon".tr, stringNullCheck(buyCoinHistory.status)),
        VSpacer5(),
        textSpan(
            "Created_At_colon".tr,
            formatDate(buyCoinHistory.updatedAt,
                format: dateTimeFormatDdMMMMYyyyHhMm)),
      ],
    ),
  );
}
// Widget buyCoinIcoPhaseItem(BuyCoinAndPhaseInformation buyCoinAndPhaseInformation) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       textBodyBold16(text: stringNullCheck(buyCoinAndPhaseInformation.activePhase.)),
//       VSpacer10(),
//       VSpacer2(),
//       // VSpacer5(),
//       // textSpan("Coin_amount_colon".tr, stringNullCheck(buyCoinHistory.coin)),
//       // VSpacer5(),
//       // textSpan("Status_colon".tr, getUserStatusString(buyCoinHistory.status),
//       //     color: getStatusColorString(buyCoinHistory.status)),
//       // // textSpan("Status_colon".tr, stringNullCheck(buyCoinHistory.status)),
//       // VSpacer5(),
//       // textSpan(
//       //     "Created_At_colon".tr,
//       //     formatDate(buyCoinHistory.updatedAt, format: dateTimeFormatDdMMMMYyyyHhMm)),
//     ],
//   );
// }

Widget horizontalBlackLine() {
  return Container(margin:EdgeInsets.symmetric(vertical: 6),height: 0.3,width: Get.width,color: Colors.black);
}

Widget IcoPhaseRunningRowItem({String? textLeft,String? textRight}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          textBodyNormal12(text: textLeft!),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          textBodyNormal12(text: textRight!),
        ],
      ),
    ],
  );
}
Widget swapCoinHistoryItem(SwapCoinHistory swapCoinHistory) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp14, vertical: dp5),
    width: Get.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textSpan("From_Wallet_colon".tr,
            stringNullCheck(swapCoinHistory.fromWalletName)),
        VSpacer5(),
        textSpan("To_Wallet_colon".tr,
            stringNullCheck(swapCoinHistory.toWalletName)),
        VSpacer5(),
        textSpan("Requested_Amount_colon".tr,
            stringNullCheck(swapCoinHistory.requestedAmountString)),
        VSpacer5(),
        textSpan("Converted_Amount_colon".tr,
            stringNullCheck(swapCoinHistory.convertedAmountString)),
        VSpacer5(),
        textSpan(
            "Rate_colon".tr, stringNullCheck(swapCoinHistory.rate.toString())),
        VSpacer5(),
        textSpan(
            "Created_At_colon".tr,
            formatDate(swapCoinHistory.updatedAt,
                format: dateTimeFormatDdMMMMYyyyHhMm)),
      ],
    ),
  );
}

Widget membershipPlanListItem(
    AllMembershipPlans allMembershipPlans, GeneralSettings generalSettings) {
  print(allMembershipPlans.image);
  return Container(
    width: Get.width,
    color: Colors.transparent,
    child: Column(
      children: [
        VSpacer20(),
        stringNullCheck(allMembershipPlans.image).isEmpty
            ? Container()
            : Container(
                decoration: getRoundCornerBorder(),
                padding: EdgeInsets.symmetric(horizontal: dp25, vertical: dp15),
                child: imageViewNetwork(imagePath: allMembershipPlans.image),
              ),
        VSpacer20(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     textBodyBold14(text: "Plan Name".tr),
        //     Center(child: textBodyBold14(text: ":")),
        //     Align(
        //         alignment: Alignment.centerRight,
        //         child: textBodyBold14(
        //             text: stringNullCheck(allMembershipPlans.planName))),
        //   ],
        // ),
        membershipRowItem(
            planName: "Plan Name".tr,
            planNameValue: stringNullCheck(allMembershipPlans.planName)),
        VSpacer20(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     textBodyBold14(text: "Minimum Amount".tr),
        //     Center(child: textBodyBold14(text: ":")),
        //     textBodyBold14(
        //         text: allMembershipPlans.amount.toString() +
        //             " " +
        //             stringNullCheck(generalSettings.settings?.coinName)),
        //   ],
        // ),
        // VSpacer20(),
        membershipRowItem(
            planName: "Minimum Amount".tr,
            planNameValue: allMembershipPlans.amount.toString() +
                " " +
                stringNullCheck(generalSettings.settings?.coinName)),
        VSpacer20(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     textBodyBold14(text: "Minimum Duration".tr),
        //     Center(child: textBodyBold14(text: ":")),
        //     textBodyBold14(
        //         text: allMembershipPlans.duration.toString() + "days".tr),
        //   ],
        // ),
        // VSpacer20(),
        membershipRowItem(
            planName: "Minimum Duration".tr,
            planNameValue: allMembershipPlans.duration.toString() + "days".tr),
        VSpacer20(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     textBodyBold14(text: "Bonus Percentage".tr),
        //     Center(child: textBodyBold14(text: ":")),
        //     textBodyBold14(text: allMembershipPlans.bonus.toString() + " %"),
        //   ],
        // ),
        // VSpacer20(),
        membershipRowItem(
            planName: "Bonus Percentage".tr,
            planNameValue: allMembershipPlans.bonus.toString() + " %"),
        VSpacer20(),
        DottedLine(
          dashColor: kDivider,
        ),
      ],
    ),
  );
}

Widget membershipRowItem(
    {String? planName,
    String? planNameValue,
    AllMembershipPlans? allMembershipPlans,
    GeneralSettings? generalSettings}) {
  var width = Get.width / 3;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
          width: width,
          child: textBodyBold14(
              text: planName!,
              textAlign: TextAlign.left,
              alignment: Alignment.centerLeft)),
      SizedBox(
          width: 10,
          child: textBodyBold14(
              text: ":",
              textAlign: TextAlign.center,
              alignment: Alignment.center)),
      SizedBox(
          width: width,
          child: textBodyBold14(
              text: planNameValue!,
              textAlign: TextAlign.right,
              alignment: Alignment.centerRight)),
    ],
  );
}

Widget coinHistoryItem(CoinHistory coinHistory, String? name) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp5),
    width: Get.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textSpan("Sender_colon".tr,
            stringNullCheck(coinHistory.senderEmail.toString())),
        VSpacer5(),
        textSpan(
            "Receiver_colon".tr, stringNullCheck(coinHistory.receiverEmail)),
        VSpacer5(),
        textSpan("Coin_amount_colon".tr, coinHistory.amount.toString()),
        VSpacer5(),
        textSpan("Coin_name_colon".tr, stringNullCheck(name)),
        VSpacer5(),
        textSpan("Status_colon".tr, getUserStatus(coinHistory.status),
            color: getStatusColor(coinHistory.status)),
        VSpacer5(),
        textSpan(
            "Created_At_colon".tr,
            formatDate(coinHistory.updatedAt,
                format: dateTimeFormatDdMMMMYyyyHhMm)),
      ],
    ),
  );
}


Widget myMembershipBonusHistoryItem(
    MembershipBonusHistory membershipBonusHistory, String? email) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp5),
    width: Get.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textSpan(
            "Member_colon".tr,
            stringNullCheck(
                membershipBonusHistory.wallet!.user!.email.toString())),
        VSpacer5(),
        textSpan("Plan_name_colon".tr,
            stringNullCheck(membershipBonusHistory.planName)),
        VSpacer5(),
        textSpan("Wallet_name_colon".tr,
            stringNullCheck(membershipBonusHistory.walletName)),
        VSpacer5(),
        textSpan("Bonus_Amount_colon".tr,
            membershipBonusHistory.bonusAmount.toString()),
        VSpacer5(),
        textSpan("Coin_Type_colon".tr,
            stringNullCheck(membershipBonusHistory.bonusCoinType)),
        VSpacer5(),
        textSpan(
            "Status_colon".tr, getUserStatus(membershipBonusHistory.status),
            color: getStatusColor(membershipBonusHistory.status)),
        VSpacer5(),
        textSpan(
            "Date_colon".tr,
            formatDate(membershipBonusHistory.updatedAt,
                format: dateTimeFormatDdMMMMYyyyHhMm)),
      ],
    ),
  );
}

// Widget myMembershipBonusHistoryItem() {
//   return Container(
//     padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
//     decoration: getRoundSoftTransparentBox(),
//     margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp10),
//     //height: dp200,
//     child: InkWell(
//       onTap: () {
//         //Get.to(() =>BuyCoinHistoryDetailsPage());
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               textBodyBold14(text: "Member : "),
//               VSpacer5(),
//               textBodyNormal14(text: "user@email.com"),
//             ],
//           ),
//           VSpacer5(),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               textBodyBold14(text: "Plan Name : "),
//               textBodyNormal14(text: "Gold"),
//             ],
//           ),
//           VSpacer5(),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               textBodyBold14(text: "Wallet Name :  "),
//               textBodyNormal14(text: "N/A"),
//             ],
//           ),
//           VSpacer5(),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               textBodyBold14(text: "Bonus Amount : "),
//               textBodyNormal14(text: "0.00000000"),
//             ],
//           ),
//           VSpacer5(),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               textBodyBold14(text: "Coin Type : "),
//               textBodyNormal14(text: "BTC"),
//             ],
//           ),
//           VSpacer5(),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               textBodyBold14(text: "Status : "),
//               textBodyNormal14(text: "Activar"),
//             ],
//           ),
//           VSpacer5(),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               textBodyBold14(text: "Date : "),
//               textBodyNormal14(text: "2021-01-24"),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

Widget buyCoinHistoryItem1(Reference reference) {
  return Container(
    // padding: const EdgeInsets.all(dp10),
    // decoration: boxDecorationRoundCorner(color: Get.theme.primaryColorDark.withOpacity(0.5)),
    // margin: const EdgeInsets.symmetric(vertical: dp5, horizontal:dp10),
    // width: Get.width,
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp5),
    width: Get.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textSpan("Full_Name_colon".tr, stringNullCheck(reference.fullName)),
        VSpacer2(),
        textSpan("Email_colon".tr, stringNullCheck(reference.email)),
        VSpacer2(),
        textSpan("Level_colon".tr, stringNullCheck(reference.level)),
        VSpacer2(),
        textSpan(
            "Joining_Date_colon".tr,
            formatDate(reference.joiningDate,
                format: dateTimeFormatDdMMMMYyyyHhMm)),
        //const SizedBox(height: Dimens.dp2),
        //textSpan("Balance_colon".tr, stringNullCheck("20239.3497")),
      ],
    ),
  );
}

Widget myReferencesItem() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp10),
    //height: dp200,
    child: InkWell(
      onTap: () {
        //Get.to(() =>BuyCoinHistoryDetailsPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Full Name : "),
              VSpacer5(),
              textBodyNormal14(text: "Hessam Mahmud"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Email : "),
              textBodyNormal14(text: "itechsoftbd@gmail.com"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Level :  "),
              textBodyNormal14(text: "2"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Joining Date : "),
              textBodyNormal14(text: "2021-01-24  12:50:17"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Balance : "),
              textBodyNormal14(text: "90279.00000000"),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget sendHistoryItem() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp10),
    //height: dp200,
    child: InkWell(
      onTap: () {
        //Get.to(() =>BuyCoinHistoryDetailsPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Sender : "),
              VSpacer5(),
              textBodyNormal14(text: "user@email.com"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Receiver : "),
              VSpacer5(),
              textBodyNormal14(text: "itechsoftbd@gmail.com"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Coin Amount : "),
              textBodyNormal14(text: "5.00000000"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Coin Name : "),
              textBodyNormal14(text: "Ccoin"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Status : "),
              textBodyNormal14(text: "Accepted"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Created At : "),
              textBodyNormal14(text: "2021-01-24  12:50:17"),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget showPastAddressItem() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
    decoration: getRoundSoftTransparentBox(),
    margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp10),
    //height: dp200,
    child: InkWell(
      onTap: () {
        //Get.to(() =>BuyCoinHistoryDetailsPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Address : "),
              VSpacer5(),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "2NCzoqbY7CXitVwwiNDq9MqvjDJV4DcBj3Q"),
            ],
          ),
          VSpacer5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textBodyBold14(text: "Created At : "),
              textBodyNormal14(text: "2021-01-24  12:50:17"),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget myReferralsItem() {
  return Container(
    //padding: EdgeInsets.symmetric(vertical: dp0, horizontal: dp0),
    decoration: getTransparentGradientBox(),
    //margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp0),
    height: dp70,
    child: InkWell(
      onTap: () {
        //Get.to(() =>BuyCoinHistoryDetailsPage());
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          textBodyBold14(text: "100"),
          textBodyBold14(text: "70"),
          textBodyBold14(text: "9"),
        ],
      ),
    ),
  );
}

Widget myEarningsItem() {
  return Container(
    //padding: EdgeInsets.symmetric(vertical: dp0, horizontal: dp0),
    decoration: getTransparentGradientBox(),
    //margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp0),
    height: dp70,
    child: InkWell(
      onTap: () {
        //Get.to(() =>BuyCoinHistoryDetailsPage());
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          textBodyBold14(text: "2021-01-24"),
          textBodyBold14(text: "15.00000"),
        ],
      ),
    ),
  );
}

Widget myPocketListItem() {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: dp0, horizontal: dp10),
        decoration: getTransparentGradientBox(),
        //margin: EdgeInsets.symmetric(horizontal: dp15, vertical: dp0),
        height: dp70,
        child: InkWell(
          onTap: () {
            //Get.to(() =>BuyCoinHistoryDetailsPage());
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: textBodyBold14(text: "Default\nWallet")),
              Expanded(flex: 1, child: textBodyBold14(text: "34.00012\nBTC")),
              Expanded(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    imageView(imagePath: AssetConstants.ic_action_show),
                    imageView(imagePath: AssetConstants.ic_action_key),
                    imageView(
                        imagePath: AssetConstants.ic_action_wallet_deposit),
                    imageView(imagePath: AssetConstants.ic_action_withdraw),
                    imageView(
                        imagePath:
                            AssetConstants.ic_action_wallet_activity_log),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: dp0, horizontal: dp10),
        decoration: getTransparentGradientBox(),
        //margin: EdgeInsets.symmetric(horizontal: dp15, vertical: dp0),
        height: dp70,
        child: InkWell(
          onTap: () {
            //Get.to(() =>BuyCoinHistoryDetailsPage());
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(flex: 1, child: textBodyBold14(text: "ltc")),
              Expanded(flex: 1, child: textBodyBold14(text: "34.00012\nBTC")),
              Expanded(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    imageView(imagePath: AssetConstants.ic_action_show),
                    imageView(
                        imagePath: AssetConstants.ic_action_wallet_deposit),
                    imageView(imagePath: AssetConstants.ic_action_withdraw),
                    imageView(
                        imagePath:
                            AssetConstants.ic_action_wallet_activity_log),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: dp0, horizontal: dp10),
        decoration: getTransparentGradientBox(),
        //margin: EdgeInsets.symmetric(horizontal: dp15, vertical: dp0),
        height: dp70,
        child: InkWell(
          onTap: () {
            //Get.to(() =>BuyCoinHistoryDetailsPage());
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: textBodyBold14(text: "BTC")),
              Expanded(flex: 1, child: textBodyBold14(text: "34.00012\nBTC")),
              Expanded(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    imageView(imagePath: AssetConstants.ic_action_show),
                    imageView(
                        imagePath: AssetConstants.ic_action_wallet_deposit),
                    imageView(imagePath: AssetConstants.ic_action_withdraw),
                    imageView(
                        imagePath:
                            AssetConstants.ic_action_wallet_activity_log),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget emptyView() {
  return Center(
      child: textTitleSmall(
    "No Recent Activity Found".tr,
    isBold: false,
  ));
}

Widget handleEmptyViewWithLoadingNotification(
    {required bool isLoading, double? height, String? message}) {
  String _message = message == null ? "Sorry! Data not found".tr : message;
  return Container(
      margin: EdgeInsets.all(dp20),
      height: height,
      child: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Text(
                _message,
                style: Get.textTheme.headline3,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
      ));
}

Widget handleEmptyViewWithLoading(bool isLoading,
    {double height = 50, String? message}) {
  String _message = message ?? "Sorry! Data not found".tr;
  return Container(
      margin: const EdgeInsets.all(20),
      height: height,
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : textAutoSize(
                _message,
                maxLines: 2,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
              ),
      ));
}

Widget handleEmptyView(bool isDataLoaded, {double? height, String? message}) {
  String _message = message == null ? "Sorry! Data not found".tr : message;
  return Container(
      margin: EdgeInsets.all(dp20),
      height: height,
      child: Center(
        child: isDataLoaded
            ? Text(
                _message,
                style: Get.textTheme.headline2,
                maxLines: 2,
                textAlign: TextAlign.center,
              )
            : Text(""),
      ));
}

Widget getTitleSellAll({String? title, VoidCallback? action}) {
  return Container(
    //alignment: Alignment.center,
    //width: Get.width / 2.25,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textBodyBold16(text: title!),
        InkWell(onTap: action, child: textBodyNormal14(text: 'See All')),
      ],
    ),
  );
}

Widget getTopIconTitleWithSubtitle({
  String? iconPath,
  double? widthSize,
  double? heightSize,
  String? title,
  String? subtitle,
}) {
  return Container(
    alignment: Alignment.center,
    //width: Get.width / 2.25,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        imageView(imagePath: iconPath!, width: widthSize, height: heightSize),
        VSpacer10(),
        textTitleLargeMain(title!, 26, TextAlign.center, textColor4),
        VSpacer5(),
        textSubtitle1(text: subtitle!),
      ],
    ),
  );
}

Widget radioGroupString(
    List<String> list, String currentValue, Function(String value) onChanged) {
  return Container(
      margin: EdgeInsets.all(dp0),
      child: RadioGroup<String>.builder(
        direction: Axis.vertical,
        groupValue: currentValue,
        spacebetween: dp40,
        horizontalAlignment: MainAxisAlignment.start,
        onChanged: (value) => {onChanged(value!)},
        items: list,
        itemBuilder: (item) => RadioButtonBuilder(item),
      ));
}

// Widget showCircleAvatar(String url, {double size = dp90}) {
//   return ClipOval(
//     child: CachedNetworkImage(
//       imageUrl: url,
//       width: size,
//       height: size,
//       fit: BoxFit.cover,
//       placeholder: (context, url) =>
//           Image.asset(AssetConstants.img_not_available),
//       errorWidget: (context, url, error) =>
//           Image.asset(AssetConstants.img_not_available),
//     ),
//   );
// }

// Widget showCircleAvatarLocal(File file, {double size = dp90}) {
//   return ClipOval(
//       child: Image.file(
//     file,
//     width: size,
//     height: size,
//     fit: BoxFit.cover,
//   ));
// }

class CommonWidget extends StatefulWidget {
  @override
  _CommonWidgetState createState() => _CommonWidgetState();
}

class _CommonWidgetState extends State<CommonWidget> {
  String? dropdownDeliveryToValue;
  final List<String> dropdownNameList = <String>[
    '\$ Select',
    '\$ BTC',
    '\$ EURO',
    '\$ USD',
  ];

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget walletTypeFilter() {
    return Container(
      //margin: EdgeInsets.only(right: dp10),
      height: dp50,
      width: Get.width,
      decoration: getRoundTransparentBoxWithBorder(),
      child: DropdownButton<String>(
        value: dropdownDeliveryToValue == null
            ? dropdownNameList[0]
            : dropdownDeliveryToValue,
        icon: Icon(Icons.keyboard_arrow_down_outlined),
        elevation: 10,
        dropdownColor: kTextFieldColor,
        iconDisabledColor: kThemeTextColor,
        iconEnabledColor: kThemeTextColor,
        style: Get.textTheme.bodyText1,
        underline: Container(height: dp0, color: Colors.transparent),
        onChanged: (String? newValue) {
          setState(() {
            dropdownDeliveryToValue = newValue;
          });
        },
        items: dropdownNameList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              width: Get.width / 1.3,
              //decoration: getRoundTransparentBoxWithBorder(),
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: dp10),
              child: Container(
                  color: Colors.transparent,
                  child: Text(value, style: Get.textTheme.bodyText1)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
