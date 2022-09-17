import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/ui/features/side_navigation/my_profile/phone_verification/phone_verification_controller.dart';
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
import 'phone_verification_page.dart';

class SendCodePage extends StatefulWidget {
  final User user;
  const SendCodePage({Key? key, required this.user}) : super(key: key);

  @override
  _SendCodePageState createState() => _SendCodePageState();
}

class _SendCodePageState extends State<SendCodePage> {
  final PhoneVerificationController _controller = Get.put(PhoneVerificationController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.user.phone != null && widget.user.phone!.isNotEmpty) {
        _controller.phoneEditController.text = widget.user.phone!;
      }
    });
  }

  @override
  void dispose() {
    _controller.phoneEditController.text = "";
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
                    textAutoSize("Phone Number".tr, fontSize: dp14),
                    VSpacer10(),
                    textFieldBorderedWithSuffixIcon(_controller.phoneEditController,
                        "Your phone number with dial code".tr, TextInputType.number, isEnable: false),
                    VSpacer20(),
                    buttonRoundedMain(
                        text: "Send SMS".tr,
                        onPressCallback: () {
                          _controller.sendSms(() => goNextPage());
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


  Future<void> goNextPage() async {
    var result = await Get.to(() => PhoneVerificationPage(user: widget.user));
    if (result is bool && result == true){
      Get.back();
    }
  }
}
