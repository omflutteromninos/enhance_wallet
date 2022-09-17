import 'dart:async';
import 'dart:io';
import 'package:cPocket/data/models/buy_coin/bank.dart';
import 'package:cPocket/data/models/buy_coin/buy_coin_and_phase_information.dart';
import 'package:cPocket/data/models/buy_coin/buy_coin_history.dart';
import 'package:cPocket/data/models/buy_coin/buy_coin_rate.dart';
import 'package:cPocket/data/models/list_response.dart';
import 'package:cPocket/data/models/pocket_wallet/coin.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyCoinPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  TextEditingController amountEditController = TextEditingController();
  TextEditingController amountNonEditController = TextEditingController();
  TextEditingController nameOnCardEditController = TextEditingController();
  TextEditingController cardNumberEditController = TextEditingController();
  TextEditingController cardCVCEditController = TextEditingController();
  TextEditingController cardExpireMonthEditController = TextEditingController();
  TextEditingController cardExpireYearEditController = TextEditingController();

  Rx<BuyCoinRate> buyCoinRate = BuyCoinRate().obs;

  Rx<File> bankSlipImage = File("").obs;

  Timer? _debounce;

  Rx<BuyCoinAndPhaseInformation> buyCoinAndPhaseInformation = BuyCoinAndPhaseInformation().obs;
  Rx<ActivePhase> activePhase = ActivePhase().obs;
  BuyCoinAndPhaseInformation? buyCoinPaymentMethod;

  //Rx<GeneralSettings> generalSettings = GeneralSettings().obs;

  // RxList<dynamic> buyCoinHistoryList = <dynamic>[].obs;
  RxList<BuyCoinHistory> buyCoinHistoryList = <BuyCoinHistory>[].obs;

  bool isLoading = true;
  int loadedPage = 0;
  bool hasMoreData = true;

  RxString selectedCoin = "".obs;
  RxString selectedBank = "".obs;

  RxInt selectedPaymentType = 0.obs;

  //RxString selectedPaymentType = "".obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    selectedPaymentType.value = -1;
    super.onInit();
  }

  void clearView() {
    amountEditController.text = "";
    amountNonEditController.text = "";
    nameOnCardEditController.text = "";
    cardNumberEditController.text = "";
    cardCVCEditController.text = "";
    cardExpireMonthEditController.text = "";
    cardExpireYearEditController.text = "";
    selectedCoin.value = "";
    selectedBank.value = "";
    selectedPaymentType.value = -1;
    bankSlipImage.value = File("");
  }

  void initViewData() {
    selectedPaymentType.value = -1;
  }

  List<BuyCoinAndPhaseInformation> buyCoinPaymentMethodsList =
      <BuyCoinAndPhaseInformation>[];

  void onTextChanged(String amount) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      getBuyCoinRate();
    });
  }

  void checkSelection() {
    if (amountEditController.text.isEmpty) {
      amountEditController.text = 1.toString();
    }
    if (selectedCoin.value.isEmpty) {
      return;
    }
    if (selectedPaymentType.value == -1) {
      return;
    }
    getBuyCoinRate();
  }

  void getBuyCoinRate() {
    if (amountEditController.text == 0.toString()) {
      showToast("Please insert coin amount bigger than 0".tr, isError: true);
      return;
    }
    var pay = getPaymentTypeList()[selectedPaymentType.value];
    var key = buyCoinAndPhaseInformation.value.paymentMethods!.keys.firstWhere(
        (k) => buyCoinAndPhaseInformation.value.paymentMethods![k] == pay,
        orElse: () => "");

    showLoadingDialog();
    APIRepository()
        .getBuyCoinRate(amountEditController.text, selectedCoin.value, key)
        .then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        buyCoinRate.value = BuyCoinRate.fromJson(resp.data);
        //clearView();
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      showToast(err.toString());
    });
  }

  void getAllBuyCoinHistoryList(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      buyCoinHistoryList.clear();
      isLoading = false;
    }
    //if (isLoading) return;
    isLoading = true;
    loadedPage++;
    APIRepository().getBuyCoinHistoryList(loadedPage).then((resp) {
      isLoading = false;
      if (resp.success) {
        hideLoadingDialog();
        ListResponse response = ListResponse.fromJson(resp.data);
        if (response.data != null) {
          List<BuyCoinHistory> list = List<BuyCoinHistory>.from(response.data!.map((x) => BuyCoinHistory.fromJson(x)));
          buyCoinHistoryList.addAll(list);
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

  void getBuyCoinAndPhaseInformation() {
    showLoadingDialog();
    APIRepository().getBuyCoinAndPhaseInformation().then((resp) {
      hideLoadingDialog();
      if (resp.success) {
        buyCoinAndPhaseInformation.value = BuyCoinAndPhaseInformation.fromJson(resp.data);
        selectedCoin.value = buyCoinAndPhaseInformation.value.coins?.first.type ?? "";

        //setPrePaymentData();
        // if (resp.data != null) {
        //   List<BuyCoinAndPhaseInformation> list = List<BuyCoinAndPhaseInformation>.from(resp.data!.map((x) => BuyCoinAndPhaseInformation.fromJson(x)));
        //   buyCoinPaymentMethodsList..addAll(list);
        // }

        // clearView();
        // if (resp.data != null) {
        //   //List<Coin> coinList = List<Coin>.from(resp.data!.map((x) => Coin.fromJson(x)));
        //   List<Bank> bankList = List<Bank>.from(resp.data!.map((x) => Bank.fromJson(x)));
        //   //coinList.addAll(coinList);
        //   bankList.addAll(bankList);
        // }
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  List<Coin> coinList = <Coin>[];

  List<String> getCoinNameList() {
    if (buyCoinAndPhaseInformation.value.coins != null) {
      return buyCoinAndPhaseInformation.value.coins!
          .map((e) => e.type as String)
          .toList();
    }
    return [];
  }

  List<Bank> bankList = <Bank>[];

  List<String> getBankNameList() {
    if (buyCoinAndPhaseInformation.value.banks != null) {
      return buyCoinAndPhaseInformation.value.banks!
          .map((e) => e.bankName as String)
          .toList();
    }
    return [];
  }

  List<String> getPaymentTypeList() {
    if (buyCoinAndPhaseInformation.value.paymentMethods != null) {
      return buyCoinAndPhaseInformation.value.paymentMethods!.values.toList();
    }
    return [];
  }

  void getCoinList() {
    APIRepository().getPocketWalletCoinList().then((resp) {
      if (resp.success) {
        clearView();
        if (resp.data != null) {
          List<Coin> list =
              List<Coin>.from(resp.data!.map((x) => Coin.fromJson(x)));
          coinList.addAll(list);
        }
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void buyCoinCheckInputValues(BuildContext context) {
    if (selectedPaymentType.value == -1) {
      showToast("Please select your payment type".tr, isError: true);
      return;
    }
    if (amountEditController.text.isEmpty) {
      showToast("Coin amount can not be empty".tr);
      return;
    }
    if (amountEditController.text == 0.toString()) {
      showToast("Please insert coin amount bigger than 0".tr, isError: true);
      return;
    }

    var pay = getPaymentTypeList()[selectedPaymentType.value];
    var selectedPayType = buyCoinAndPhaseInformation.value.paymentMethods!.keys
        .firstWhere(
            (k) => buyCoinAndPhaseInformation.value.paymentMethods![k] == pay,
            orElse: () => "");

    if (selectedPayType == "1") {
      if (selectedCoin.value.isEmpty) {
        showToast("Coin name can not be empty".tr, isError: true);
        return;
      }
      makeBuyCoinByCoin(selectedPayType); // post the Buy Coin via Coin info to server
    } else if (selectedPayType == "4") {
      if (selectedBank.value.isEmpty) {
        showToast("Bank name can not be empty".tr, isError: true);
        return;
      }
      if (bankSlipImage.value.path.isEmpty) {
        showToast("Please upload your bank slip image".tr);
        return;
      }
      makeBuyCoinByBank(selectedPayType); // post the Buy Coin via Bank info to server
    } else if (selectedPayType == "5") {
      if (nameOnCardEditController.value.text.isEmpty) {
        showToast("Name On Card can not be empty".tr, isError: true);
        return;
      }
    }

  }

  void makeBuyCoinByCoin(String paymentType) {
    showLoadingDialog();
    APIRepository().buyCoinThroughAppByCoin(amountEditController.text, paymentType, selectedCoin.value).then((resp) {
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

  void makeBuyCoinByBank(String paymentType) {
    showLoadingDialog();
    var bank = buyCoinAndPhaseInformation.value.banks!.firstWhere((element) => element.bankName == selectedBank.value);

    APIRepository().buyCoinThroughAppByBank(amountEditController.text, paymentType, bank.id, 0, bankSlipImage.value).then(
        (resp) {
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

// bool byBankCheckInputValues(BuildContext context) {
//   if (selectedPaymentType.value.toString().isEmpty) {
//     showToast("Payment type name can not be empty".tr, isError: true);
//     return false;
//   }
//   if (selectedBank.value.isEmpty) {
//     showToast("Bank name can not be empty".tr, isError: true);
//     return false;
//   }
//   if (amountEditController.text.isEmpty) {
//     showToast("Coin amount can not be empty".tr);
//     return false;
//   }
//   if(amountEditController.text == 0.toString()){
//     showToast("Please insert coin amount bigger than 0".tr, isError: true);
//     return false;
//   }
//   return true;
// }
}
