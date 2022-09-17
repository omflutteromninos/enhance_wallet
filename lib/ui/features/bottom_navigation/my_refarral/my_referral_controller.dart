import 'dart:ui';
import 'package:cPocket/data/models/my_refferal.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyReferralController extends GetxController{

  RxList<Reference> referenceList = <Reference>[].obs;
  bool isLoadingReference = true;
  RxList<Earning> earningsList = <Earning>[].obs;
  bool isLoadingEarnings = true;

  RxString referralLink = "".obs;
  RxMap<String, int>  referralLevel = <String, int>{}.obs;


  void getReferralLink() {
    APIRepository().getReferralLink().then((resp) {
      if (resp.success) {
        referralLink.value = resp.data[APIConstants.kUrl];
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      showToast(err.toString());
    });
  }

  void getReferralAndReference() {
    //showLoadingDialog();
    APIRepository().getReferralAndReference().then((resp) {
      //hideLoadingDialog();
      isLoadingReference = false;
      if (resp.success) {
        MyReferral referral = MyReferral.fromJson(resp.data);
        referralLevel.value = referral.referralLevel ?? {};
        referenceList.value = referral.referral ?? [];
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      isLoadingReference = false;
      //hideLoadingDialog();
      showToast(err.toString());
    });
  }



  void getEarning() {
    earningsList.clear();
    showLoadingDialog();
    APIRepository().getEarning(false).then((resp) {
      hideLoadingDialog();
      isLoadingEarnings = false;
      if (resp.success) {
        if(resp.data != null){
          List<Earning> list = List<Earning>.from(resp.data!.map((x) => Earning.fromJson(x)));
          earningsList.addAll(list);
          if(earningsList.isNotEmpty) {
            earningsList.insert(0, Earning(totalAmount: null, yearMonth: null));
          }
        }
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      isLoadingEarnings = false;
      hideLoadingDialog();
      showToast(err.toString());
    });
  }



  //
  // List<int>? myReferralList = <int>[1,2,3,4].obs;
  // List<int>? sellAllMyReferralList = <int>[1,2,3,4,5,6,7,8,9,10,11].obs;
  //
  // List<int>? myReferencesList = <int>[1,2,3,4].obs;
  // List<int>? sellAllMyReferencesList = <int>[1,2,3,4,5,6,7,8,9,10,11].obs;
  //
  // List<int>? myEarningsList = <int>[1,2,3,4].obs;
  // List<int>? sellAllMyEarningsList = <int>[1,2,3,4,5,6,7,8,9,10,11].obs;
  //
  // TabController? tabController;
  // List<int>? depositList = <int>[1,2,3,4].obs;
  // List<int>? withdrawList =      <int>[1,2,3,4,5].obs;
  // List<int>? seeAllList = <int>[1,2,3,4,5,6,7,8,9,10].obs;
  // int sectionCount = 0;
  //
  // @override
  // void onInit() {
  //   tabController = TabController(vsync: this, length: 3);
  //   super.onInit();
  // }


}