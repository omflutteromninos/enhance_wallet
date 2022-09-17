import 'package:cPocket/ui/features/auth/sign_in/sign_in_page.dart';
import 'package:cPocket/ui/features/auth/sign_up/sign_up_controller.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isObscure = true;
  SignUpController _controller = Get.put(SignUpController());

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
                    viewTopLogoText(
                        title: 'Sign Up'.tr,
                        subTitle: 'Lets sign up your account'.tr),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('First Name'.tr,
                        style: TextStyle(color: kThemeTextColor)),
                    SizedBox(height: dp10),
                    textFieldBorderedWithSuffixIcon(
                        _controller.firstNameEditController,
                        "Your first name here".tr,
                        TextInputType.name),
                    SizedBox(height: dp15),
                    Text('Last Name'.tr,
                        style: TextStyle(color: kThemeTextColor)),
                    SizedBox(height: dp10),
                    textFieldBorderedWithSuffixIcon(
                        _controller.lastNameEditController,
                        "Your last name here".tr,
                        TextInputType.name),
                    SizedBox(height: dp15),
                    Text('Email Address'.tr,
                        style: TextStyle(color: kThemeTextColor)),
                    SizedBox(height: dp10),
                    textFieldBorderedWithSuffixIcon(
                        _controller.emailEditController,
                        "Your email address here".tr,
                        TextInputType.emailAddress),
                    SizedBox(height: dp15),
                    Text('Password'.tr,
                        style: TextStyle(color: kThemeTextColor)),
                    SizedBox(height: dp10),
                    Obx(() {
                      return textFieldBorderedWithSuffixIcon(
                          _controller.passEditController,
                          "**********",
                          TextInputType.visiblePassword,
                          iconPath: _controller.isShowPassword.value
                              ? AssetConstants.ic_password_show
                              : AssetConstants.ic_password_hide,
                          isObscure: !_controller.isShowPassword.value,
                          iconAction: () {
                        _controller.isShowPassword.value =
                            !_controller.isShowPassword.value;
                      });
                    }),
                    SizedBox(height: dp15),
                    Text('Confirm Password'.tr,
                        style: TextStyle(color: kThemeTextColor)),
                    SizedBox(height: dp10),
                    Obx(() {
                      return textFieldBorderedWithSuffixIcon(
                          _controller.confirmPassEditController,
                          "**********",
                          TextInputType.visiblePassword,
                          iconPath: _controller.isShowPassword.value
                              ? AssetConstants.ic_password_show
                              : AssetConstants.ic_password_hide,
                          isObscure: !_controller.isShowPassword.value,
                          iconAction: () {
                        _controller.isShowPassword.value =
                            !_controller.isShowPassword.value;
                      });
                    }),
                    SizedBox(height: dp20),
                    buttonRoundedMain(
                        text: "Sign Up".tr,
                        onPressCallback: () {
                          _controller.isInPutDataValid();
                        }),
                    //raisedButton(),
                    SizedBox(height: dp10),
                    checkIfAccountExists(),
                    SizedBox(height: dp10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkIfAccountExists() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account Return to'.tr,
            style: TextStyle(color: kThemeTextColor)),
        SizedBox(width: dp5),
        GestureDetector(
          child: Text('Sign In', style: TextStyle(color: kAccentColorOrange)),
          onTap: () {
            Get.off(() => SignInPage());
          },
        ),
      ],
    );
  }
}
