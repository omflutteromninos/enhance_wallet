import 'package:cPocket/data/models/list_response.dart';
import 'package:cPocket/data/models/send_receive_pending_coin/approval_action_for_coin_request.dart';
import 'package:cPocket/data/models/send_receive_pending_coin/coin_history_response.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isLoading = true;
  int loadedPage = 0;
  bool hasMoreData = true;

  String coinName = "";

  Rx<ApprovalActionForCoinRequest> approvalActionForCoinRequest =
      ApprovalActionForCoinRequest().obs;
  CoinHistoryResponse coinHistoryResponse = CoinHistoryResponse();

  RxList<CoinHistory> sendCoinHistoryList = <CoinHistory>[].obs;
  RxList<CoinHistory> receiveCoinHistoryList = <CoinHistory>[].obs;
  RxList<CoinHistory> requestPendingCoinHistoryList = <CoinHistory>[].obs;

  void getAllSendCoinHistoryList(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      sendCoinHistoryList.clear();
      isLoading = false;
    }
    isLoading = true;
    loadedPage++;
    APIRepository().getSendCoinHistoryList(loadedPage).then((resp) {
      isLoading = false;
      if (resp.success) {
        coinName = resp.data['coin_name'];

        ListResponse response =
            ListResponse.fromJson(resp.data['coin_history']);
        if (response.data != null) {
          List<CoinHistory> list = List<CoinHistory>.from(
              response.data!.map((x) => CoinHistory.fromJson(x)));
          sendCoinHistoryList.addAll(list);
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

  void getAllReceiveCoinHistoryList(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      receiveCoinHistoryList.clear();
      isLoading = false;
    }
    isLoading = true;
    loadedPage++;
    APIRepository().getReceiveCoinHistoryList(loadedPage).then((resp) {
      isLoading = false;
      if (resp.success) {
        coinName = resp.data['coin_name'];
        ListResponse response =
            ListResponse.fromJson(resp.data['receive_coin_list']);
        if (response.data != null) {
          List<CoinHistory> list = List<CoinHistory>.from(
              response.data!.map((x) => CoinHistory.fromJson(x)));
          receiveCoinHistoryList.addAll(list);
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

  void getAllRequestPendingCoinHistoryList(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      requestPendingCoinHistoryList.clear();
      isLoading = false;
    }
    isLoading = true;
    loadedPage++;
    APIRepository().getPendingCoinHistoryList(loadedPage).then((resp) {
      isLoading = false;
      if (resp.success) {
        coinName = resp.data['coin_name'];
        ListResponse response =
            ListResponse.fromJson(resp.data['pending_history']);
        if (response.data != null) {
          List<CoinHistory> list = List<CoinHistory>.from(
              response.data!.map((x) => CoinHistory.fromJson(x)));
          requestPendingCoinHistoryList.addAll(list);
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

  String? isAcceptOrReject;

  void actionForCoinRequest(isAccept, CoinHistory coinHistory) {
    isAccept == true
        ? isAcceptOrReject = "accept"
        : isAcceptOrReject = "reject";
    showLoadingDialog();
    APIRepository()
        .approvalActionForCoinRequest(coinHistory.id, isAcceptOrReject!)
        .then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        requestPendingCoinHistoryList.remove(coinHistory);
        showToast(resp.message);
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      showToast(err.toString());
    });
  }
}
