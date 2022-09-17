import 'dart:io';

import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPageController extends GetxController {
  TextEditingController currentPassEditController = TextEditingController();
  TextEditingController passEditController = TextEditingController();
  TextEditingController confirmPassEditController = TextEditingController();
  RxBool isShowPassword = false.obs;

  void clearInputData(){
    currentPassEditController.text = "";
    passEditController.text = "";
    confirmPassEditController.text = "";
    isShowPassword.value = false;
  }

  void isInPutDataValid(BuildContext context) {
    if (currentPassEditController.text.isNotEmpty && passEditController.text.isNotEmpty &&
        confirmPassEditController.text.isNotEmpty) {

      if (!isValidPassword(passEditController.text)) {
        showToast("Password_invalid_message".trParams({"count": DefaultValue.kPasswordLength.toString()}), isError: true, isLong: true);
        return;
      }
      if (passEditController.text != confirmPassEditController.text) {
        showToast("Password and confirm password not matched".tr, isError: true);
        return;
      }
      hideKeyboard(context);
      changePassword();
    } else {
      showToast("Fields can't be empty".tr, isError: true);
    }
  }

  void changePassword() {
    showLoadingDialog();
    APIRepository().changePassword(currentPassEditController.text, passEditController.text).then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        Get.back();
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

}
