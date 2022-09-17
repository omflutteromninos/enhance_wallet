import 'dart:ui';
import 'package:cPocket/data/models/pocket_wallet/past_address.dart';
import 'package:cPocket/data/models/pocket_wallet/pocket_wallet.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepositWalletPageController extends GetxController with GetSingleTickerProviderStateMixin{

  bool isLoading = false;

  Rx<PocketWallet> pocketWalletRx = PocketWallet(id: 0).obs;

  RxString currentAddress = "".obs;
  Rx<PastAddress> pastAddress = PastAddress(isDataLoaded: false).obs;

  void getWalletAddress(PocketWallet pocketWallet) {
    showLoadingDialog();
    APIRepository().getWalletAddress(pocketWallet.id).then((resp) {
      hideLoadingDialog();
      if (resp.success) {
        currentAddress.value = resp.data[APIConstants.kAddress];
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void generateNewAddress(PocketWallet pocketWallet) {
    showLoadingDialog();
    APIRepository().generateNewAddress(pocketWallet.id).then((resp) {
      hideLoadingDialog();
      if (resp.success) {
        currentAddress.value = resp.data[APIConstants.kAddress];
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void getPastAddresses(PocketWallet pocketWallet) {
    isLoading = true;
    pastAddress.value = PastAddress();
    //showLoadingDialog();
    APIRepository().getPassAddress(pocketWallet.id).then((resp) {
      //hideLoadingDialog();
      isLoading = false;
      if (resp.success) {
        var past = PastAddress.fromJson(resp.data);
        past.isDataLoaded = true;
        pastAddress.value = past;
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

}