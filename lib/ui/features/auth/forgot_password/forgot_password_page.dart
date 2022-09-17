import 'package:cPocket/ui/features/auth/reset_password/reset_password_page.dart';
import 'package:cPocket/ui/features/auth/sign_in/sign_in_page.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/custome_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  ForgotPasswordController _controller = Get.put(ForgotPasswordController());

  @override
  void initState() {

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // TODO: implement initState
    });
    super.initState();
  }

  var mainHeight, mainWidth;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kCommonBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: dp50),
                child: Column(
                  children: [
                    viewTopLogoText(title: 'Forgot Password'.tr, subTitle: 'Enter your email to reset password'.tr),
                  ],
                ),
              ),
              SizedBox(height: dp20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: dp15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email Address'.tr,
                        style: TextStyle(color: kThemeTextColor)),
                    SizedBox(height: dp10),
                    textFieldBorderedWithSuffixIcon(_controller.emailEditController, "Your email address here".tr, TextInputType.emailAddress),
                    SizedBox(height: dp20),
                    buttonRoundedMain(
                        text: "Send".tr,
                        onPressCallback: () {
                          _controller.isInPutDataValid(context);
                        }),
                    SizedBox(height: dp10),
                    returnToSignIn(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditText(
      {String? title,
      Widget? iconData,
      TextEditingController? controller,
      double? width,
      bool obsecure = false}) {
    return CustomEditText(
      height: dp60,
      width: width ?? mainWidth,
      controller: controller,
      hintStyle: TextStyle(color: kThemeTextColor.withOpacity(0.2)),
      textStyle: TextStyle(color: kThemeTextColor),
      suffixIcon: iconData,
      hint: title!,
      cursorColor: kThemeTextColor,
      onSaved: (String? value) {},
      borderFocusColor: kThemeTextColor.withOpacity(0.2),
      borderColor: kThemeTextColor.withOpacity(0.2),
      borderRadius: dp10,
      borderSize: 1,
      obsecure: obsecure,
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
