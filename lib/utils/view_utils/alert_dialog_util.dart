import 'package:cPocket/data/models/notification/app_notification_response.dart';
import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/ui/features/auth/email_verify/email_verify_page.dart';
import 'package:cPocket/ui/features/side_navigation/my_profile/edit_profile/edit_profile_page.dart';
import 'package:cPocket/ui/features/side_navigation/settings/settings_page.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../image_util.dart';
import 'colors.dart';
import 'common_utils.dart';
import 'common_widget.dart';
import 'custom_buttons.dart';
import 'text_utils.dart';
import 'decorations.dart';

import 'dimens.dart';
import 'edit_text.dart';

void alertForVerifyAccount(String email) {
  Get.defaultDialog(
    title: "",
    radius: dp10,
    backgroundColor: Get.theme.primaryColorDark,
    content: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        textAutoSize("Need verification".tr,
            textAlign: TextAlign.center, fontSize: dp24),
        VSpacer10(),
        textAutoSize(
            "Your account is unverified. Please verify your account".tr,
            maxLines: 4,
            textAlign: TextAlign.center,
            fontSize: dp14,
            fontWeight: FontWeight.normal),
        VSpacer20(),
        buttonRoundedMain(
            text: "Verify".tr,
            onPressCallback: () {
              Get.back();
              Get.off(() => EmailVerifyPage(email));
            },
            width: Get.width / 2),
        VSpacer10(),
      ],
    ),
  );
}

void alertForNoPhoneNumber() {
  Get.defaultDialog(
      title: "",
      radius: dp10,
      backgroundColor: Get.theme.primaryColorDark,
      content: SizedBox(
        height: dp200,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            textAutoSize("Phone Verification".tr, textAlign: TextAlign.center),
            VSpacer10(),
            textAutoSize("verify_phone_alert_description".tr,
                maxLines: 3, textAlign: TextAlign.center, fontSize: dp12),
            VSpacer10(),
            buttonRoundedFill("Edit Profile".tr, () {
              Get.back();
              Get.to(() => const EditProfilePage());
            }, width: Get.width / 2)
          ],
        ),
      ));
}

changePhotoModalBottomSheet(VoidCallback onPress, VoidCallback onPress2,
        {double width = 0}) =>
    Get.bottomSheet(
      Container(
          alignment: Alignment.bottomCenter,
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buttonRoundedFill("Take a picture".tr, onPress,
                  width: width, bgColor: Get.theme.primaryColor),
              horizontalDivider(margin: (Get.width - width) / 2),
              buttonRoundedFill("Choose a picture".tr, onPress2,
                  width: width, bgColor: Get.theme.primaryColor),
              horizontalDivider(margin: (Get.width - width) / 2),
              buttonRoundedFill("Cancel".tr, () {
                Get.back();
              }, width: width, bgColor: Get.theme.primaryColor),
            ],
          )),
      isDismissible: true,
    );

void getAlertDialogAddPocket({VoidCallback? buttonAction}) {
  Get.defaultDialog(
    title: "Want to add new pocket?",
    titleStyle: Get.theme.textTheme.headline1,
    radius: dp10,
    backgroundColor: white.withOpacity(0.03),
    content: Container(
      height: Get.width / 2,
      width: Get.width,
      //padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
      decoration: getRoundSoftTransparentBox(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VSpacer20(),
          textBodyBold14(text: "Coin Amount"),
          VSpacer10(),
          textFieldBorderedMain(
              hintText: "Your Amount", textInputType: TextInputType.number, text: ''),
          VSpacer10(),
          textBodyBold14(text: "Select Your Wallet"),
          VSpacer10(),
          //_walletTypeFilter(),
          VSpacer10(),
        ],
      ),
    ),
  );
}

void notificationItemExpandView(AppNotificationResponse appNotificationResponse, {VoidCallback? buttonAction}) {
  Get.defaultDialog(
    title: '',
    titlePadding: EdgeInsets.all(0),
    titleStyle: TextStyle(fontSize: 0),
    contentPadding: EdgeInsets.all(dp10),
    radius: dp10,
    backgroundColor: Get.theme.primaryColorDark,
    content: Container(
      alignment: Alignment.center,
      height: Get.width / 2,
      width: Get.width,
      child: SingleChildScrollView(
        //padding: EdgeInsets.symmetric(horizontal: dp15),
        child: Column(
          children: [
            imageView(imagePath: AssetConstants.ic_notification2),
            VSpacer15(),
            Container(
              child: textBodyNormal14(
                  text: stringNullCheck(appNotificationResponse.title), maxLines: 3),
            ),
            VSpacer10(),
            Container(
              child: textBodyNormal14(
                  text: stringNullCheck(appNotificationResponse.notificationBody), maxLines: 30),
            ),
            VSpacer10(),
            Align(
              alignment: Alignment.centerRight,
              child: textSubtitle1(
                  text: formatDate(appNotificationResponse.createdAt,
                      format: dateTimeFormatYyyyMMDdHhMm),
                  margin: 0),
            )
          ],
        ),
      ),
    ),
  );
}

void showModalSheetFullScreen(Widget customView, BuildContext context,
    {Function? onClose}) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                buttonOnlyIcon(() {
                  Get.back();
                  if (onClose != null) {
                    onClose();
                  }
                }, iconPath: AssetConstants.ic_close_box, size: dp20)
              ],
            ),
            VSpacer15(),
            customView
          ],
        );
      });
}

Future _showExitDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.only(top: 00.0),
          content: Container(
            margin: const EdgeInsets.all(00),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      left: 0.0, top: 15.0, right: 0.0, bottom: 0.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Confirm Exit !',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Are you sure you want to Exit?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        color: Colors.grey[600],
                        width: double.infinity,
                        height: 0.3,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                print('Cancel');
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: 0.3,
                            height: 40,
                            color: Colors.grey[600],
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () async {
                                print('Exit');
                                Navigator.pop(context);
                                SystemNavigator.pop();
                              },
                              child: Text(
                                'Exit',
                                style: TextStyle(color: Colors.red[600]),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

void alertForSet2FA(User user) {
  Get.defaultDialog(
    title: "",
    radius: dp10,
    backgroundColor: Get.theme.primaryColorDark,
    content: SizedBox(
      height: dp200,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          textAutoSize("Need activation".tr, textAlign: TextAlign.center),
          const SizedBox(height: dp10),
          textAutoSize("Your need to activate the two-factor verification for future process".tr,
              maxLines: 2, textAlign: TextAlign.center, fontSize: dp12),
          const SizedBox(height: dp10),
          buttonRoundedFill("Activate".tr, () {
            Get.back();
            Get.off(() => SettingsPage(user: user));
          }, width: Get.width / 2)
        ],
      ),
    ),
  );
}