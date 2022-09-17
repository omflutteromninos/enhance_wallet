import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/ui/features/auth/email_verify/email_verify_page.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController firstNameEditController = TextEditingController();
  TextEditingController lastNameEditController = TextEditingController();
  TextEditingController emailEditController = TextEditingController();
  TextEditingController passEditController = TextEditingController();
  TextEditingController confirmPassEditController = TextEditingController();
  RxBool isShowPassword = false.obs;

  void clearInputData() {
    emailEditController.text = "";
    passEditController.text = "";
    isShowPassword = false.obs;
  }

  void isInPutDataValid() {
    if (firstNameEditController.text.isNotEmpty &&
        lastNameEditController.text.isNotEmpty &&
        emailEditController.text.isNotEmpty &&
        passEditController.text.isNotEmpty &&
        confirmPassEditController.text.isNotEmpty) {
      if (!GetUtils.isEmail(emailEditController.text)) {
        showToast("Please Input a valid Email".tr, isError: true);
        return;
      }
      if (!isValidPassword(passEditController.text)) {
        showToast(
            "Password_invalid_message"
                .tr
                .trParams({"count": DefaultValue.kPasswordLength.toString()}),
            isError: true);
        return;
      }
      // if (passEditController.text.length < DefaultValue.kPasswordLength) {
      //   showToast(
      //       "Password length must be"
      //           .trParams({"count": DefaultValue.kPasswordLength.toString()}),
      //       isError: true);
      //   return;
      // }
      if (passEditController.text != confirmPassEditController.text) {
        showToast("Password and confirm password not matched".tr,
            isError: true);
        return;
      }
      //hideKeyboard(context);
      signUp();
    } else {
      showToast("Fields can not be empty".tr, isError: true);
    }
  }

  void signUp() {
    showLoadingDialog();
    APIRepository()
        .registerUser(
            firstNameEditController.text, lastNameEditController.text, emailEditController.text, passEditController.text, confirmPassEditController.text)
        .then((response) {
      hideLoadingDialog();
      showToast(response.message);
      if (response.success) {
        Get.off(() => EmailVerifyPage(emailEditController.text));
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }
}
