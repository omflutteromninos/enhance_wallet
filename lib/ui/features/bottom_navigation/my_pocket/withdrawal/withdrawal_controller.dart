import 'package:cPocket/data/models/pocket_wallet/coin.dart';
import 'package:cPocket/data/models/pocket_wallet/pocket_wallet.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/alert_dialog_util.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../my_pocket_controller.dart';

class WithdrawalController extends GetxController {
  TextEditingController addressEditController = TextEditingController();
  TextEditingController amountEditController = TextEditingController();
  TextEditingController noteEditController = TextEditingController();
  TextEditingController codeEditController = TextEditingController();
  final generalSettings = getGeneralSettingsLocal();
  Coin? coin;
  List<Coin> coinList = <Coin>[];

  void clearView(){
    addressEditController.text = "";
    amountEditController.text = "";
    noteEditController.text = "";
    codeEditController.text = "";
  }

  // void setCoin(PocketWallet pocketWallet) {
  //   var coins = Get.find<MyPocketController>().coinList;
  //   coin = coins.firstWhere((element) => element.type == pocketWallet.coinType);
  // }
  //
  // void getCoinList() {
  //   APIRepository().getPocketWalletCoinList().then((resp) {
  //     if (resp.success) {
  //       if (resp.data != null) {
  //         List<Coin> list = List<Coin>.from(resp.data!.map((x) => Coin.fromJson(x)));
  //         coinList.addAll(list);
  //       }
  //     }
  //   }, onError: (err) {});
  // }

  bool checkWithdrawCondition() {
    var user =  Get.find<RootController>().userRx.value;
    if(user.google2FaSecret == null || user.google2FaSecret!.isEmpty){
      alertForSet2FA(user);
      return false;
    }
    return true;
  }

  bool checkInputValues(BuildContext context){
    if (addressEditController.text.isEmpty) {
      showToast("Address can not be empty".tr);
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



    //
    // double minAmount = generalSettings?.settings?.minimumWithdrawalAmount ?? 0;
    // if (amountEditController.text.isEmpty) {
    //   showToast("Amount can not be empty".tr);
    //   return false;
    // }
    // var amount = double.parse(amountEditController.text);
    // if (amount < minAmount) {
    //   showToast("Amount_less_then".trParams({"amount" : minAmount.toString()}));
    //   return false;
    // }
    // double maxAmount = generalSettings?.settings?.maximumWithdrawalAmount ?? 0;
    // if (amount > maxAmount){
    //   showToast("Amount_greater_then".trParams({"amount" : maxAmount.toString()}));
    //   return false;
    // }
    return true;
  }

  void makeWithdraw(PocketWallet pocketWallet) {
    if(codeEditController.text.length < DefaultValue.kCodeLength) {
      showToast("Code length must be".trParams({"count" : DefaultValue.kCodeLength.toString()}), isError: true);
      return;
    }
    showLoadingDialog();
    APIRepository().withdrawProcess(pocketWallet.id, codeEditController.text, addressEditController.text,
       amountEditController.text, noteEditController.text).then(
        (resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        Get.back();
        clearView();
        Get.find<MyPocketController>().updateAWallet(pocketWallet);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }
}
