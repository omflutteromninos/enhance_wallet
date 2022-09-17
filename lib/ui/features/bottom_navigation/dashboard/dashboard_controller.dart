import 'package:cPocket/data/models/dashboard/dashboard_data.dart';
import 'package:cPocket/data/models/list_response.dart';
import 'package:cPocket/data/models/transaction.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  Rx<DashBoardData> dashBoardData = DashBoardData().obs;
  RxList<DepositOrWithdraw> depositOrWithdrawList = <DepositOrWithdraw>[].obs;
  bool isLoading = true;
  String currentTransactionListKey = "";

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }

  void getDashBoardData() {
    showLoadingDialog(isDismissible: true);
    APIRepository().getDashBoardData().then((resp) {
      hideLoadingDialog();
      if (resp.success) {
        dashBoardData.value = DashBoardData.fromJson(resp.data);
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      showToast(err.toString());
    });
  }

  void getTransactionList(String type) {
    isLoading = true;
    depositOrWithdrawList.clear();
    APIRepository().getDepositOrWithdrawList(type, 1, false).then((resp) {
      isLoading = false;
      if (resp.success) {
        ListResponse response = ListResponse.fromJson(resp.data);
        if (response.data != null) {
          List<DepositOrWithdraw> list = List<DepositOrWithdraw>.from(
              response.data!.map((x) => DepositOrWithdraw.fromJson(x)));
          depositOrWithdrawList.addAll(list);
        }
      } else {
        showToast(resp.message,isError: true);
        depositOrWithdrawList.value = <DepositOrWithdraw>[];
      }
    }, onError: (err) {
      isLoading = false;
      showToast(err.toString());
      depositOrWithdrawList.value = <DepositOrWithdraw>[];
    });
  }

// TabController? tabController;
// TextEditingController customAmountEditController = TextEditingController();
// List<int>? depositList = <int>[1,2,3,4].obs;
// List<int>? withdrawList = <int>[1,2,3,4,5].obs;
// List<int>? seeAllList = <int>[1,2,3,4,5,6,7,8,9,10].obs;
// int sectionCount = 0;
//
// @override
// void onInit() {
//   tabController = TabController(vsync: this, length: 3);
//   super.onInit();
//
// }

}
