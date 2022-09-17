import 'package:cPocket/data/models/list_response.dart';
import 'package:cPocket/data/models/pocket_wallet/pocket_wallet.dart';
import 'package:cPocket/data/models/transaction.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletActivityLogController extends GetxController with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  RxList<DepositOrWithdraw> transactionList = <DepositOrWithdraw>[].obs;
  bool isLoading = true;
  int loadedPage = 0;
  bool hasMoreData = true;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }

  void getTransactionList(
      PocketWallet pocketWallet, String type, bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      transactionList.clear();
      isLoading = false;
    }
    isLoading = true;
    loadedPage++;
    APIRepository().getWalletTransactionList(pocketWallet.id,pocketWallet.id, type, loadedPage).then((resp) {
      isLoading = false;
      if (resp.success) {
        String key = type == FromKey.depositList
            ? APIConstants.kDeposits
            : APIConstants.kWithdraws;
        ListResponse response = ListResponse.fromJson(resp.data[key]);
        if (response.data != null) {
          List<DepositOrWithdraw> list = List<DepositOrWithdraw>.from(response.data!.map((x) => DepositOrWithdraw.fromJson(x)));
          transactionList.addAll(list);
        }
        loadedPage = response.currentPage ?? 0;
        hasMoreData = response.nextPageUrl != null;
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      isLoading = false;
      transactionList.clear();
      showToast(err.toString());
    });
  }

//
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
