import 'package:cPocket/data/models/buy_coin/buy_coin_and_phase_information.dart';
import 'package:cPocket/data/models/default_wallet.dart';
import 'package:cPocket/data/models/general_settings.dart';
import 'package:cPocket/data/models/pocket_wallet/coin.dart';
import 'package:cPocket/data/models/send_receive_pending_coin/coin_history_response.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendOrRequestCoinController extends GetxController with GetSingleTickerProviderStateMixin {
  TabController? tabController;

  TextEditingController emailEditController = TextEditingController();
  TextEditingController amountEditController = TextEditingController();

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }

  void clearView() {
    emailEditController.text = "";
    amountEditController.text = "";
    selectedDefaultWalletType.value = "";
    defaultWalletList =[];
  }

  List<DefaultWallet> defaultWalletList = <DefaultWallet>[];
  RxString selectedDefaultWalletType = "".obs;

  void getDefaultWalletList() {
    APIRepository().getDefaultWalletDropdownList().then((resp) {
      if (resp.success) {
        if (resp.data != null) {
          List<DefaultWallet> list = List<DefaultWallet>.from(resp.data!.map((x) => DefaultWallet.fromJson(x)));
          defaultWalletList = list;
          ///defaultWalletList.addAll(list);
        }
      }
    }, onError: (err) {});
  }

  // List<String> getDefaultWalletNames() {
  //   return defaultWalletList.map((e) {
  //     return (stringNullCheck(e.name)+ " " + "("+e.balance.toString()+ ")");
  //   }).toList();
  // }
  List<String> getDefaultWalletNames(List<DefaultWallet> list) {
    return list.map((e) {return (stringNullCheck(e.name)+ " " + "("+e.balance.toString()+ ")");}).toList();
  }

  GeneralSettings generalSettings = Get.find<RootController>().generalSettings.value;

  Rx<BuyCoinAndPhaseInformation> buyCoinAndPhaseInformation = BuyCoinAndPhaseInformation().obs;
  CoinHistoryResponse coinHistoryResponse = CoinHistoryResponse();

  RxList<CoinHistory> sendCoinHistoryList = <CoinHistory>[].obs;
  RxList<CoinHistory> receiveCoinHistoryList = <CoinHistory>[].obs;
  RxList<CoinHistory> pendingCoinHistoryList = <CoinHistory>[].obs;

  Coin? coin;

  bool checkRequestDefaultCoinInputValues(BuildContext context) {
    if (emailEditController.text.isEmpty) {
      showToast("Email address can not be empty".tr);
      return false;
    }
    if (amountEditController.text.isEmpty) {
      showToast("Amount can not be empty".tr);
      return false;
    }
    double amount = double.parse(amountEditController.text);
    double minAmount = generalSettings.settings!.minimumWithdrawalAmount ?? 0;
    double maxAmount = generalSettings.settings!.maximumWithdrawalAmount ?? 0;
    // if (amountEditController.text.isEmpty) {
    //   showToast("Amount_less_then".trParams({"amount": minAmount.toString()}));
    //   return false;
    // }
    if (amount < minAmount) {
      showToast("Amount_less_then".trParams({"amount": minAmount.toString()}));
      return false;
    }
    if (amount > maxAmount) {
      showToast(
          "Amount_greater_then".trParams({"amount": maxAmount.toString()}));
      return false;
    }
    // double minAmount = coin?.minimumWithdrawal ?? 0;
    // if (amountEditController.text.isEmpty) {
    //   showToast("Amount_less_then".trParams({"amount": minAmount.toString()}));
    //   return false;
    // }
    // var amount = double.parse(amountEditController.text);
    // if (amount < minAmount) {
    //   showToast("Amount_less_then".trParams({"amount": minAmount.toString()}));
    //   return false;
    // }
    // double maxAmount = coin?.maximumWithdrawal ?? 0;
    // if (amount > maxAmount) {
    //   showToast("Amount_greater_then".trParams({"amount": maxAmount.toString()}));
    //   return false;
    // }
    return true;
  }

  bool checkSendDefaultWalletCoinInputValues(BuildContext context) {
    if(selectedDefaultWalletType.value.isEmpty) {
      showToast("Wallet name can not be empty".tr, isError: true);
      return false;
    }
    if (amountEditController.text.isEmpty) {
      showToast("Amount can not be empty".tr);
      return false;
    }
    if (emailEditController.text.isEmpty) {
      showToast("Email address can not be empty".tr);
      return false;
    }
    double amount = double.parse(amountEditController.text);
    double minAmount = generalSettings.settings!.minimumWithdrawalAmount ?? 0;
    double maxAmount = generalSettings.settings!.maximumWithdrawalAmount ?? 0;
    if (amount < minAmount) {
      showToast("Amount_less_then".trParams({"amount": minAmount.toString()}));
      return false;
    }
    if (amount > maxAmount) {
      showToast(
          "Amount_greater_then".trParams({"amount": maxAmount.toString()}));
      return false;
    }
    return true;
  }

  void makeDefaultCoinRequest() {
    showLoadingDialog();
    APIRepository()
        .defaultCoinRequest(emailEditController.text, amountEditController.text)
        .then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        Get.back();
        clearView();
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void makeDefaultCoinSend() {
    showLoadingDialog();
    APIRepository().sendDefaultWalletCoinRequest(defaultWalletList.first.id, amountEditController.text, emailEditController.text)
        .then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        Get.back();
        clearView();
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }
}
