import 'dart:async';

import 'package:cPocket/ui/features/auth/sign_in/sign_in_page.dart';
import 'package:cPocket/ui/features/root/root_page.dart';
import 'package:cPocket/utils/alert_bar.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/network_check_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    NetworkCheck.isOnline().then((value) {
      if (value) {
        Future.delayed(const Duration(seconds: 2), () {
          var loggedIn = GetStorage().read(PreferenceKey.isLoggedIn);
          print(loggedIn);
          loggedIn ? Get.off(() => const RootPage()) : Get.off(() => const SignInPage());
        });
      }
    });

  }

}