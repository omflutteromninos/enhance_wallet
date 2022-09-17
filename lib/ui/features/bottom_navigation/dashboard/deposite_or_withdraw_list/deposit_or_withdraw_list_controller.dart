
import 'package:cPocket/data/models/list_response.dart';
import 'package:cPocket/data/models/transaction.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:get/get.dart';

class DepositOrWithdrawListController extends GetxController {
  RxList<DepositOrWithdraw> depositOrWithdrawList = <DepositOrWithdraw>[].obs;
  bool isLoading = true;
  int loadedPage = 0;
  bool hasMoreData = true;

  void getTransactionList(String type, bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      depositOrWithdrawList.clear();
      isLoading = false;
    }
    isLoading = true;
    loadedPage++;
    APIRepository().getDepositOrWithdrawList(type, loadedPage, true).then((resp) {
      isLoading = false;
      if (resp.success) {
        ListResponse response = ListResponse.fromJson(resp.data);
        if (response.data != null) {
          List<DepositOrWithdraw> list = List<DepositOrWithdraw>.from(response.data!.map((x) => DepositOrWithdraw.fromJson(x)));
          depositOrWithdrawList.addAll(list);
        }
        loadedPage = response.currentPage ?? 0;
        hasMoreData = response.nextPageUrl != null;
      } else {
        showToast(resp.message,isError: true);
        //transactionList.value = <Transaction>[];
      }
    }, onError: (err) {
      isLoading = false;
      showToast(err.toString());
      //transactionList.value = <Transaction>[];
    });
  }
}
