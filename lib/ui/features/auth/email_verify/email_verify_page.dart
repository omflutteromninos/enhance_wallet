import 'dart:async';

import 'package:cPocket/ui/features/auth/sign_in/sign_in_page.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'email_verify_controller.dart';

class EmailVerifyPage extends StatefulWidget {
  final String registrationId;

  //const EmailVerifyPage(String email,this.registrationId, {Key? key}) : super(key: key);
  const EmailVerifyPage(this.registrationId, {Key? key}) : super(key: key);

  @override
  _EmailVerifyPageState createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  EmailVerifyController _controller = Get.put(EmailVerifyController());

  RxBool? resendActive = false.obs;
  Timer? resendTimer;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      startTimer();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.emailEditController.text = "";
    _controller.codeEditController.text = "";
    resendTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.registrationId.isNotEmpty) {
      _controller.emailEditController.text = widget.registrationId;
    }
    return Scaffold(
      backgroundColor: kCommonBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: dp15),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: dp50),
                child: Column(
                  children: [
                    viewTopLogoText(
                        title: 'Email Verification'.tr,
                        subTitle:
                            'Verify your email with the number we sent you'.tr),
                  ],
                ),
              ),
              SizedBox(height: dp20),
              textFieldBorderedWithSuffixIcon(_controller.emailEditController,
                  "Your email address here".tr, TextInputType.emailAddress,
                  isEnable: false),
              SizedBox(height: dp20),
              _pinCodeView(),
              // Obx(() {
              //   return textTitleMidForCode(
              //       text: "Resend code".tr,
              //       textColor:
              //           resendActive!.value ? kThemeTextColor : light_grey,
              //       onTap: !resendActive!.value
              //           ? null
              //           : () {
              //               _controller
              //                   .resendVerificationCode(widget.registrationId);
              //               startTimer();
              //             });
              // }),
              //textSubtitle("Pressed code in".tr.trParams({"time": "00:30"})),
              VSpacer10(),
              buttonRoundedMain(
                  text: "Verify".tr,
                  onPressCallback: () {
                    //_controller.isInPutDataValid(widget.registrationId, context);
                    _controller.isInPutDataValid(context);
                  }),
              VSpacer10(),
              returnToSignIn(),
            ],
          ),
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
          child: Text('Sign In', style: TextStyle(color: kAccentColorOrange)),
          onTap: () {
            Get.off(() => SignInPage());
          },
        ),
      ],
    );
  }

  Widget _pinCodeView() {
    // ignore: close_sinks
    StreamController<ErrorAnimationType> errorController =
        StreamController<ErrorAnimationType>();
    return Container(
      margin: EdgeInsets.all(dp10),
      child: PinCodeTextField(
        length: 6,
        obscureText: false,
        animationType: AnimationType.slide,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(dp5),
            borderWidth: dp1,
            fieldHeight: Get.width / 8,
            fieldWidth: Get.width / 8,
            activeColor: Colors.grey,
            activeFillColor: Colors.transparent,
            //inactiveColor: Get.theme.primaryColorDark.withAlpha(100),
            inactiveColor: white,
            inactiveFillColor: Colors.transparent,
            selectedColor: Get.theme.colorScheme.secondary,
            selectedFillColor: Colors.transparent),
        animationDuration: Duration(milliseconds: 100),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        errorAnimationController: errorController,
        controller: _controller.codeEditController,
        onCompleted: (v) {},
        onChanged: (value) {},
        beforeTextPaste: (text) {
          return false;
        },
        appContext: context,
      ),
    );
  }

  void startTimer() {
    resendActive!.value = false;
    int second = 0;
    resendTimer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      second++;
      if (second == 45) {
        resendTimer!.cancel();
        resendActive!.value = true;
      }
    });
  }
}
