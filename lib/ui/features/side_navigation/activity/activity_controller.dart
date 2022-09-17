import 'dart:ui';
import 'package:cPocket/data/models/activity.dart';
import 'package:cPocket/data/models/list_response.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList<Activity> activityList = <Activity>[].obs;
  bool isLoading = false;
  int loadedPage = 0;
  bool hasMoreData = true;

  void getActivityList({required bool isFromLoadMore}) {
    print("hasMoreData $hasMoreData");
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      activityList.clear();
    }
    if (isLoading) return;

    isLoading = true;
    loadedPage++;
    APIRepository().getActivityList(loadedPage).then((resp) {
      isLoading = false;
      if (resp.success) {
        ListResponse listResponse = ListResponse.fromJson(resp.data);
        List<Activity> list = [];
        if (listResponse.data != null) {
          list = List<Activity>.from(listResponse.data!.map((e) => Activity.fromJson(e)));
        }
        loadedPage = listResponse.currentPage ?? 0;
        hasMoreData = listResponse.nextPageUrl != null;
        activityList.addAll(list);
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      isLoading = false;
      showToast(err.toString());
    });
  }

// List<int>? myReferralList = <int>[1, 2, 3, 4].obs;
// List<int>? sellAllMyReferralList =
//     <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].obs;
//
// List<int>? myReferencesList = <int>[1, 2, 3, 4].obs;
// List<int>? sellAllMyReferencesList =
//     <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].obs;
//
// List<int>? myEarningsList = <int>[1, 2, 3, 4].obs;
// List<int>? sellAllMyEarningsList =
//     <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].obs;
//
// TabController? tabController;
// List<int>? depositList = <int>[1, 2, 3, 4].obs;
// List<int>? withdrawList = <int>[1, 2, 3, 4, 5].obs;
// List<int>? seeAllList = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].obs;
// int sectionCount = 0;
//
// @override
// void onInit() {
//   tabController = TabController(vsync: this, length: 3);
//   super.onInit();
// }
}
