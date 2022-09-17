import 'dart:io';
import 'package:cPocket/data/models/profile/id_Verification/id_verifications.dart';
import 'package:cPocket/data/models/profile/profile_edit_response.dart';
import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/data/remote/api_repository.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyProfileController extends GetxController {
  TextEditingController firstNameEditController = TextEditingController();
  TextEditingController lastNameEditController = TextEditingController();
  TextEditingController phoneEditController = TextEditingController();

  Rx<File> profileImage = File("").obs;
  Rx<File> frontImage = File("").obs;
  Rx<File> backImage = File("").obs;
  RxString selectedCountry = "".obs;
  RxString selectedGender = "".obs;
  ProfileEditResponse? profileResponse;
  Rx<IdVerification> idVerification = IdVerification().obs;

  void clearEditView() {
    if (profileImage.value.path
        .contains(AssetConstants.pathTempProfileImageName)) {
      profileImage.value.delete();
    }
    profileImage.value = File("");
    firstNameEditController.text = "";
    lastNameEditController.text = "";
    phoneEditController.text = "";
  }

  void clearIdVerificationView() {
    if (frontImage.value.path.contains(AssetConstants.pathTempFrontImageName)) {
      frontImage.value.delete();
    }
    if (frontImage.value.path.contains(AssetConstants.pathTempBackImageName)) {
      backImage.value.delete();
    }
    frontImage.value = File("");
    backImage.value = File("");
  }

  void setDataEditView(User user) {
    firstNameEditController.text = stringNullCheck(user.firstName);
    lastNameEditController.text = stringNullCheck(user.lastName);
    phoneEditController.text = stringNullCheck(user.phone);
    var code = stringNullCheck(user.country);
    if (code.isNotEmpty &&
        profileResponse != null &&
        profileResponse!.countries != null) {
      var country = profileResponse!.countries![code];
      selectedCountry.value = country ?? "";
    }
    if (user.gender != null &&
        profileResponse != null &&
        profileResponse!.genders != null) {
      var gender = profileResponse!.genders![user.gender.toString()];
      selectedGender.value = gender ?? "";
    }
  }

  void getEditProfileData(Function(User updateUser) onData) {
    showLoadingDialog();
    APIRepository().getEditProfileData().then((resp) {
      hideLoadingDialog();
      if (resp.success) {
        profileResponse = ProfileEditResponse.fromJson(resp.data);
        if (profileResponse != null && profileResponse!.user != null) {
          Get.find<RootController>().userRx.value = profileResponse!.user!;
          GetStorage()
              .write(PreferenceKey.userObject, profileResponse!.user!.toJson());
          onData(profileResponse!.user!);
        }
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void checkProfileData(User currentUser) {
    User updateUser = currentUser;
    if (firstNameEditController.text.trim().isEmpty) {
      showToast("First name can not be empty".tr, isError: true);
      return;
    }
    updateUser.firstName = firstNameEditController.text.trim();

    if (lastNameEditController.text.trim().isEmpty) {
      showToast("Last name can not be empty".tr, isError: true);
      return;
    }
    updateUser.lastName = lastNameEditController.text.trim();

    if (phoneEditController.text.trim().isNotEmpty) {
      updateUser.phone = phoneEditController.text.trim();
    }

    if (selectedCountry.value.isNotEmpty) {
      var usdKey = profileResponse!.countries!.keys.firstWhere(
          (k) => profileResponse!.countries![k] == selectedCountry.value,
          orElse: () => "");
      updateUser.country = usdKey.toUpperCase();
    }

    if (selectedGender.value.isNotEmpty) {
      var usdKey = profileResponse!.genders!.keys.firstWhere(
          (k) => profileResponse!.genders![k] == selectedGender.value,
          orElse: () => "");
      if (usdKey.isNotEmpty) {
        updateUser.gender = int.parse(usdKey);
      }
    }
    updateProfile(updateUser);
  }

  void updateProfile(User updatedUser) {
    showLoadingDialog();
    APIRepository().updateProfile(updatedUser, profileImage.value).then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        Get.find<RootController>().userRx.value = User.fromJson(resp.data);
        GetStorage().write(PreferenceKey.userObject, resp.data);
        Get.back();
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  List<String> getCountryList() {
    if (profileResponse != null && profileResponse!.countries != null) {
      List<String> countryList = [];
      countryList.addAll(profileResponse!.countries!.values);
      return countryList;
    }
    return [];
  }

  List<String> getGenderList() {
    if (profileResponse != null && profileResponse!.genders != null) {
      List<String> list = [];
      list.addAll(profileResponse!.genders!.values);
      return list;
    }
    return [];
  }

  // *** ID VERIFICATION *** //

  void getIdVerification() {
    showLoadingDialog();
    APIRepository().getIdVerification().then((resp) {
      hideLoadingDialog();
      if (resp.success) {
        idVerification.value = IdVerification.fromJson(resp.data);
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void uploadIdPhotos(IdVerificationType type) {
    if (frontImage.value.path.isEmpty) {
      showToast("Front image can not be empty".tr);
      return;
    }
    if (backImage.value.path.isEmpty) {
      showToast("Back image can not be empty".tr);
      return;
    }

    showLoadingDialog();
    APIRepository()
        .uploadIdVerificationPhotos(type, frontImage.value, backImage.value)
        .then((resp) {
      hideLoadingDialog();
      showToast(resp.message);
      if (resp.success) {
        Get.back();
        getIdVerification();
        clearIdVerificationView();
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }
}
