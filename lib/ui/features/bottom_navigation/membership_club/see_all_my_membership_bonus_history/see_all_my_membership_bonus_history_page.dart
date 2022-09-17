import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'see_all_my_membership_bonus_history_controller.dart';

class SeeAllMyMembershipBonusHistoryPage extends StatefulWidget {
  @override
  _SeeAllMyMembershipBonusHistoryPageState createState() =>
      _SeeAllMyMembershipBonusHistoryPageState();
}

class _SeeAllMyMembershipBonusHistoryPageState
    extends State<SeeAllMyMembershipBonusHistoryPage> {
  SeeAllMyMembershipBonusHistoryController _controller =
      Get.put(SeeAllMyMembershipBonusHistoryController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.getAllMembershipBonusHistoryList(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kCommonBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              buildAppBarWithBack(
                  title: "My Membership Bonus History".tr, hideRightIcon: true),
              VSpacer5(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: dp16),
                height: Get.height - 90,
                child: _seeAllMyMembershipBonusHistoryList(),
              ),
              VSpacer5(),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Container(
              //       margin: EdgeInsets.symmetric(horizontal: dp16),
              //       child: Column(
              //         children: [
              //           _seeAllMyMembershipBonusHistoryList(),
              //           VSpacer20(),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }

  // Widget _seeAllMyMembershipBonusHistoryList() {
  //   return Obx(() {
  //     return _controller.seeAllMyMembershipBonusHistoryList!.length == 0
  //         ? emptyView()
  //         : Container(
  //       height: Get.height - (dp115),
  //       child: ListView.builder(
  //         scrollDirection: Axis.vertical,
  //         itemCount: _controller.seeAllMyMembershipBonusHistoryList!.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           return myMembershipBonusHistoryItem();
  //         },
  //       ),
  //     );
  //   });
  // }

  // Widget _seeAllMyMembershipBonusHistoryList() {
  //   return Obx(() {
  //     String message = "empty_message_membership_bonus_history_list".tr;
  //     return _controller.membershipBonusHistoryList.isEmpty
  //         ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
  //         : Column(
  //             children: List.generate(_controller.membershipBonusHistoryList.length,
  //                 (index) => myMembershipBonusHistoryItem(
  //                     _controller.membershipBonusHistoryList[index],
  //                     _controller.membershipBonusHistoryResponse!.wallet!.user!.email)),
  //           );
  //   });
  // }

  Widget _seeAllMyMembershipBonusHistoryList() {
    return Obx(() {
      String message = "empty_message_membership_bonus_history_list".tr;
      return _controller.membershipBonusHistoryList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _controller.membershipBonusHistoryList.length,
              itemBuilder: (BuildContext context, int index) {
                if (_controller.hasMoreData && index == (_controller.membershipBonusHistoryList.length - 1)) {
                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                    _controller.getAllMembershipBonusHistoryList(true);
                  });
                }
                return myMembershipBonusHistoryItem(
                    _controller.membershipBonusHistoryList[index],
                    _controller.membershipBonusHistoryResponse!.wallet!.user!.email);
              },
            );
    });
  }
}
