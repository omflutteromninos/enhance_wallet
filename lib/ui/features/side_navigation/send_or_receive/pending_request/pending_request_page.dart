import 'package:cPocket/data/models/send_receive_pending_coin/coin_history_response.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../history_controller.dart';

class PendingRequestPage extends StatefulWidget {
  @override
  _PendingRequestPageState createState() => _PendingRequestPageState();
}

class _PendingRequestPageState extends State<PendingRequestPage> {
  HistoryController _controller = Get.put(HistoryController());
  bool? isAccept;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.getAllRequestPendingCoinHistoryList(false);
      // _controller.actionForCoinRequest(isAccept);
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
                  title: "Pending Request".tr, hideRightIcon: true),
              VSpacer5(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: dp16),
                  height: Get.height,
                  child: _pendingCoinHistoryList(),
                ),
              ),
              // VSpacer5(),
            ],
          ),
        ));
  }

  // Widget _pendingCoinHistoryList() {
  //   return Obx(() {
  //     String message = "empty_message_pending_request_coin_history_list".tr;
  //     return _controller.requestPendingCoinHistoryList.isEmpty
  //         ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
  //         : Column(
  //             children: List.generate(
  //                 _controller.requestPendingCoinHistoryList.length,
  //                 (index) => coinHistoryItemWithApprovalAction(
  //                     _controller.requestPendingCoinHistoryList[index],
  //                     _controller.coinHistoryResponse.coinName)),
  //           );
  //   });
  // }

  Widget _pendingCoinHistoryList() {
    return Obx(() {
      String message = "empty_message_pending_request_coin_history_list".tr;
      return _controller.requestPendingCoinHistoryList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _controller.requestPendingCoinHistoryList.length,
              itemBuilder: (BuildContext context, int index) {
                if (_controller.hasMoreData &&
                    index ==
                        (_controller.requestPendingCoinHistoryList.length -
                            1)) {
                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                    _controller.getAllRequestPendingCoinHistoryList(true);
                  });
                }
                return coinHistoryItemWithApprovalAction(
                    _controller.requestPendingCoinHistoryList[index],
                    _controller.coinName);
              },
            );
    });
  }

  Widget coinHistoryItemWithApprovalAction(
      CoinHistory coinHistory, String? name) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
      decoration: getRoundSoftTransparentBox(),
      margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp5),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // textSpan("ID_colon".tr, stringNullCheck(coinHistory.id.toString())),
          // VSpacer5(),
          textSpan("Sender_colon".tr,
              stringNullCheck(coinHistory.senderEmail.toString())),
          VSpacer5(),
          textSpan(
              "Receiver_colon".tr, stringNullCheck(coinHistory.receiverEmail)),
          VSpacer5(),
          textSpan("Coin_amount_colon".tr, coinHistory.amount.toString()),
          VSpacer5(),
          textSpan("Coin_name_colon".tr, stringNullCheck(name)),
          VSpacer5(),
          textSpan("Status_colon".tr, getUserStatus(coinHistory.status),
              color: getStatusColor(coinHistory.status)),
          VSpacer5(),
          textSpan(
              "Created_At_colon".tr,
              formatDate(coinHistory.updatedAt,
                  format: dateTimeFormatDdMMMMYyyyHhMm)),
          VSpacer5(),
          Row(
            children: [
              textBodyBold14(text: "Actions_colon".tr),
              iconViewWithRoundedBoxWithText(
                  text: 'Accept'.tr,
                  icon: Icons.check_box,
                  iconColor: kAcceptColor,
                  iconSize: 16,
                  onPressCallback: (() {
                    isAccept = true;
                    _controller.actionForCoinRequest(true, coinHistory);
                  })),
              HSpacer10(),
              iconViewWithRoundedBoxWithText(
                  text: 'Reject'.tr,
                  icon: Icons.indeterminate_check_box,
                  iconColor: kRedColor,
                  iconSize: 16,
                  onPressCallback: (() {
                    isAccept = false;
                    _controller.actionForCoinRequest(false, coinHistory);
                  }))
            ],
          ),
        ],
      ),
    );
  }
}
