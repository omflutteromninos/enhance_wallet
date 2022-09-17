import 'dart:async';

import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'phone_verification_controller.dart';

class PhoneVerificationPage extends StatefulWidget {
  final User user;

  const PhoneVerificationPage({Key? key, required this.user}) : super(key: key);

  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final PhoneVerificationController _controller = Get.put(PhoneVerificationController());
  Timer? resendTimer;
  RxBool resendActive = false.obs;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.user.phone != null && widget.user.phone!.isNotEmpty) {
        _controller.phoneEditController.text = widget.user.phone!;
      }
      startTimer();
    });

  }

  @override
  void dispose() {
    _controller.phoneEditController.text = "";
    _controller.codeEditController.text = "";
    resendTimer?.cancel();
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
                title: "Phone Verification".tr, hideRightIcon: true),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: dp15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VSpacer20(),
                    viewProfilePhotoWithName(widget.user),
                    VSpacer20(),
                    textAutoSize("Phone Number".tr,
                        fontSize: dp14, fontWeight: FontWeight.normal),
                    VSpacer10(),
                    textFieldBorderedWithSuffixIcon(
                        _controller.phoneEditController,
                        "Your email address here".tr,
                        TextInputType.emailAddress,
                        isEnable: false),
                    VSpacer10(),
                    textAutoSize("Verification code".tr,
                        fontSize: dp14, fontWeight: FontWeight.normal),
                    VSpacer10(),
                    textFieldBorderedWithSuffixIcon(
                        _controller.codeEditController,
                        "Input your Verification Code".tr,
                        TextInputType.number),
                    VSpacer20(),
                    buttonRoundedMain(
                      text: "Verify".tr,
                      onPressCallback: () {
                        //Get.back();
                        _controller.isInPutDataValid(context);
                      },
                    ),
                    VSpacer20(),
                    Obx(() {
                      return textAutoSize("Resend code".tr,
                          textAlign: TextAlign.center,
                          color: resendActive.value
                              ? Get.theme.primaryColor
                              : Get.theme.primaryColor.withOpacity(0.5),
                          onTap: !resendActive.value
                              ? null
                              : () {
                            _controller.sendSms(null);
                            startTimer();
                          });
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    resendActive.value = false;
    int second = 0;
    resendTimer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      second++;
      if (second == 45) {
        resendTimer?.cancel();
        resendActive.value = true;
      }
    });
  }
}
