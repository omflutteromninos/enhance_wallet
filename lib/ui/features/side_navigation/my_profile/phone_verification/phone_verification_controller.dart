import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/alert_dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneVerificationController extends GetxController {
  TextEditingController phoneEditController = TextEditingController();
  TextEditingController codeEditController = TextEditingController();

  void isInPutDataValid(BuildContext context) {
    if (codeEditController.text.length < DefaultValue.kCodeLength) {
      showToast("Code length must be".trParams({"count": DefaultValue.kCodeLength.toString()}), isError: true);
      return;
    }
    hideKeyboard(context);
    verifyCode();
  }

  void sendSms(Function()? onSuccess) {
    if (phoneEditController.text.isEmpty) {
      alertForNoPhoneNumber();
      return;
    }
    showLoadingDialog();
    APIRepository().sendSms().then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        if (onSuccess != null) {
          onSuccess();
        }
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void verifyCode() {
    showLoadingDialog();
    APIRepository().verifyPhone(codeEditController.text).then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if(resp.success) {
        User newUser = Get.find<RootController>().userRx.value.createNewInstance();
        newUser.phoneVerified = 1;
        Get.find<RootController>().userRx.value = newUser;
        Get.back(result: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

}
