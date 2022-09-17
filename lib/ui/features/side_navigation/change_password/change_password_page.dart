import 'dart:io';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/edit_text.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'change_password_controller.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  ChangePasswordPageController _controller =
      Get.put(ChangePasswordPageController());

  @override
  void dispose() {
    _controller.clearInputData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCommonBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBarWithBack(
                title: "Change Password".tr, hideRightIcon: false),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: dp15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VSpacer20(),
                    textBodyBold14(text: "Current Password".tr),
                    VSpacer10(),
                    textFieldBorderedWithSuffixIcon(
                        _controller.currentPassEditController,
                        "**********",
                        TextInputType.visiblePassword,
                        isObscure: false),
                    VSpacer20(),
                    textAutoSize("New Password".tr, fontSize: dp14),
                    VSpacer10(),
                    Obx(() {
                      return textFieldBorderedWithSuffixIcon(
                          _controller.passEditController, "**********", TextInputType.visiblePassword,
                          iconPath: _controller.isShowPassword.value
                              ? AssetConstants.ic_password_show
                              : AssetConstants.ic_password_hide,
                          isObscure: !_controller.isShowPassword.value, iconAction: () {
                        _controller.isShowPassword.value = !_controller.isShowPassword.value;
                      });
                    }),
                    VSpacer20(),
                    //textBodyBold14(text: "Confirm Password".tr),
                    textAutoSize("Confirm Password".tr, fontSize: dp14),
                    VSpacer10(),
                    Obx(() {
                      return textFieldBorderedWithSuffixIcon(
                          _controller.confirmPassEditController, "**********", TextInputType.visiblePassword,
                          iconPath: _controller.isShowPassword.value
                              ? AssetConstants.ic_password_show
                              : AssetConstants.ic_password_hide,
                          isObscure: !_controller.isShowPassword.value, iconAction: () {
                        _controller.isShowPassword.value = !_controller.isShowPassword.value;
                      });
                    }),
                    VSpacer20(),
                    buttonRoundedMain(
                        text: "Change Password".tr,
                        onPressCallback: () {
                          _controller.isInPutDataValid(context);
                        }),
                    VSpacer20(),
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
