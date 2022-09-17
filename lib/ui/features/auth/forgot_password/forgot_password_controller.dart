import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/ui/features/auth/reset_password/reset_password_page.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailEditController = TextEditingController();

  void isInPutDataValid(BuildContext context) {
    if (!GetUtils.isEmail(emailEditController.text)) {
      showToast("Please Input a valid Email".tr, isError: true);
      return;
    }
    hideKeyboard(context);
    forgetPassword();
  }

  void forgetPassword() {
    showLoadingDialog();
    APIRepository().forgetPassword(emailEditController.text).then((resp) {
      hideLoadingDialog();
      //GetUtils.printFunction("forgetPassword", resp, "resp");
      showToast(resp.message);
      if (resp.success) {
        Get.off(() => ResetPasswordPage(email: emailEditController.text));
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

//
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

// void forgetPassword() async {
//   if (emailController.text.toString().isEmpty) {
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
//     var response = await repository.forGotPassword({
//       "email": emailController.text.toString(),
//     });
//     if (response.success) {
//       EasyLoading.dismiss(animation: true);
//       ToastUtil.showLongToast(response.message ?? "Verification Done".tr);
//       Get.to(() =>ResetPasswordScreen(email: emailController.text.toString()));
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
