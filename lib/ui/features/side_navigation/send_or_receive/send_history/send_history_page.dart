import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../history_controller.dart';

class SendHistoryPage extends StatefulWidget {
  @override
  _SendHistoryPageState createState() => _SendHistoryPageState();
}

class _SendHistoryPageState extends State<SendHistoryPage> {
  HistoryController _controller = Get.put(HistoryController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.getAllSendCoinHistoryList(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kCommonBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              buildAppBarWithBack(title: "Send history".tr, hideRightIcon: true),
              VSpacer5(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: dp16),
                  height: Get.height,
                  child: _sendCoinHistoryList(),
                ),
              ),
              // VSpacer5(),
            ],
          ),
        ));
  }

  //
  // Widget _sendHistoryList() {
  //   return Obx(() {
  //     return _controller.sendHistoryList!.length == 0
  //         ? emptyView()
  //         : Container(
  //       height: Get.height - (dp115),
  //       child: ListView.builder(
  //         scrollDirection: Axis.vertical,
  //         itemCount: _controller.sendHistoryList!.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           return sendHistoryItem();
  //         },
  //       ),
  //     );
  //   });
  // }

  // Widget _sendCoinHistoryList() {
  //   return Obx(() {
  //     String message ="empty_message_send_coin_history_list".tr;
  //     return _controller.sendCoinHistoryList.isEmpty
  //         ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
  //         : Column(
  //       children: List.generate(_controller.sendCoinHistoryList.length,
  //               (index) =>
  //                   coinHistoryItem(_controller.sendCoinHistoryList[index], _controller.coinHistoryResponse.coinName)),
  //     );
  //   });
  // }
  Widget _sendCoinHistoryList() {
    return Obx(() {
      String message = "empty_message_send_coin_history_list".tr;
      return _controller.sendCoinHistoryList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
          : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _controller.sendCoinHistoryList.length,
            itemBuilder: (BuildContext context, int index) {
              if (_controller.hasMoreData && index == (_controller.sendCoinHistoryList.length - 1)) {
                WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                  _controller.getAllSendCoinHistoryList(true);
                });
              }
              return coinHistoryItem(_controller.sendCoinHistoryList[index],_controller.coinName);
            },
          );
    });
  }
}
