import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/utils/image_util.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/alert_dialog_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

import 'settings_controller.dart';

class SettingsPage extends StatefulWidget {
  final User user;

  const SettingsPage({Key? key, required this.user}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsController _controller = Get.put(SettingsController());

  @override
  void initState() {
    super.initState();
    _controller.isGoogleAuthActive.value = widget.user.g2FEnabled == 1;
    _controller.google2faSecret.value = widget.user.google2FaSecret ?? "";
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.getSettings(widget.user.language ?? DefaultValue.languageKey);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kCommonBackgroundColor,
        body: SafeArea(
            child: Column(children: [
          buildAppBarWithBack(title: "Settings".tr, hideRightIcon: false),
          VSpacer20(),
          Expanded(
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: dp15),
                  child: Column(
                    children: [
                      textAutoSize("Google Authentication Settings".tr,
                          fontSize: dp16, fontWeight: FontWeight.bold),
                      VSpacer20(),
                      googleAuthenticationIconBox(
                          iconPath:
                              AssetConstants.ic_google_authenticator_logo_png),
                      //iconWithTap(AssetConstants.ic_google_authenticator, size: Get.width / 2),
                      VSpacer20(),
                      Obx(() {
                        String title = _controller.google2faSecret.value.isEmpty
                            ? "Set Up".tr
                            : "Remove".tr;
                        return buttonRoundedMain(
                            text: title,
                            onPressCallback: () {
                              if (_controller.google2faSecret.value.isEmpty) {
                                showModalSheetFullScreen(
                                    showGoogleAuthyAddView(), context,
                                    onClose: () {
                                  _controller.codeEditController.text = "";
                                });
                              } else {
                                showModalSheetFullScreen(
                                    showGoogleAuthyRemoveView(), context,
                                    onClose: () {
                                  _controller.codeEditController.text = "";
                                });
                              }
                            });
                      }),
                      VSpacer20(),
                      textAutoSize("enable two factor authentication".tr,
                          fontSize: dp14,
                          fontWeight: FontWeight.w100,
                          maxLines: 3),
                      VSpacer20(),
                      Obx(() {
                        return switchOnOff(_controller.isGoogleAuthActive.value,
                            (value) {
                          _controller.enableDisable2FALogin();
                        });
                      }),
                      VSpacer20(),
                      textAutoSize("Preference Settings".tr,
                          fontSize: dp16, fontWeight: FontWeight.bold),
                      VSpacer20(),
                      textAutoSize("Language settings".tr,
                          fontSize: dp14,
                          fontWeight: FontWeight.w100,
                          maxLines: 1),
                      VSpacer10(),
                      Obx(() {
                        return dropDownList(
                            _controller.getLanguageList(),
                            _controller.selectedLanguage.value,
                            "Select Language".tr, (value) {
                          _controller.selectedLanguage.value = value;
                        });
                      }),
                      VSpacer20(),
                      buttonRoundedMain(
                          text: "Update".tr,
                          onPressCallback: () {
                            _controller.saveLanguage();
                          }),
                      VSpacer20(),
                    ],
                  )))
        ])));
  }

  Widget showGoogleAuthyAddView() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: dp10, horizontal: dp10),
      margin: const EdgeInsets.symmetric(vertical: dp16, horizontal: dp16),
      decoration: boxDecorationRoundCorner(),
      child: Column(
        children: [
          const SizedBox(height: dp10),
          showImage(stringNullCheck(_controller.settingsData?.qrcode),
              size: dp120),
          VSpacer10(),
          textAutoSize("Google Authenticator app info message".tr,
              fontSize: dp12,
              fontWeight: FontWeight.w100,
              maxLines: 3,
              textAlign: TextAlign.center),
          VSpacer10(),
          textAutoSize("Code".tr,
              fontSize: dp10, fontWeight: FontWeight.normal),
          textFieldBorderedWithSuffixIcon(_controller.codeEditController,
              "Your Code".tr, TextInputType.number),
          VSpacer10(),
          buttonRoundedFill("Verify".tr, () {
            _controller.verifyGoogleCode();
          }),
        ],
      ),
    );
  }

  Widget showGoogleAuthyRemoveView() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: dp10, horizontal: dp10),
      margin: const EdgeInsets.symmetric(vertical: dp16, horizontal: dp16),
      decoration: boxDecorationRoundCorner(),
      child: Column(
        children: [
          const SizedBox(height: dp20),
          iconWithTap(AssetConstants.ic_google_authenticator,
              size: Get.width / 4),
          const SizedBox(height: dp20),
          textAutoSize("Google Authenticator remove message".tr,
              fontSize: dp12,
              fontWeight: FontWeight.w100,
              maxLines: 3,
              textAlign: TextAlign.center),
          const SizedBox(height: dp10),
          textAutoSize("Code".tr,
              fontSize: dp10, fontWeight: FontWeight.normal),
          textFieldBorderedWithSuffixIcon(_controller.codeEditController,
              "Your Code".tr, TextInputType.number),
          const SizedBox(height: dp10),
          buttonRoundedFill("Remove".tr, () {
            _controller.verifyGoogleCode();
          }),
        ],
      ),
    );
  }
}
