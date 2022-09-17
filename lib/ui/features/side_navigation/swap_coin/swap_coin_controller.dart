import 'dart:async';
import 'package:cPocket/data/models/list_response.dart';
import 'package:cPocket/data/models/swap_coin/swap_coin_all_wallets.dart';
import 'package:cPocket/data/models/swap_coin/swap_coin_history.dart';
import 'package:cPocket/data/models/swap_coin/swap_coin_rate_response.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwapCoinController extends GetxController with GetSingleTickerProviderStateMixin {

  TextEditingController amountEditController = TextEditingController();
  // TextEditingController currencyEditController = TextEditingController();
  // TextEditingController coinEditController = TextEditingController();
  List<Wallet> swapCoinAllWalletsList = <Wallet>[];
  //List<SwapCoinRate> swapCoinRate = <SwapCoinRate>[];
  Rx<SwapCoinRate> swapCoinRate = SwapCoinRate().obs;
  //SwapCoinRate swapCoinRate = SwapCoinRate();
  RxString selectedWalletFrom = "".obs;
  RxString selectedWalletTo = "".obs;
  RxString selectedWalletFromId = "".obs;
  RxString selectedWalletToId = "".obs;
  Timer? _debounce;


  //RxList<dynamic> swapCoinHistoryList = <dynamic>[].obs;

  RxList<SwapCoinHistory> swapCoinHistoryList = <SwapCoinHistory>[].obs;

  bool isLoading = true;
  int loadedPage = 0;
  bool hasMoreData = true;

  TabController? tabController;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }

  void clearView() {
    selectedWalletFrom.value = "";
    selectedWalletTo.value = "";
    amountEditController.text = "";
    selectedWalletFromId.value = "";
    selectedWalletToId.value = "";
  }

  void onTextChanged(String amount) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      getCoinRate();
    });
  }

  void checkSelection(){
    if(selectedWalletFrom.value.isEmpty || selectedWalletTo.value.isEmpty){
      return;
    }
    if(amountEditController.text.isEmpty){
      amountEditController.text = 1.toString();
    }
      getCoinRate();
  }


  void getCoinRate() {
    if(selectedWalletFrom.value.isEmpty || selectedWalletTo.value.isEmpty){
      return;
    }
    if(amountEditController.text.isEmpty){
      return;
    }
    if(amountEditController.text == 0.toString()){
      showToast("Please insert coin amount bigger than 0".tr, isError: true);
      return;
    }
    showLoadingDialog();
    var fromWallet = swapCoinAllWalletsList.firstWhere((element) => stringNullCheck(element.name) + " " + "(" + stringNullCheck(element.balance)+ " " + stringNullCheck(element.coinType) + ")" == selectedWalletFrom.value);
    var toWallet = swapCoinAllWalletsList.firstWhere((element) => stringNullCheck(element.name) + " " + "(" + stringNullCheck(element.balance)+ " " + stringNullCheck(element.coinType) + ")" == selectedWalletTo.value);
    APIRepository().getSwapCoinRate(fromWallet.id, toWallet.id, amountEditController.text).then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        swapCoinRate.value = SwapCoinRate.fromJson(resp.data);
        //clearView();
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      showToast(err.toString());
    });
  }

  List<String> getWalletNamesList() {
    return swapCoinAllWalletsList.map((e) {
      // return stringNullCheck(e.name) + " " + "(" + stringNullCheck(e.coinType) + ")";
     //return stringNullCheck(e.name) + " " + "(" + stringNullCheck(e.coinType) + " - " + stringNullCheck(e.balance)+ ")";
     return stringNullCheck(e.name) + " " + "(" + stringNullCheck(e.balance)+ " " + stringNullCheck(e.coinType) + ")";
    }).toList();
  }

  void getSwapCoinAllWalletList() {
    showLoadingDialog();
    APIRepository().getSwapCoinAllWalletDropdownList().then((resp) {
      if (resp.success) {
        hideLoadingDialog();
        clearView();
        if (resp.data != null) {
          List<Wallet> list = List<Wallet>.from(resp.data!.map((x) => Wallet.fromJson(x)));
          // swapCoinAllWalletsList.addAll(list);
          swapCoinAllWalletsList = list;
        }
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  bool checkSwapCoinInputValues(BuildContext context) {
    if (selectedWalletFrom.value.isEmpty) {
      showToast("Swap from wallet name can not be empty".tr, isError: true);
      return false;
    }
    if (selectedWalletTo.value.isEmpty) {
      showToast("Swap with wallet name can not be empty".tr, isError: true);
      return false;
    }
    if (amountEditController.text.isEmpty) {
      showToast("Coin amount can not be empty".tr);
      return false;
    }
    if(amountEditController.text == 0.toString()){
      showToast("Please insert coin amount bigger than 0".tr, isError: true);
      return false;
    }
    return true;
  }

  void makeSwapCoin() {
    if(selectedWalletFrom.value.isEmpty || selectedWalletTo.value.isEmpty){
      return;
    }
    showLoadingDialog();
    var fromWallet = swapCoinAllWalletsList.firstWhere((element) => stringNullCheck(element.name) + " " + "(" + stringNullCheck(element.balance)+ " " + stringNullCheck(element.coinType) + ")" == selectedWalletFrom.value);
    var toWallet = swapCoinAllWalletsList.firstWhere((element) => stringNullCheck(element.name) + " " + "(" + stringNullCheck(element.balance)+ " " + stringNullCheck(element.coinType) + ")" == selectedWalletTo.value);
    // var fromWallet = swapCoinAllWalletsList.firstWhere((element) => stringNullCheck(element.name) + " " + "(" + stringNullCheck(element.coinType) + ")" == selectedWalletFrom.value);
    // var toWallet = swapCoinAllWalletsList.firstWhere((element) => stringNullCheck(element.name) + " " + "(" + stringNullCheck(element.coinType) + ")" == selectedWalletTo.value);
    // var fromWallet = swapCoinAllWalletsList.firstWhere((element) => stringNullCheck(element.name) + " " + "(" + stringNullCheck(element.coinType) + " - " + stringNullCheck(element.balance)+ ")" == selectedWalletFrom.value);
    // var toWallet = swapCoinAllWalletsList.firstWhere((element) => stringNullCheck(element.name) + " " + "(" + stringNullCheck(element.coinType) + " - " + stringNullCheck(element.balance)+ ")" == selectedWalletTo.value);
     APIRepository()
        .swapCoin(fromWallet.id, toWallet.id, amountEditController.text)
        .then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        //Get.back();
        clearView();
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }


  // void getAllSwapCoinHistoryList() {
  //   showLoadingDialog(isDismissible: true);
  //   APIRepository().getSwapCoinHistoryList().then((resp) {
  //     isLoading = false;
  //     swapCoinHistoryList.clear();
  //     if (resp.success) {
  //       hideLoadingDialog();
  //       try {
  //         List<SwapCoinHistory> list = List<SwapCoinHistory>.from(
  //             resp.data.map((x) => SwapCoinHistory.fromJson(x)));
  //         swapCoinHistoryList.addAll(list);
  //       } catch (e) {
  //         printError();
  //       }
  //     } else {
  //       showToast(resp.message);
  //     }
  //   }, onError: (err) {
  //     isLoading = false;
  //     showToast(err.toString());
  //   });
  // }

  void getAllSwapCoinHistoryList(bool isFromLoadMore) {
    print("getAllSwapCoinHistoryList");
    //showLoadingDialog(isDismissible: true);
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      swapCoinHistoryList.clear();
      isLoading = false;
    }
    isLoading = true;
    loadedPage++;
    APIRepository().getSwapCoinHistoryList(loadedPage).then((resp) {
      isLoading = false;
      if (resp.success) {
        ListResponse response = ListResponse.fromJson(resp.data);
        if (response.data != null) {
          List<SwapCoinHistory> list = List<SwapCoinHistory>.from(response.data!.map((x) => SwapCoinHistory.fromJson(x)));
          swapCoinHistoryList.addAll(list);
        }
        loadedPage = response.currentPage ?? 0;
        hasMoreData = response.nextPageUrl != null;
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      isLoading = false;
      showToast(err.toString());
    });
  }

}