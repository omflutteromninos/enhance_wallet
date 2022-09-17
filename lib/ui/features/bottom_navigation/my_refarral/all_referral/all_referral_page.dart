import 'package:cPocket/data/models/my_refferal.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'all_referral_controller.dart';

class AllReferralPage extends StatefulWidget {
  final String fromPage;

  const AllReferralPage({Key? key, required this.fromPage}) : super(key: key);

  @override
  _AllReferralPageState createState() => _AllReferralPageState();
}

class _AllReferralPageState extends State<AllReferralPage> {
  final AllReferralController _controller = Get.put(AllReferralController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.getAllReferralList(widget.fromPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    var title = widget.fromPage == FromKey.earnings ? "My Earnings".tr : "My References".tr;

    return Scaffold(
      backgroundColor: kCommonBackgroundColor,
      body: SafeArea(
        child: Container(
          height: Get.height,
          child: Column(children: [
            buildAppBarWithBack(title: title, hideRightIcon: true),
           VSpacer10(),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: dp16),
                child: Column(
                  children: [
                    textAutoSize(title, fontSize:dp14),
                    const SizedBox(height: dp5),
                    _allReferralsList(),
                    const SizedBox(height:dp10),
                  ],
                ),
              ),
            ))
          ]),
        ),
      ),
    );
  }

  Widget _allReferralsList() {
    return Obx(() {
      String message =
          widget.fromPage == FromKey.references ? "empty_message_reference_list".tr : "empty_message_earning_list".tr;
      return _controller.allReferralList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
          : Column(
              children: List.generate(_controller.allReferralList.length, (index) {
                if (widget.fromPage == FromKey.references) {
                  return referenceItem(_controller.allReferralList[index] as Reference);
                } else {
                  return earningItem(_controller.allReferralList[index] as Earning);
                }
              }),
            );
    });
  }
}
