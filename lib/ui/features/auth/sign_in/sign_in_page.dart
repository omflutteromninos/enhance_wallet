import 'package:cPocket/ui/features/auth/sign_in/sign_in_controller.dart';
import 'package:cPocket/ui/features/auth/forgot_password/forgot_password_page.dart';
import 'package:cPocket/ui/features/auth/sign_up/sign_up_page.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/toast_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInController _controller = Get.put(SignInController());
  bool isObscure = true;
  var mainHeight, mainWidth;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // TODO: implement initState
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.clearInputData();
    super.dispose();
  }

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
                        title: 'Sign In'.tr,
                        subTitle: 'Log into your account'.tr),
                  ],
                ),
              ),
              VSpacer20(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: dp15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        _controller.isShowPassword.value = !_controller.isShowPassword.value;
                      });
                    }),
                    SizedBox(height: dp10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        child: Text('Forgot Password?'.tr,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: kThemeTextColor)),
                        onTap: () {
                          /// Enable below line if you have purchased (remove '//' to enable)
                          //Get.to(() => ForgotPasswordPage());
                          ToastUtil.showToast("demo_version_text".tr, isError: true);/// Delete this line if you have purchased
                        },
                      ),
                    ),
                    SizedBox(height: dp20),
                    buttonRoundedMain(
                        text: "Sign In".tr,
                        onPressCallback: () {
                          _controller.isInPutDataValid(context);
                        }),
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
        Text('Do not have an account Return to'.tr,
            style: TextStyle(color: kThemeTextColor)),
        SizedBox(width: dp5),
        GestureDetector(
          child:
              Text('Sign Up'.tr, style: TextStyle(color: kAccentColorOrange)),
          onTap: () {
            /// Enable below line if you have purchased (remove '//' to enable)
            Get.to((

                ) => SignUpPage());
            //ToastUtil.showToast("demo_version_text".tr, isError: true); /// Delete this line if you have purchased
          },
        ),
      ],
    );
  }
}
