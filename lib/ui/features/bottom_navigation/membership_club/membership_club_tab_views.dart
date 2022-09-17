import 'package:cPocket/data/models/general_settings.dart';
import 'package:cPocket/ui/features/bottom_navigation/membership_club/see_all_my_membership_bonus_history/see_all_my_membership_bonus_history_page.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'membership_club_controller.dart';

class MembershipClubTabViews extends StatefulWidget {
  final String? fromPage;

  const MembershipClubTabViews({Key? key, this.fromPage}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabControllerView();
}

class _TabControllerView extends State<MembershipClubTabViews> {
  MembershipClubPageController _controller = Get.put(MembershipClubPageController());
  GeneralSettings generalSettings = Get.find<RootController>().generalSettings.value;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // if(widget.fromPage == FromKey.transferCoin){
      //   _controller.clearView();
      //   _controller.getDefaultWalletListForClub();
      //   _controller.getDefaultWalletListForMain();
      //   _controller.getAllMembershipPlanList();
      // }else if(widget.fromPage == FromKey.myMembership){
      //   _controller.getMembershipDetails();
      //   _controller.get5MembershipBonusHistoryList();
      // }
      _controller.clearView();
      _controller.getDefaultWalletListForClub();
      _controller.getDefaultWalletListForMain();
      _controller.getAllMembershipPlanList();
      _controller.getMembershipDetails();
      _controller.get5MembershipBonusHistoryList();
    });
  }

  @override
  void didUpdateWidget(covariant MembershipClubTabViews oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if(widget.fromPage == FromKey.transferCoin){
        _controller.clearView();
        _controller.getDefaultWalletListForClub();
        _controller.getDefaultWalletListForMain();
        _controller.getAllMembershipPlanList();
      }else{
        _controller.getMembershipDetails();
        _controller.get5MembershipBonusHistoryList();
      }

      // _controller.clearView();
      // _controller.getDefaultWalletListForClub();
      // _controller.getDefaultWalletListForMain();
      // _controller.getAllMembershipPlanList();
      // _controller.getMembershipDetails();
      // _controller.get5MembershipBonusHistoryList();
    });
  }

  @override
  void dispose() {
    _controller.clearView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.fromPage == FromKey.transferCoin
        ? _transferCoinTab()
        : _myMembershipTab();
  }

  Widget _transferCoinTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: dp16, vertical: dp20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
            decoration: getRoundSoftTransparentBox(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textBodyBold16(text: "Select Your Wallet".tr),
                VSpacer10(),
                //textBodyNormal14(text: 'Select Your Wallet Description'.tr, maxLines: 7,textColor:kAccentColorOrange),
                _controller.generalSettings.smallPlanDescription == null
                    ? Container(height: 0)
                    : textAutoSize(
                        "Select Your Wallet Description".trParams({
                          "amountMin": _controller
                              .generalSettings.smallPlanDescription!.amount!
                              .toString(),
                          "name": stringNullCheck(
                              _controller.generalSettings.settings!.coinName),
                          "durationMin": _controller
                              .generalSettings.smallPlanDescription!.duration!
                              .toString(),
                        }),
                        fontSize: dp12,
                        color: kAccentColorOrange,
                        fontWeight: FontWeight.normal,
                        maxLines: 5),
                VSpacer20(),
                DottedLine(
                  dashColor: kDivider,
                ),
                VSpacer0(),
                ExpansionTile(
                  title:
                      textBodyBold14(text: "Transfer coin To club wallet".tr),
                  backgroundColor: Colors.transparent,
                  collapsedIconColor: kThemeTextColor,
                  collapsedBackgroundColor: Colors.transparent,
                  iconColor: kThemeTextColor,
                  tilePadding: EdgeInsets.all(dp0),
                  children: <Widget>[
                    Container(
                      //padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          VSpacer10(),
                          textBodyBold14(text: "Select From Wallet".tr),
                          VSpacer10(),
                          Obx(() {
                            return dropDownList2(
                                //_controller.getDefaultWalletNames(_controller.defaultWalletList),
                                _controller.getDefaultWalletNames(),
                                _controller.selectedDefaultWalletTypeForClub.value,
                                "Select".tr, (value) {
                              _controller.selectedDefaultWalletTypeForClub.value = value;
                            });
                          }),
                          VSpacer10(),
                          textBodyBold14(text: "Coin Amount".tr),
                          VSpacer10(),
                          textFieldBorderedWithSuffixIcon(
                              _controller.amountClubEditController,
                              "Coin".tr,
                              TextInputType.number),
                          VSpacer10(),
                          buttonRoundedMain(
                              text: "Transfer".tr,
                              onPressCallback: () {
                                if (_controller
                                    .checkTransferCoinInputValuesForClub(
                                        context)) {
                                  hideKeyboard(context);
                                  _controller.makeTransferCoinToClubWallet();
                                }
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
                VSpacer10(),
                DottedLine(
                  dashColor: kDivider,
                ),
                VSpacer10(),
                ExpansionTile(
                  title:
                      textBodyBold14(text: "Transfer coin To main wallet".tr),
                  backgroundColor: Colors.transparent,
                  collapsedIconColor: kThemeTextColor,
                  collapsedBackgroundColor: Colors.transparent,
                  iconColor: kThemeTextColor,
                  tilePadding: EdgeInsets.all(dp0),
                  children: <Widget>[
                    Container(
                      //padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          VSpacer10(),
                          textBodyBold14(text: "Coin Amount".tr),
                          VSpacer10(),
                          textFieldBorderedWithSuffixIcon(
                              _controller.amountMainEditController,
                              "Coin".tr,
                              TextInputType.number),
                          VSpacer10(),
                          textBodyBold14(text: "Select Your Wallet".tr),
                          VSpacer10(),
                          Obx(() {
                            return dropDownList2(
                                //_controller.getDefaultWalletNames(_controller.defaultWalletListForMain),
                                _controller.getDefaultWalletNames(),
                                _controller.selectedDefaultWalletTypeForMain.value,
                                "Select".tr, (value) {
                              _controller.selectedDefaultWalletTypeForMain
                                  .value = value;
                            });
                          }),
                          VSpacer10(),
                          buttonRoundedMain(
                              text: "Transfer".tr,
                              onPressCallback: () {
                                if (_controller
                                    .checkTransferCoinInputValuesForMain(
                                        context)) {
                                  hideKeyboard(context);
                                  _controller.makeTransferCoinToMainWallet();
                                }
                              }),
                          VSpacer10(),
                          textBodyNormal14(
                              text:
                                  'Transfer coin to main wallet warning message'
                                      .tr,
                              maxLines: 4,
                              textColor: kAccentColorOrange),
                          VSpacer0(),
                        ],
                      ),
                    ),
                  ],
                ),
                VSpacer0(),
              ],
            ),
          ),
          VSpacer20(),
          Container(
            padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
            decoration: getRoundSoftTransparentBox(),
            child: Column(
              children: [
                textBodyBold16(text: "Membership Plan Details".tr),
                VSpacer20(),
                DottedLine(
                  dashColor: kDivider,
                ),
                _membershipPlanList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _membershipPlanList() {
    return Obx(() {
      String message = "empty_message_membership_plan_list".tr;
      return _controller.membershipPlanList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
          : Column(
              children: List.generate(
                  _controller.membershipPlanList.length,
                  (index) => membershipPlanListItem(
                      _controller.membershipPlanList[index], generalSettings)),
            );
    });
  }

  Widget _myMembershipTab() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: dp0, horizontal: dp15),
      child: Column(
        children: [
          textBodyBold16(text: "My Membership Details".tr),
          VSpacer20(),
          Container(
            padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
            decoration: getRoundSoftTransparentBox(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textBodyBold14(text: "Membership Status".tr),
                    VSpacer20(),
                    textBodyBold14(text: "Blocked Amount".tr),
                    VSpacer20(),
                    textBodyBold14(text: "Member Since".tr),
                    VSpacer20(),
                    textBodyBold14(text: "Earned Bonus".tr),
                  ],
                ),
                Column(
                  children: [
                    textBodyBold14(text: ":"),
                    VSpacer20(),
                    textBodyBold14(text: ":"),
                    VSpacer20(),
                    textBodyBold14(text: ":"),
                    VSpacer20(),
                    textBodyBold14(text: ":"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    textBodyBold14(
                        text: stringNullCheck(_controller.membershipDetails.value.planName.toString())),
                    VSpacer20(),
                    textBodyBold14(
                        text: _controller.membershipDetails.value.amount.toString() + " Coin".tr),
                    VSpacer20(),
                    //textBodyBold14(text: "18 Jun 20"),
                    textBodyBold14(
                        text: formatDate(_controller.membershipDetails.value.startDate, format: dateFormatYyyyMMDd)),
                    VSpacer20(),
                    textBodyBold14(text: _controller.membershipDetails.value.bonusAmount.toString()),
                  ],
                ),
              ],
            ),
          ),
          VSpacer20(),
          textBodyBold14(text: "My Plan Details".tr),
          VSpacer20(),
          Container(
            padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
            decoration: getRoundSoftTransparentBox(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textBodyBold14(text: "Plan Name".tr),
                    VSpacer20(),
                    textBodyBold14(text: "Minimum Amount".tr),
                    VSpacer20(),
                    textBodyBold14(text: "Minimum Duration".tr),
                    VSpacer20(),
                    textBodyBold14(text: "Bonus Percentage".tr),
                  ],
                ),
                Column(
                  children: [
                    textBodyBold14(text: ":"),
                    VSpacer20(),
                    textBodyBold14(text: ":"),
                    VSpacer20(),
                    textBodyBold14(text: ":"),
                    VSpacer20(),
                    textBodyBold14(text: ":"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    textBodyBold14(
                        text: stringNullCheck(_controller
                            .membershipDetails.value.plan!.planName
                            .toString())),
                    VSpacer20(),
                    textBodyBold14(
                        text: _controller.membershipDetails.value.plan!.amount
                            .toString()),
                    VSpacer20(),
                    textBodyBold14(
                        text: _controller.membershipDetails.value.plan!.duration
                            .toString()),
                    VSpacer20(),
                    textBodyBold14(
                        text: _controller.membershipDetails.value.plan!.bonus
                                .toString() +
                            " %"),
                  ],
                ),
              ],
            ),
          ),
          VSpacer20(),
          getTitleSellAll(
              title: 'My Membership Bonus History'.tr,
              action: () {
                Get.to(() => SeeAllMyMembershipBonusHistoryPage());
              }),
          VSpacer20(),
          _myMembershipBonusHistoryList(),
          VSpacer20(),
        ],
      ),
    );
  }

  Widget _myMembershipBonusHistoryList() {
    return Obx(() {
      String message = "empty_message_membership_bonus_history_list".tr;
      return _controller.membershipBonusHistoryList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
          : Column(
              children: List.generate(_controller.membershipBonusHistoryList.length,
                  (index) => myMembershipBonusHistoryItem(
                      _controller.membershipBonusHistoryList[index],
                      _controller.membershipBonusHistoryResponse!.wallet!.user!.email)),
            );
    });
  }

}
