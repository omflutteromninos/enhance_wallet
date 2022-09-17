import 'package:cPocket/ui/features/auth/reset_password/reset_password_controller.dart';
import 'package:cPocket/ui/features/auth/sign_in/sign_in_page.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/custome_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../data/local/constants.dart';
import '../../../../utils/view_utils/dimens.dart';

class ResetPasswordPage extends StatefulWidget {
  //final registrationId;

  final String email;

  //const ResetPasswordPage({Key? key, this.registrationId}) : super(key: key);
  const ResetPasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  ResetPasswordController _controller = Get.put(ResetPasswordController());
  bool isObscure = true;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // TODO: implement initState
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.codeEditController.text = "";
    _controller.passEditController.text = "";
    _controller.confirmPassEditController.text = "";
    super.dispose();
  }
  var mainHeight, mainWidth;

  @override
  Widget build(BuildContext context) {
    if (widget.email.isNotEmpty) {
      _controller.emailEditController.text = widget.email;
    }

    return Scaffold(
      backgroundColor: kCommonBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: dp50),
              child: Column(
                children: [
                  viewTopLogoText(title: 'Password Reset'.tr, subTitle: 'Reset your accounts password'.tr),
                ],
              ),
            ),
            SizedBox(height: dp20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Verification Code'.tr,
                      style: TextStyle(color: kThemeTextColor)),
                  SizedBox(height: dp10),
                  textFieldBorderedWithSuffixIcon(_controller.codeEditController, "Input your Verification Code".tr, TextInputType.number),
                  SizedBox(height: dp15),
                  Text('Email Address',
                      style: TextStyle(color: kThemeTextColor)),
                  SizedBox(height: dp10),
                  textFieldBorderedWithSuffixIcon(_controller.emailEditController, "Your email address here".tr,
                      TextInputType.emailAddress, isEnable: false),
                  SizedBox(height: dp15),
                  Text('Password'.tr, style: TextStyle(color: kThemeTextColor)),
                  SizedBox(height: dp10),
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
                  SizedBox(height: dp15),
                  Text('Confirm Password'.tr,
                      style: TextStyle(color: kThemeTextColor)),
                  SizedBox(height: dp10),
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
                  SizedBox(height: dp20),
                  // raisedButton(),
                  buttonRoundedMain(
                      text: "Reset Password".tr,
                      onPressCallback: () {
                        _controller.isInPutDataValid(context);
                      }),
                  SizedBox(height: dp10),
                  returnToSignIn(),
                  SizedBox(height: dp10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  returnToSignIn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Return to'.tr, style: TextStyle(color: kThemeTextColor)),
        SizedBox(width: dp5),
        GestureDetector(
          child: Text('Sign In'.tr, style: TextStyle(color: kAccentColorOrange)),
          onTap: () {
            Get.off(() =>SignInPage());
          },
        ),
      ],
    );
  }
}
