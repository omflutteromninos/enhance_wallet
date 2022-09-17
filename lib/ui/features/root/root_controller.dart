import 'dart:io';
import 'dart:ui';

import 'package:cPocket/data/models/general_settings.dart';
import 'package:cPocket/data/models/profile/user_club_infos.dart';
import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/ui/features/auth/sign_in/sign_in_page.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RootController extends GetxController {
  Rx<User> userRx = User(id: 0).obs;
  Rx<UserClubInfo> userClubInfoRx = UserClubInfo().obs;
  Rx<GeneralSettings> generalSettings = GeneralSettings().obs;

  var selectedIndex = 0.obs;
  var selectedDrawerItem = 0.obs;

  Rx<File> profileImage = File("").obs;

  void setMyProfile() {
    var userMap = GetStorage().read(PreferenceKey.userObject);
    print("UserMap: $userMap");
    if (userMap != null) {
      try {
        userRx.value = User.fromJson(userMap);
        // _setGlobalUser();
      } catch (_) {
        GetUtils.printFunction("setMyProfile", _, "error");
      }
    }
    Future.delayed(Duration(seconds: DefaultValue.kResponseDuration), () {
      getMyProfile();
      getGeneralSettings();
    });
  }

  void getMyProfile() {
    APIRepository().getSelfProfile().then((resp) {
      if (resp.success) {
        var userMap = resp.data[APIConstants.kUser];
        User user = User.fromJson(userMap);
        userRx.value = user;
        GetStorage().write(PreferenceKey.userObject, userMap);

        var userClubInfoMap = resp.data[APIConstants.kUserClubInfo];
        UserClubInfo userClubInfo = UserClubInfo.fromJson(userClubInfoMap);
        userClubInfoRx.value = userClubInfo;
        GetStorage().write(PreferenceKey.userClubInfoObject, userClubInfoMap);
      }
    }, onError: (err) {});
  }

  // void getGeneralSettings() {
  //   APIRepository().getSettings().then((resp) {
  //     if (resp.success) {
  //       GetStorage().write(PreferenceKey.settingsObject, resp.data);
  //     }
  //   }, onError: (err) {});
  // }

  void getGeneralSettings() {
    APIRepository().getGeneralSetting().then((resp) {
      if (resp.success) {
        generalSettings.value= GeneralSettings.fromJson(resp.data);
        GetStorage().write(PreferenceKey.generalSettings, resp.data);
      }
    }, onError: (err) {});
  }

  void logOut() {
    showLoadingDialog();
    APIRepository().logoutUser().then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        GetStorage().erase();
        Get.off(() => const SignInPage());
      }
    }, onError: (err) {
      hideLoadingDialog();
      if (err.toString() == ErrorConstants.unauthorized){
        GetStorage().erase();
        Get.off(() => const SignInPage());
      }else {
        showToast(err.toString());
      }
    });
  }

}
