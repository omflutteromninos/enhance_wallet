import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'deposit_or_withdraw_list_controller.dart';

class DepositOrWithdrawListPage extends StatefulWidget {
  final String fromPage;

  const DepositOrWithdrawListPage({Key? key, required this.fromPage})
      : super(key: key);

  @override
  _DepositOrWithdrawListPageState createState() => _DepositOrWithdrawListPageState();
}

class _DepositOrWithdrawListPageState extends State<DepositOrWithdrawListPage> {
  final DepositOrWithdrawListController _controller =
      Get.put(DepositOrWithdrawListController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.getTransactionList(widget.fromPage, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    var title = widget.fromPage == FromKey.deposit
        ? "Deposit List".tr
        : "Withdraw List".tr;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: decorationBackgroundImage,
          height: Get.height,
          child: Column(
            children: [
              buildAppBarWithBack(title: title, hideRightIcon: true),
              tradingScriptView(),
              VSpacer10(),
              _transactionList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _transactionList() {
    return Obx(() {
      return _controller.depositOrWithdrawList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoading)
          : Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: dp0, horizontal: dp15),
                scrollDirection: Axis.vertical,
                itemCount: _controller.depositOrWithdrawList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_controller.hasMoreData &&
                      index == (_controller.depositOrWithdrawList.length - 1)) {
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                      _controller.getTransactionList(widget.fromPage, true);
                    });
                  }
                  return transactionItem(_controller.depositOrWithdrawList[index]);
                },
              ),
            );
    });
  }
}
