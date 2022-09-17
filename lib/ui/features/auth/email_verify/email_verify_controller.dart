import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../signup_success_page.dart';

class EmailVerifyController extends GetxController {
  TextEditingController emailEditController = TextEditingController();
  TextEditingController codeEditController = TextEditingController();

  //void isInPutDataValid(String registrationId,BuildContext context) {
  void isInPutDataValid(BuildContext context) {
    if (codeEditController.text.length < DefaultValue.kCodeLength) {
      showToast(
          "Code length must be"
              .trParams({"count": DefaultValue.kCodeLength.toString()}),
          isError: true);
      return;
    }
    hideKeyboard(context);
    //verifyCode(registrationId);
    verifyCode();
  }

  //void verifyCode(String registrationId) {
  void verifyCode() {
    showLoadingDialog();
    APIRepository().verifyEmail(emailEditController.text, codeEditController.text).then(
        (resp) {
      hideLoadingDialog();
      //GetUtils.printFunction("verifyCode", resp, "resp");
      showToast(resp.message);
      if (resp.success) {
        Get.off(() => SignUpSuccessPage());
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  // void resendVerificationCode(String registrationId) {
  //   showLoadingDialog();
  //   APIRepository().resendVerificationCode(registrationId).then((resp) {
  //     hideLoadingDialog();
  //     showToast(resp.message);
  //   }, onError: (err) {
  //     hideLoadingDialog();
  //     showToast(err.toString());
  //   });
  // }


  void resendVerificationCode(registrationId) {
    showLoadingDialog();
    APIRepository().resendVerificationCode(emailEditController.text).then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

}
