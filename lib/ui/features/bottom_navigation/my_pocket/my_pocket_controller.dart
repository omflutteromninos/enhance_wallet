import 'dart:ui';
import 'package:cPocket/data/models/list_response.dart';
import 'package:cPocket/data/models/pocket_wallet/coin.dart';
import 'package:cPocket/data/models/pocket_wallet/pocket_wallet.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:collection/collection.dart";

class MyPocketController extends GetxController {
  bool isLoading = true;
  int loadedPage = 0;
  bool hasMoreData = true;
  List<PocketWallet> pocketWalletList = <PocketWallet>[];
  List<Coin> coinList = <Coin>[];
  RxMap<String, List<PocketWallet>> myPocketWalletGroupList = <String, List<PocketWallet>>{}.obs;
  TextEditingController nameEditController = TextEditingController();
  RxString selectedCoinType = "".obs;

  void clearAddView(){
    nameEditController.text = "";
    selectedCoinType.value = "";
  }

  void getWalletList(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      pocketWalletList.clear();
    }
    isLoading = true;
    loadedPage++;
    APIRepository().getPocketWalletList(loadedPage).then((resp) {
      isLoading = false;
      if (resp.success) {
        ListResponse response = ListResponse.fromJson(resp.data);
        if (response.data != null) {
          List<PocketWallet> list = List<PocketWallet>.from(response.data!.map((x) => PocketWallet.fromJson(x)));
          pocketWalletList.addAll(list);
        }
        loadedPage = response.currentPage ?? 0;
        hasMoreData = response.nextPageUrl != null;
        setData();
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      isLoading = false;
      showToast(err.toString());
    });
  }


  void setData() {
    myPocketWalletGroupList.clear();
    var newMap = groupBy(pocketWalletList, (PocketWallet obj) => formatDate(obj.createdAt == null ? null :  obj.createdAt!, format: dateFormatMMMMDdDyyy));
    myPocketWalletGroupList.value =  newMap;
  }

  void getCoinList() {
    APIRepository().getPocketWalletCoinList().then((resp) {
      if (resp.success) {
        if (resp.data != null) {
          List<Coin> list = List<Coin>.from(resp.data!.map((x) => Coin.fromJson(x)));
          coinList.addAll(list);
        }
      }
    }, onError: (err) {});
  }


  List<String> getCoinNames() {
    return coinList.map((e) => e.type ?? "").toList();
  }


  void addWallet(BuildContext context) {
    if(nameEditController.text.isEmpty) {
      showToast("Wallet name can not be empty".tr, isError: true);
      return;
    }
    if(selectedCoinType.value.isEmpty) {
      showToast("Coin can not be empty".tr, isError: true);
      return;
    }
    hideKeyboard(context);
    showLoadingDialog();
    var coin = coinList.firstWhere((element) => element.type == selectedCoinType.value);
    APIRepository().addWallet(nameEditController.text,coin.type!).then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if(resp.success) {
        Get.back();
        clearAddView();
        pocketWalletList.add(PocketWallet.fromJson(resp.data));
        setData();
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void updateAWallet(PocketWallet pocketWallet) {
    APIRepository().getAWallet(pocketWallet.id).then((resp) {
      if(resp.success) {
        PocketWallet updateWallet = PocketWallet.fromJson(resp.data[APIConstants.kWalletDetails]);
        var index = pocketWalletList.indexWhere((element) => element.id == pocketWallet.id);
        pocketWalletList[index] = updateWallet;
        setData();
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }
}

