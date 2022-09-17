import 'package:cPocket/data/models/pocket_wallet/pocket_wallet.dart';
import 'package:cPocket/data/models/transaction.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Wallet_activity_log_controller.dart';

class WalletActivityLogTabListViews extends StatefulWidget {
  final String fromPage;
  final PocketWallet pocketWallet;

  const WalletActivityLogTabListViews(
      {Key? key, required this.fromPage, required this.pocketWallet})
      : super(key: key);

  @override
  _WalletActivityLogTabListViewsState createState() =>
      _WalletActivityLogTabListViewsState();
}

class _WalletActivityLogTabListViewsState
    extends State<WalletActivityLogTabListViews> {
  WalletActivityLogController _controller = Get.put(WalletActivityLogController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.getTransactionList(widget.pocketWallet, widget.fromPage, false);
    });
  }

  @override
  void didUpdateWidget(covariant WalletActivityLogTabListViews oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.getTransactionList(widget.pocketWallet, widget.fromPage, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _transactionList(_controller.transactionList);
    });
  }
  Widget _transactionList(List<DepositOrWithdraw> transactionList) {
    return transactionList.isEmpty
        ? handleEmptyViewWithLoading(_controller.isLoading)
        : Column(
            children: List.generate(transactionList.length, (index) {
              if (_controller.hasMoreData && index == (_controller.transactionList.length - 1)) {
                WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                  _controller.getTransactionList(widget.pocketWallet, widget.fromPage, true);
                });
              }
              return transactionItem(_controller.transactionList[index]);
              // transactionList.isEmpty
              //     ? handleEmptyViewWithLoading(_controller.isLoading)
              // :transactionItem(_controller.transactionList[index]);
            }),
          );
  }
}
