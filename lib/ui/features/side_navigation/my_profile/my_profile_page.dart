import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/ui/features/side_navigation/my_profile/phone_verification/send_code_page.dart';
import 'package:cPocket/ui/features/side_navigation/my_profile/profile_view/profile_view_page.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/alert_dialog_util.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/toast_utils.dart';
import 'edit_profile/edit_profile_page.dart';
import 'id_verification/id_verification_page.dart';
import 'my_profile_controller.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final RootController _rootPageController = Get.find<RootController>();

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
                    Obx(() {
                      return viewProfilePhotoWithName(
                          _rootPageController.userRx.value);
                    }),
                    VSpacer20(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        imageViewWithRoundedBoxWithText(
                            iconPath: AssetConstants.ic_big_profile,
                            text: 'Profile'.tr,
                            onPressCallback: () {
                              Get.to(() => ProfileViewPage(
                                    user: _rootPageController.userRx.value,
                                    userClubInfo: _rootPageController.userClubInfoRx.value,
                                  ));
                            }),
                        imageViewWithRoundedBoxWithText(
                            iconPath: AssetConstants.ic_edit,
                            text: 'Edit Profile'.tr,
                            onPressCallback: () {
                              /// Enable below line if you have purchased (remove '//' to enable)
                              // Get.to(() => EditProfilePage());
                              ToastUtil.showToast("demo_version_text".tr, isError: true); /// Delete this line if you have purchased
                            }),
                      ],
                    ),
                    VSpacer20(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          String? phone =
                              _rootPageController.userRx.value.phone;
                          int? phoneVerified =
                              _rootPageController.userRx.value.phoneVerified;
                          return imageViewWithRoundedBoxWithText(
                              iconPath: AssetConstants.ic_call,
                              text: 'Phone verification'.tr,
                              onPressCallback: () {
                                if (phone == null || phone.isEmpty) {
                                  alertForNoPhoneNumber();
                                } else if (phoneVerified == null ||
                                    phoneVerified == 0) {
                                  Get.to(() => SendCodePage(
                                      user: _rootPageController.userRx.value));
                                } else {
                                  showToast("Your phone number has already verified".tr);
                                }
                              });
                        }),
                        imageViewWithRoundedBoxWithText(
                            iconPath: AssetConstants.ic_document,
                            text: 'ID Verification'.tr,
                            onPressCallback: () {
                              Get.to(() => IdVerificationPage());
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Future getImage() async {
//   final pickedFile =
//       await ImagePicker().getImage(source: ImageSource.gallery);
//   if (pickedFile != null) {
//     _controller.profileImage.value = File(pickedFile.path);
//   }
// }
}
