import 'package:cPocket/data/models/default_wallet.dart';
import 'package:cPocket/data/models/general_settings.dart';
import 'package:cPocket/data/models/list_response.dart';
import 'package:cPocket/data/models/membership/all_membership_plans.dart';
import 'package:cPocket/data/models/membership/membership_bonus_history.dart';
import 'package:cPocket/data/models/membership/membership_details.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembershipClubPageController extends GetxController with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  TextEditingController amountClubEditController = TextEditingController();
  TextEditingController amountMainEditController = TextEditingController();

  GeneralSettings generalSettings = Get.find<RootController>().generalSettings.value;


  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }

  void clearView() {
    amountClubEditController.text = "";
    amountMainEditController.text = "";
    selectedDefaultWalletTypeForClub.value = "";
    selectedDefaultWalletTypeForMain.value = "";
    // defaultWalletListForClub = [];
    // defaultWalletListForMain = [];
  }

  List<DefaultWallet> defaultWalletList = <DefaultWallet>[];
  RxString selectedDefaultWalletTypeForClub = "".obs;
  RxString selectedDefaultWalletTypeForMain = "".obs;

  // List<String> getDefaultWalletNames(List<DefaultWallet> list) {
  //   return list.map((e) {
  //     return (stringNullCheck(e.name) + " " + "(" + e.balance.toString() + ")");
  //   }).toList();
  // }
  List<String> getDefaultWalletNames() {
    return defaultWalletList.map((e) {
      return (stringNullCheck(e.name) + " " + "(" + e.balance.toString() + ")");
    }).toList();
  }

  void getDefaultWalletListForClub() {
    APIRepository().getDefaultWalletDropdownList().then((resp) {
      if (resp.success) {
        if (resp.data != null) {
          List<DefaultWallet> list = List<DefaultWallet>.from(resp.data!.map((x) => DefaultWallet.fromJson(x)));
          ///defaultWalletListForClub.addAll(list);
          defaultWalletList = list;
        }
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {});
  }

  void getDefaultWalletListForMain() {
    APIRepository().getDefaultWalletDropdownList().then((resp) {
      if (resp.success) {
        if (resp.data != null) {
          List<DefaultWallet> list = List<DefaultWallet>.from(resp.data!.map((x) => DefaultWallet.fromJson(x)));
          ///defaultWalletListForMain.addAll(list);
          defaultWalletList = list;
        }
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {});
  }

  bool checkTransferCoinInputValuesForClub(BuildContext context) {
    if (selectedDefaultWalletTypeForClub.value.isEmpty) {
      showToast("Wallet name can not be empty".tr, isError: true);
      return false;
    }
    if (amountClubEditController.text.isEmpty) {
      showToast("Coin amount can not be empty".tr);
      return false;
    }
    return true;
  }

  bool checkTransferCoinInputValuesForMain(BuildContext context) {
    if (amountMainEditController.text.isEmpty) {
      showToast("Coin amount can not be empty".tr);
      return false;
    }
    if (selectedDefaultWalletTypeForMain.value.isEmpty) {
      showToast("Wallet name can not be empty".tr, isError: true);
      return false;
    }
    return true;
  }

  void makeTransferCoinToClubWallet() {
    showLoadingDialog();
    APIRepository()
        .sendTransferCoinToClubWallet(
            defaultWalletList.first.id, amountClubEditController.text)
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

  void makeTransferCoinToMainWallet() {
    showLoadingDialog();
    APIRepository()
        .sendTransferCoinToMainWallet(defaultWalletList.first.id, amountMainEditController.text)
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

  //Rx<GeneralSettings> generalSettings = GeneralSettings().obs;
  RxList<dynamic> membershipPlanList = <dynamic>[].obs;

  void getAllMembershipPlanList() {
    showLoadingDialog(isDismissible: true);
    APIRepository().getAllMembershipPlanList().then((resp) {
      isLoading = false;
      membershipPlanList.clear();
      if (resp.success) {
        hideLoadingDialog();
        try {
          List<AllMembershipPlans> list = List<AllMembershipPlans>.from(
              resp.data.map((x) => AllMembershipPlans.fromJson(x)));
          membershipPlanList.addAll(list);
        } catch (e) {
          printError();
        }
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      isLoading = false;
      showToast(err.toString());
    });
  }

  Rx<MembershipDetails> membershipDetails = MembershipDetails(id: 0).obs;

  //final MembershipDetails membershipDetailsData;

  void getMembershipDetails() {
    showLoadingDialog(isDismissible: true);
    APIRepository().getMembershipDetails().then((resp) {
      if (resp.success) {
        hideLoadingDialog();
        membershipDetails.value = MembershipDetails.fromJson(resp.data);
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      showToast(err.toString());
    });
  }

  //RxList<MembershipBonusHistory> membershipBonusHistoryList = <MembershipBonusHistory>[].obs;
  RxList<dynamic> membershipBonusHistoryList = <dynamic>[].obs;
  MembershipBonusHistory? membershipBonusHistoryResponse;
  bool isLoading = true;

  // void getAllMembershipBonusHistoryList() {
  //   //showLoadingDialog(isDismissible: true);
  //   APIRepository().getMembershipBonusHistoryList().then((resp) {
  //     isLoading = false;
  //     membershipBonusHistoryList.clear();
  //     if (resp.success) {
  //       MembershipBonusHistory membershipBonusHistory = MembershipBonusHistory.fromJson(resp.data);
  //       if (membershipBonusHistory.wallet!.user != null) {
  //          membershipBonusHistoryResponse = membershipBonusHistory;
  //          membershipBonusHistoryList.addAll(membershipBonusHistoryResponse!.wallet!.user);
  //       }
  //     } else {
  //       showToast(resp.message);
  //     }
  //   }, onError: (err) {
  //     isLoading = false;
  //     showToast(err.toString());
  //   });
  // }
  void get5MembershipBonusHistoryList() {
    isLoading = true;
    membershipBonusHistoryList.clear();
    APIRepository().getMembershipBonusHistoryList(1, false).then((resp) {
      isLoading = false;
      if (resp.success) {
        ListResponse response = ListResponse.fromJson(resp.data);
        if (response.data != null) {
          List<MembershipBonusHistory> list = List<MembershipBonusHistory>.from(response.data!.map((x) => MembershipBonusHistory.fromJson(x)));
          membershipBonusHistoryList.addAll(list);
        }
      } else {
        showToast(resp.message,isError: true);
        membershipBonusHistoryList.value = <MembershipBonusHistory>[];
      }
    }, onError: (err) {
      isLoading = false;
      showToast(err.toString());
      membershipBonusHistoryList.value = <MembershipBonusHistory>[];
    });
  }
}
