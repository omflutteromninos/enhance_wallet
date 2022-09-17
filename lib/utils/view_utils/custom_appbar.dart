import 'package:auto_size_text/auto_size_text.dart';
import 'package:cPocket/ui/features/notifications/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'colors.dart';
import '../../data/local/constants.dart';
import 'custom_buttons.dart';
import 'text_utils.dart';
import 'decorations.dart';
import 'dimens.dart';


// Widget appBarMain(BuildContext context, {String title,
//   VoidCallback rightIconAction, String rightIconPath}) {
//   return AppBar(
//     centerTitle: true,
//     backgroundColor: Colors.transparent,
//     leading: IconButton(
//       icon: SvgPicture.asset(AssetConstants.ic_category),
//       onPressed: (){
//        // widget.openMenuButton(context);
//         Scaffold.of(context).openDrawer();
//       },
//     ),
//     elevation: 0.0,
//     title: Text(title, style: TextStyle(color: kAccentColor, fontWeight: FontWeight.bold)),
//     actions: [
//       IconButton(
//         icon: SvgPicture.asset(rightIconPath),
//         onPressed: (){
//           rightIconAction;
//         },
//       ),
//     ],
//   );
// }

// AppBar appBar;
// double appBarHeight = appBar.preferredSize.height;

Widget appBarMain(BuildContext context,
    {String? title, VoidCallback? rightIconAction, String? rightIconPath}) {
  return Container(
    padding: EdgeInsets.only(left: dp0, right: dp0),
    height: kToolbarHeight,
    child: Row(
      children: [
        appBarMenuIcon(context),
        Expanded(child: textNormalCenter22(text: title!, maxLines: 1)),
        rightIconPath!.isNotEmpty
            ? buttonOnlyIcon2(onPressCallback: rightIconAction, iconPath: rightIconPath,size: dp25)
            : Container(
                width: dp25,
              ),
      ],
    ),
  );
}

Widget buildAppBarWithBack({String? title, bool hideRightIcon = false}) {
  return Container(
    padding: EdgeInsets.only(left: dp0, right: dp0),
    height: kToolbarHeight,
    child: Row(
      children: [
        buttonOnlyIcon2(onPressCallback: () {
          Get.back();
        }, iconPath: AssetConstants.ic_arrow_left, size: dp25),
        Expanded(child: textNormalCenter22(text: title!)),
        hideRightIcon
            ? Container(width: dp25)
            : buttonOnlyIcon2(onPressCallback: () {
                 Get.to(() =>NotificationsPage());
              }, iconPath: AssetConstants.ic_notification),
      ],
    ),
  );
}

//
// bool status = false;
// Widget appBarMainWithSwitch(BuildContext context, String title,
//     VoidCallback rightIconAction, String rightIconPath) {
//   return Container(
//     padding: EdgeInsets.only(left: dp15, right: dp20),
//     height: dp80,
//     child: Row(
//       children: [
//         appBarMenuIcon(context),
//         Expanded(
//             child:
//                 textTitleLarge(title, Get.theme.primaryColorDark, maxLines: 1)),
//         Container(
//           child: FlutterSwitch(
//             width: 125.0,
//             height: 55.0,
//             valueFontSize: 25.0,
//             toggleSize: 45.0,
//             value: status,
//             borderRadius: 30.0,
//             padding: 8.0,
//             showOnOff: true,
//             onToggle: (val) {
//               setState(() {
//                 status = val;
//               });
//             },
//           ),
//         ),
//         //getSwitchOnlineOffline(rightIconAction, iconPath: rightIconPath)
//
//       ],
//     ),
//   );
// }

Widget appBarProfile(BuildContext context, String title,
    VoidCallback rightIconAction, String rightIconPath) {
  return Container(
    padding: EdgeInsets.only(left: dp15, right: dp20),
    height: dp80,
    child: Row(
      children: [
        appBarMenuIcon(context),
        Expanded(child: textNormalCenter22(text: title, maxLines: 1)),
        rightIconPath.isNotEmpty
            ? buttonOnlyIcon2(onPressCallback: rightIconAction, iconPath: rightIconPath)
            : Container(
                width: dp25,
              ),
      ],
    ),
  );
}

Widget appBarWithBack(String title) {
  return Container(
    padding: EdgeInsets.only(left: dp15, right: dp20),
    height: dp80,
    child: Row(
      children: [
        appBarMenuIconBlack(),
        Expanded(child: textNormalCenter22(text: title, maxLines: 1)),
        Container(
          width: dp25,
        ),
      ],
    ),
  );
}

Widget appBarWithoutSlideNav(BuildContext context, String title,
    VoidCallback rightIconAction, String rightIconPath) {
  return Container(
    padding: EdgeInsets.only(left: dp15, right: dp20),
    height: dp80,
    child: Row(
      children: [
/*        Container(
          height: dp50,
          width: dp50,
          padding: EdgeInsets.all(8),
          decoration: getRoundCornerBoxWhite(),
          child: buttonOnlyIcon(onPressCallback: () {
            Scaffold.of(context).openDrawer();
          }, iconPath: AssetConstants.ic_menu, size: dp25),
        ),*/
        Expanded(child: textNormalCenter22(text: title)),
        rightIconPath.isNotEmpty
            ? buttonOnlyIcon2(onPressCallback: rightIconAction, iconPath: rightIconPath)
            : Container(
                width: dp25,
              ),
      ],
    ),
  );
}

Widget buildAppBarLanding(String title, BuildContext context) {
  return Container(
    height: dp50,
    child: Row(
      children: [
        buttonOnlyIcon2(onPressCallback: () {
          Scaffold.of(context).openDrawer();
        }, iconPath: AssetConstants.ic_menu),
        Expanded(child: textNormalCenter22(text: title)),
        buttonOnlyIcon2(onPressCallback: () {
          //Get.to(() =>NotificationsPage());
        }, iconPath: AssetConstants.ic_notification),
      ],
    ),
  );
}

Widget tabBarText(TabController tabController, List<Widget> tabs) {
  return Container(
    decoration: decorationBottomBorder(),
    margin: EdgeInsets.only(left: dp15, right: dp15),
    child: TabBar(
      controller: tabController,
      labelStyle: Get.textTheme.headline3,
      unselectedLabelStyle: Get.textTheme.subtitle1,
      indicatorColor: Get.theme.primaryColorDark,
      tabs: tabs,
    ),
  );
}

Tab tabTextUnderline(String title) {
  return Tab(
    child: Container(
      child: Align(
        alignment: Alignment.center,
        child: AutoSizeText(title),
      ),
    ),
  );
}
