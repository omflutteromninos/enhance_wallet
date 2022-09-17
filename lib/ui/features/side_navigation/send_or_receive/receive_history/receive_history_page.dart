import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../history_controller.dart';

class ReceiveHistoryPage extends StatefulWidget {
  @override
  _ReceiveHistoryPageState createState() => _ReceiveHistoryPageState();
}

class _ReceiveHistoryPageState extends State<ReceiveHistoryPage> {
  HistoryController _controller = Get.put(HistoryController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.getAllReceiveCoinHistoryList(false);
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
                  title: "Receive history".tr, hideRightIcon: true),
              VSpacer5(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: dp16),
                  height: Get.height,
                  child: _receiveCoinHistoryList(),
                ),
              ),
              // VSpacer5(),
            ],
          ),
        ));
  }

  // Widget _receiveCoinHistoryList() {
  //   return Obx(() {
  //     String message ="empty_message_receive_coin_history_list".tr;
  //     return _controller.receiveCoinHistoryList.isEmpty
  //         ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
  //         : Column(
  //       children: List.generate(_controller.receiveCoinHistoryList.length,
  //               (index) =>
  //               coinHistoryItem(_controller.receiveCoinHistoryList[index], _controller.coinHistoryResponse.coinName)),
  //     );
  //   });
  // }

  Widget _receiveCoinHistoryList() {
    return Obx(() {
      String message = "empty_message_receive_coin_history_list".tr;
      return _controller.receiveCoinHistoryList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _controller.receiveCoinHistoryList.length,
              itemBuilder: (BuildContext context, int index) {
                if (_controller.hasMoreData && index == (_controller.receiveCoinHistoryList.length - 1)) {
                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                    _controller.getAllReceiveCoinHistoryList(true);
                  });
                }
                return coinHistoryItem(
                    _controller.receiveCoinHistoryList[index], _controller.coinName);
              },
            );
    });
  }
}
