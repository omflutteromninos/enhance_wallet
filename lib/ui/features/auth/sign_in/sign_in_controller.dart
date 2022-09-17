import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/ui/features/root/root_page.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/image_util.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/alert_dialog_util.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignInController extends GetxController {
  TextEditingController emailEditController = TextEditingController();
  TextEditingController passEditController = TextEditingController();
  TextEditingController codeEditController = TextEditingController();

  RxBool isShowPassword = false.obs;

  void clearInputData() {
    emailEditController.text = "";
    passEditController.text = "";
    isShowPassword = false.obs;
  }

  void isInPutDataValid(BuildContext context) {
    if (emailEditController.text.isNotEmpty &&
        passEditController.text.isNotEmpty) {
      if (!GetUtils.isEmail(emailEditController.text)) {
        showToast("Please Input a valid Email".tr, isError: true);
        return;
      }
      if (passEditController.text.length < DefaultValue.kPasswordLength) {
        showToast(
            "Password length must be"
                .tr
                .trParams({"count": DefaultValue.kPasswordLength.toString()}),
            isError: true);
        return;
      }
      hideKeyboard(context);
      loginUser();
    } else {
      showToast("Fields can not be empty".tr, isError: true);
    }
  }

  // void loginUser(BuildContext context) {
  //   showLoadingDialog();
  //   APIRepository()
  //       .loginUser(
  //     emailEditController.text,
  //     passEditController.text,
  //   )
  //       .then((resp) {
  //     hideLoadingDialog();
  //     if (resp.success) {
  //       GetStorage().write(PreferenceKey.accessToken, resp.data[APIConstants.kAccessToken] ?? "");
  //       if (resp.data[APIConstants.kG2faVerify]) {
  //         showModalSheetFullScreen(input2FACode(context), context, onClose: () {
  //           codeEditController.text = "";
  //         });
  //       } else {
  //         showToast(resp.message);
  //         handleLoginSuccess(resp);
  //       }
  //     } else {
  //       if (resp.message ==
  //           "Your email is not verified yet. Please verify your mail.") {
  //         alertForVerifyAccount(emailEditController.text);
  //       } else {
  //         showToast(resp.message);
  //       }
  //     }
  //   }, onError: (err) {
  //     hideLoadingDialog();
  //     showToast(err.toString());
  //   });
  // }

  Widget input2FACode(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: dp10, horizontal: dp10),
      margin: const EdgeInsets.symmetric(vertical: dp16, horizontal: dp16),
      decoration: boxDecorationRoundCorner(),
      child: Column(
        children: [
          const SizedBox(height: dp10),
          googleAuthenticationIconBox(
              iconPath: AssetConstants.ic_google_authenticator_logo_png),
          //iconWithTap(AssetConstants.ic_google_authenticator_logo_png, size: Get.width / 4),
          VSpacer10(),
          textAutoSize("Google Authenticator sign in message".tr,
              fontSize: dp14,
              fontWeight: FontWeight.w100,
              maxLines: 3,
              textAlign: TextAlign.center),
          VSpacer10(),
          textAutoSize("Code".tr,
              fontSize: dp10, fontWeight: FontWeight.normal),
          textFieldBorderedWithSuffixIcon(
              codeEditController, "Your Code".tr, TextInputType.number),
          VSpacer10(),
          buttonRoundedFill("Sign In".tr, () {
            hideKeyboard(context);
            verifyGoogleCodeLogin();
          }),
        ],
      ),
    );
  }

  void verifyGoogleCodeLogin() {
    if (codeEditController.text.length < DefaultValue.kCodeLength) {
      showToast(
          "Code length must be"
              .trParams({"count": DefaultValue.kCodeLength.toString()}),
          isError: true);
      return;
    }
    showLoadingDialog();
    APIRepository().verify2FACodeLogin(codeEditController.text).then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        Get.back();
        handleLoginSuccess(resp);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void handleLoginSuccess(dynamic resp) {
    var userMap = resp.data[APIConstants.kUser];
    GetStorage().write(PreferenceKey.userObject, userMap);
    GetStorage().write(PreferenceKey.isLoggedIn, true);
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.off(() => const RootPage());
    });
  }

void loginUser() {
  showLoadingDialog();
  APIRepository()
      .loginUser(emailEditController.text, passEditController.text)
      .then((resp) {
    hideLoadingDialog();
    GetUtils.printFunction("loginUser", resp, "resp");
    if (resp.success) {
      showToast(resp.message);
      String accessToken = resp.data[APIConstants.kAccessToken] ?? "";
      final storage = GetStorage();
      storage.write(PreferenceKey.accessToken, accessToken);
      var userMap = resp.data[APIConstants.kUserInfo];
      storage.write(PreferenceKey.userObject, userMap);
      storage.write(PreferenceKey.isLoggedIn, true);
      Future.delayed(const Duration(seconds: 1), () {
        Get.off(() => const RootPage());
      });
    } else {
      if (resp.message ==
          "Your email is not verified yet. Please verify your mail.") {
        alertForVerifyAccount(emailEditController.text);
      } else {
        showToast(resp.message);
      }
    }
  }, onError: (err) {
    hideLoadingDialog();
    showToast(err.toString());
  });
}

/*
  void sendVerificationCode() {
    showLoadingDialog();
    APIRepository().resendVerificationCode(emailEditController.text).then((resp) {
      hideLoadingDialog();
      if (resp.success) {
        Get.off(() => EmailVerifyPage(
          registrationId: emailEditController.text,
        ));
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }*/

// void login() async {
//   if (!formLoginIsValid) {
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
//     var response = await repository.doLogin({
//       "email": emailController.text.toString(),
//       "password": passwordController.text.toString(),
//     });
//     if (response.success) {
//       final storage = GetStorage();
//       storage.write(kKeyIsLoggedIn, true);
//       storage.write(kKeyAccessToken, response.data.accessToken);
//       storage.write(kPhone, response.data.userInfo.phone);
//       EasyLoading.dismiss(animation: true);
//       Get.off(() =>RootPage());
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
