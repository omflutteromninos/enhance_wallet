import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/ui/features/auth/sign_in/sign_in_page.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController codeEditController = TextEditingController();
  TextEditingController emailEditController = TextEditingController();
  TextEditingController passEditController = TextEditingController();
  TextEditingController confirmPassEditController = TextEditingController();
  RxBool isShowPassword = false.obs;

  bool isValidPassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';

    String pattern2 = r'(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])\w+';
    RegExp regExp = new RegExp(pattern2);
    return regExp.hasMatch(value);
  }

  void isInPutDataValid(BuildContext context) {
    if (codeEditController.text.isNotEmpty &&
        passEditController.text.isNotEmpty &&
        confirmPassEditController.text.isNotEmpty) {
      // if (passEditController.text.length < DefaultValue.kPasswordLength) {
      //   showToast(
      //       "Password length must be"
      //           .trParams({"count": DefaultValue.kPasswordLength.toString()}),
      //       isError: true);
      //   return;
      // }

      if (!isValidPassword(passEditController.text)) {
        showToast(
            "Password_invalid_message"
                .trParams({"count": DefaultValue.kPasswordLength.toString()}),
            isError: true);
        return;
      }
      if (passEditController.text != confirmPassEditController.text) {
        showToast("Password and confirm password not matched".tr,
            isError: true);
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
    APIRepository()
        .resetPassword(emailEditController.text, codeEditController.text,
            passEditController.text, confirmPassEditController.text)
        .then((resp) {
      hideLoadingDialog();
      //GetUtils.printFunction("changePassword", resp, "resp");
      showToast(resp.message);
      if (resp.success) {
        Get.off(() => SignInPage());
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }
// void resetPassword() async {
//   if (emailController.text.toString().isEmpty ||
//       passwordController.text.toString().isEmpty ||
//       confirmPasswordController.text.toString().isEmpty ||
//       codeController.text.toString().isEmpty) {
//     Get.snackbar(
//       'Input Data'.tr,
//       'Input data is invalid'.tr,
//       colorText: Colors.white,
//       backgroundColor: Colors.red,
//     );
//     return;
//   }
//   try {
//     EasyLoading.show();
//     var response = await repository.resetPassword({
//       "email": emailController.text.toString(),
//       "token": codeController.text.toString(),
//       "password": passwordController.text.toString(),
//       "password_confirmation": confirmPasswordController.text.toString(),
//     });
//     if (response.success) {
//       EasyLoading.dismiss(animation: true);
//       ToastUtil.showLongToast(response.message ?? "Verification Done".tr);
//       Get.offAll(() =>SignIn());
//     } else {
//       EasyLoading.dismiss(animation: true);
//       ToastUtil.showShortToast(response.message ?? "server_error".tr);
//     }
//   } catch (e) {
//     EasyLoading.dismiss(animation: true);
//
//     logger.d(e);
//   }
// }

}
