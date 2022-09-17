import 'package:cPocket/data/models/transaction.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardTabListPage extends StatefulWidget {
  final String fromPage;

  const DashboardTabListPage({Key? key, required this.fromPage})
      : super(key: key);

  @override
  _DashboardTabListPageState createState() => _DashboardTabListPageState();
}

class _DashboardTabListPageState extends State<DashboardTabListPage> {
  final DashBoardController _controller = Get.put(DashBoardController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.getTransactionList(widget.fromPage);
    });
  }

  @override
  void didUpdateWidget(covariant DashboardTabListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.getTransactionList(widget.fromPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _transactionList(_controller.depositOrWithdrawList);
    });
  }

  Widget _transactionList(List<DepositOrWithdraw> transactionList) {
    return transactionList.isEmpty
        ? handleEmptyViewWithLoading(_controller.isLoading)
        : Column(
            children: List.generate(
              transactionList.length,
              (index) => transactionItem(_controller.depositOrWithdrawList[index]),
            ),
          );
  }
}
