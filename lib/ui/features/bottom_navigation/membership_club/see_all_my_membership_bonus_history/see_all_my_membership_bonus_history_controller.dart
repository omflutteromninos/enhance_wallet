
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

class SeeAllMyMembershipBonusHistoryController extends GetxController {

  RxList<dynamic> membershipBonusHistoryList = <dynamic>[].obs;
  MembershipBonusHistory? membershipBonusHistoryResponse;
  bool isLoading = true;
  int loadedPage = 0;
  bool hasMoreData = true;

  void getAllMembershipBonusHistoryList(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      membershipBonusHistoryList.clear();
      isLoading = false;
    }
    isLoading = true;
    loadedPage++;
    APIRepository().getMembershipBonusHistoryList(loadedPage, true).then((resp) {
      isLoading = false;
      if (resp.success) {
        ListResponse response = ListResponse.fromJson(resp.data);
        if (response.data != null) {
          List<MembershipBonusHistory> list = List<MembershipBonusHistory>.from(response.data!.map((x) => MembershipBonusHistory.fromJson(x)));
          membershipBonusHistoryList.addAll(list);
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
}
