import 'package:cPocket/data/models/profile/user_club_infos.dart';
import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/utils/image_util.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileViewPage extends StatefulWidget {
  final User user;
  final UserClubInfo userClubInfo;

  const ProfileViewPage(
      {Key? key, required this.user, required this.userClubInfo})
      : super(key: key);

  @override
  _ProfileViewPageState createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  //MyProfileController _controller = Get.put(MyProfileController());
  //final RootController _rootPageController = Get.find<RootController>();
  User user = Get.find<RootController>().userRx.value;
  UserClubInfo userClubInfo = Get.find<RootController>().userClubInfoRx.value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCommonBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBarWithBack(title: "Profile".tr, hideRightIcon: true),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: dp15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VSpacer20(),
                    Container(
                      //padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
                      decoration: getRoundSoftTransparentBox(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VSpacer20(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: dp0, horizontal: dp15),
                            child: Row(
                              children: [
                                viewProfilePhoto(widget.user),
                                HSpacer50(),
                                // imageViewWithCircleBox(
                                //     imagePath:
                                //     widget.userClubInfo.planImage!
                                //   //_rootPageController.userClubInfoRx.value.planImage
                                // ),
                                //     Obx(() {
                                //       return stringNullCheck(userClubInfo.planImage).isEmpty
                                //           ? Container()
                                //           : imageViewWithCircleBox(
                                //               imagePath: widget.userClubInfo.planImage
                                //               //_rootPageController.userClubInfoRx.value.planImage
                                //               );
                                //     }),
                                stringNullCheck(userClubInfo.planImage).isEmpty
                                    ? Container()
                                    : imageViewWithCircleBox(
                                    imagePath: widget.userClubInfo.planImage
                                  //_rootPageController.userClubInfoRx.value.planImage
                                ),
                              ],
                            ),
                          ),
                          VSpacer20(),
                          horizontalDivider(),
                          VSpacer10(),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: dp0, horizontal: dp15),
                              child: textAutoSize(getUserName(user),
                                  textAlign: TextAlign.left)),
                          VSpacer10(),
                          horizontalDivider(),
                          VSpacer10(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: dp0, horizontal: dp15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                textBodyBold14(text: "Email : ".tr),
                                textBodyNormal14(text: stringNullCheck(user.email)),
                              ],
                            ),
                          ),
                          VSpacer10(),
                          horizontalDivider(),
                          VSpacer10(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: dp0, horizontal: dp15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                textBodyBold14(text: "Plan Name : ".tr),
                                //textBodyNormal14(text: "Gold"),
                                // Obx(() {
                                //   return stringNullCheck(userClubInfo.planName).isEmpty
                                //       ? textBodyNormal14(text: "Default".tr)
                                //       : textBodyNormal14(
                                //       text: userClubInfo.planName!);
                                // }),
                                stringNullCheck(userClubInfo.planName).isEmpty
                                    ? textBodyNormal14(text: "Default".tr)
                                    : textBodyNormal14(
                                    text: userClubInfo.planName!),
                              ],
                            ),
                          ),
                          VSpacer10(),
                          horizontalDivider(),
                          VSpacer10(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: dp0, horizontal: dp15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                textBodyBold14(text: "Blocked Coin : ".tr),
                                // Obx((){
                                //   return  textBodyNormal14(text: userClubInfo.blockedCoin.toString());
                                // }),
                                textBodyNormal14(
                                    text: userClubInfo.blockedCoin.toString()),
                              ],
                            ),
                          ),
                          VSpacer20(),
                        ],
                      ),
                    ),
                    VSpacer20(),
                    textBodyBold16(text: "Profile Information".tr),
                    VSpacer20(),
                    textAutoSize("Name".tr, fontSize: dp14),
                    textFieldBorderedWithSuffixIcon(
                        null, getUserName(widget.user), TextInputType.name,
                        isEnable: false),
                    VSpacer10(),
                    textAutoSize("Country".tr, fontSize: dp14),
                    textFieldBorderedWithSuffixIcon(
                        null,
                        stringNullCheck(widget.user.country),
                        TextInputType.name,
                        isEnable: false),
                    VSpacer10(),
                    textAutoSize("Email Address".tr, fontSize: dp14),
                    textFieldBorderedWithSuffixIcon(null,
                        stringNullCheck(widget.user.email), TextInputType.name,
                        isEnable: false),
                    VSpacer10(),
                    textAutoSize("Email Verification".tr, fontSize: dp14),
                    textFieldBorderedWithSuffixIcon(
                        null,
                        getVerificationStatus(widget.user.isVerified),
                        TextInputType.name,
                        isEnable: false),
                    VSpacer10(),
                    textAutoSize("Phone".tr, fontSize: dp14),
                    textFieldBorderedWithSuffixIcon(null,
                        stringNullCheck(widget.user.phone), TextInputType.name,
                        isEnable: false),
                    VSpacer10(),
                    textAutoSize("Role".tr, fontSize: dp14),
                    textFieldBorderedWithSuffixIcon(
                        null, "User".tr, TextInputType.name,
                        isEnable: false),
                    VSpacer10(),
                    textAutoSize("Active status".tr, fontSize: dp14),
                    textFieldBorderedWithSuffixIcon(null,
                        getUserStatus(widget.user.status), TextInputType.name,
                        isEnable: false),
                    VSpacer10(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:cPocket/data/models/profile/user_club_infos.dart';
// import 'package:cPocket/data/models/user.dart';
// import 'package:cPocket/ui/features/root/root_controller.dart';
// import 'package:cPocket/utils/image_util.dart';
// import 'package:cPocket/utils/text_field_util.dart';
// import 'package:cPocket/utils/view_utils/colors.dart';
// import 'package:cPocket/utils/view_utils/common_image_methods.dart';
// import 'package:cPocket/utils/view_utils/common_utils.dart';
// import 'package:cPocket/utils/view_utils/common_widget.dart';
// import 'package:cPocket/utils/constants.dart';
// import 'package:cPocket/utils/view_utils/custom_appbar.dart';
// import 'package:cPocket/utils/view_utils/text_utils.dart';
// import 'package:cPocket/utils/view_utils/decorations.dart';
// import 'package:cPocket/utils/view_utils/dimens.dart';
// import 'package:cPocket/utils/view_utils/edit_text.dart';
// import 'package:cPocket/utils/view_utils/spacers.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// import '../my_profile_controller.dart';
//
// class ProfileViewPage extends StatefulWidget {
//   final User user;
//   final UserClubInfo userClubInfo;
//
//   const ProfileViewPage(
//       {Key? key, required this.user, required this.userClubInfo})
//       : super(key: key);
//
//   @override
//   _ProfileViewPageState createState() => _ProfileViewPageState();
// }
//
// class _ProfileViewPageState extends State<ProfileViewPage> {
//   //MyProfileController _controller = Get.put(MyProfileController());
//   final RootController _rootPageController = Get.find<RootController>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kCommonBackgroundColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             buildAppBarWithBack(title: "Profile".tr, hideRightIcon: true),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(horizontal: dp15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     VSpacer20(),
//                     Container(
//                       //padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
//                       decoration: getRoundTransparentBox(),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           VSpacer20(),
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: dp0, horizontal: dp15),
//                             child: Row(
//                               children: [
//                                 viewProfilePhoto(widget.user),
//                                 HSpacer50(),
//                                 // imageViewWithCircleBox(
//                                 //     imagePath:
//                                 //     widget.userClubInfo.planImage!
//                                 //   //_rootPageController.userClubInfoRx.value.planImage
//                                 // ),
//                                 Obx(() {
//                                   return stringNullCheck(_rootPageController.userClubInfoRx.value.planImage).isEmpty
//                                       ? Container()
//                                       : imageViewWithCircleBox(
//                                       imagePath: widget.userClubInfo.planImage!
//                                     //_rootPageController.userClubInfoRx.value.planImage
//                                   );
//                                 }),
//                               ],
//                             ),
//                           ),
//                           VSpacer20(),
//                           horizontalDivider(),
//                           VSpacer10(),
//                           Container(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: dp0, horizontal: dp15),
//                               child: textAutoSize(
//                                   getUserName(_rootPageController.userRx.value),
//                                   textAlign: TextAlign.left)),
//                           VSpacer10(),
//                           horizontalDivider(),
//                           VSpacer10(),
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: dp0, horizontal: dp15),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 textBodyBold14(text: "Email".tr),
//                                 textBodyNormal14(
//                                     text: stringNullCheck(_rootPageController
//                                         .userRx.value.email)),
//                               ],
//                             ),
//                           ),
//                           VSpacer10(),
//                           horizontalDivider(),
//                           VSpacer10(),
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: dp0, horizontal: dp15),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 textBodyBold14(text: "Plan Name".tr),
//                                 //textBodyNormal14(text: "Gold"),
//                                 Obx(() {
//                                   return stringNullCheck(_rootPageController.userClubInfoRx.value.planName).isEmpty
//                                       ? textBodyNormal14(text: "Default".tr)
//                                       : textBodyNormal14(
//                                       text: _rootPageController
//                                           .userClubInfoRx.value.planName!);
//                                 }),
//                               ],
//                             ),
//                           ),
//                           VSpacer10(),
//                           horizontalDivider(),
//                           VSpacer10(),
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: dp0, horizontal: dp15),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 textBodyBold14(text: "Blocked Coin".tr),
//                                 Obx((){
//                                   return  textBodyNormal14(text: _rootPageController.userClubInfoRx.value.blockedCoin.toString());
//                                 }),
//                               ],
//                             ),
//                           ),
//                           VSpacer20(),
//                         ],
//                       ),
//                     ),
//                     VSpacer20(),
//                     textBodyBold16(text: "Profile Information".tr),
//                     VSpacer20(),
//                     textAutoSize("Name".tr, fontSize: dp14),
//                     textFieldBorderedWithSuffixIcon(
//                         null, getUserName(widget.user), TextInputType.name,
//                         isEnable: false),
//                     VSpacer10(),
//                     textAutoSize("Country".tr, fontSize: dp14),
//                     textFieldBorderedWithSuffixIcon(
//                         null,
//                         stringNullCheck(widget.user.country),
//                         TextInputType.name,
//                         isEnable: false),
//                     VSpacer10(),
//                     textAutoSize("Email Address".tr, fontSize: dp14),
//                     textFieldBorderedWithSuffixIcon(null,
//                         stringNullCheck(widget.user.email), TextInputType.name,
//                         isEnable: false),
//                     VSpacer10(),
//                     textAutoSize("Email Verification".tr, fontSize: dp14),
//                     textFieldBorderedWithSuffixIcon(
//                         null,
//                         getVerificationStatus(widget.user.isVerified),
//                         TextInputType.name,
//                         isEnable: false),
//                     VSpacer10(),
//                     textAutoSize("Phone".tr, fontSize: dp14),
//                     textFieldBorderedWithSuffixIcon(null,
//                         stringNullCheck(widget.user.phone), TextInputType.name,
//                         isEnable: false),
//                     VSpacer10(),
//                     textAutoSize("Role".tr, fontSize: dp14),
//                     textFieldBorderedWithSuffixIcon(
//                         null, "User".tr, TextInputType.name,
//                         isEnable: false),
//                     VSpacer10(),
//                     textAutoSize("Active status".tr, fontSize: dp14),
//                     textFieldBorderedWithSuffixIcon(null,
//                         getUserStatus(widget.user.status), TextInputType.name,
//                         isEnable: false),
//                     VSpacer10(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
