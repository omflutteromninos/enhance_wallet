import 'package:cPocket/ui/features/auth/sign_in/sign_in_page.dart';
import 'package:cPocket/ui/features/auth/sign_up/sign_up_controller.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpSuccessPage extends StatefulWidget {
  @override
  _SignUpSuccessPageState createState() => _SignUpSuccessPageState();
}

class _SignUpSuccessPageState extends State<SignUpSuccessPage> {
  SignUpController _controller = Get.put(SignUpController());

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
    return Scaffold(
        backgroundColor: kCommonBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: dp15),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: dp100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetConstants.ic_check_large,
                        width: Get.width / 3,
                        height: Get.width / 3,
                      ),
                      SizedBox(height: dp20),
                      textTitleLarge("Successful".tr),
                      SizedBox(height: dp20),
                      textSubtitle(
                          "Your registration is successful You can sign in now".tr,
                          textAlign: TextAlign.center),
                      SizedBox(height: dp20),
                      buttonRoundedMain(
                          text: "Sign in now".tr,
                          onPressCallback: () {
                            Get.off(() => SignInPage());
                          },
                          bgColor: kAccentColorOrange,
                          textColor: kButtonTextColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
