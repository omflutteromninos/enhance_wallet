import 'dart:io';

import 'package:cPocket/data/models/faq.dart';
import 'package:cPocket/data/models/list_response.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQPageController extends GetxController {

  List<FAQ> faqList = <FAQ>[].obs;
  bool isLoading = true;
  int loadedPage = 0;
  bool hasMoreData = true;

  void getFAQList(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      faqList.clear();
      isLoading = false;
    }
    isLoading = true;
    loadedPage++;
    APIRepository().getFAQList(loadedPage).then((resp) {
      isLoading = false;
      if (resp.success) {
        ListResponse response = ListResponse.fromJson(resp.data);
        if (response.data != null) {
          List<FAQ> list = List<FAQ>.from(response.data!.map((x) => FAQ.fromJson(x)));
          faqList.addAll(list);
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

}
