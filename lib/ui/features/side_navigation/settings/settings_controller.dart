import 'package:cPocket/data/models/settings_data.dart';
import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  RxString selectedLanguage = "".obs;
  RxString google2faSecret = "".obs;
  TextEditingController codeEditController = TextEditingController();
  RxBool isGoogleAuthActive = false.obs;
  SettingsData? settingsData;


  void getSettings(String code) {
    showLoadingDialog();
    APIRepository().getSettings().then((resp) {
      hideLoadingDialog();
      if (resp.success) {
        settingsData = SettingsData.fromJson(resp.data);
        if(code.isNotEmpty && settingsData != null && settingsData!.languages != null) {
          var language = settingsData!.languages![code];
          selectedLanguage.value = language ?? "";
        }
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  List<String> getLanguageList() {
    if (settingsData != null && settingsData!.languages != null) {
      List<String> languageList = [];
      languageList.addAll(settingsData!.languages!.values);
      return languageList;
    }
    return [];
  }

  void saveLanguage() {
    if (selectedLanguage.value.isEmpty) {
      showToast("Please select a language".tr);
      return;
    }
    String usdKey = settingsData!.languages!.keys.firstWhere((k) => settingsData!.languages![k] == selectedLanguage.value,
        orElse: () => DefaultValue.languageKey);

    showLoadingDialog();
    APIRepository().saveLanguage(usdKey).then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        Get.updateLocale(Locale.fromSubtags(languageCode: usdKey));
        GetStorage().write(PreferenceKey.languageKey, usdKey);
        updateUserObject(language: usdKey);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void verifyGoogleCode() {
    if(codeEditController.text.length < DefaultValue.kCodeLength) {
      showToast("Code length must be".trParams({"count" : DefaultValue.kCodeLength.toString()}), isError: true);
      return;
    }
    showLoadingDialog();
    bool isAdd = google2faSecret.value.isEmpty;
    String secret = isAdd ? (settingsData?.google2FaSecret ?? "") : google2faSecret.value;

    APIRepository().saveGoogleSecret(codeEditController.text, secret, isAdd).then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        google2faSecret.value = isAdd ? settingsData!.google2FaSecret! : "";
        updateUserObject(google2FaSecret: google2faSecret.value);
        Get.back();
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void enableDisable2FALogin() {
    showLoadingDialog();
    APIRepository().twoFALoginEnableDisable().then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        isGoogleAuthActive.value = !isGoogleAuthActive.value;
        updateUserObject(fALogin: "");
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void updateUserObject({String? google2FaSecret, String? language, String? fALogin}){
    User newUser = Get.find<RootController>().userRx.value.createNewInstance();
    if (google2FaSecret != null){
      newUser.google2FaSecret = google2FaSecret;
    }
    if (language != null){
      newUser.language = language;
    }
    if (fALogin != null){
      newUser.g2FEnabled = isGoogleAuthActive.value ? 1 : 0;
    }
    Get.find<RootController>().userRx.value = newUser;
  }

}