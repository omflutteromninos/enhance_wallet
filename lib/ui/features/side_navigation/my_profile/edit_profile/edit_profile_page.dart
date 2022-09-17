import 'dart:io';
import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/utils/image_util.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../my_profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final MyProfileController _controller = Get.put(MyProfileController());
  User user = Get.find<RootController>().userRx.value;

  @override
  void initState() {
    super.initState();
    _controller.setDataEditView(user);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.getEditProfileData((onData) {
        setState(() {
          user = onData;
          _controller.setDataEditView(onData);
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.clearEditView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCommonBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBarWithBack(title: "Profile".tr, hideRightIcon: true),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: dp15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    editImageView(),
                    textAutoSize("Welcome_user_name".trParams({"name": getUserName(user)})),
                    VSpacer10(),
                    textAutoSize("First Name".tr, fontSize: dp14),
                    textFieldBorderedWithSuffixIcon(
                      _controller.firstNameEditController,
                      "Your first name here".tr,
                      TextInputType.name,
                    ),
                    VSpacer10(),
                    textAutoSize("Last Name".tr, fontSize: dp14),
                    textFieldBorderedWithSuffixIcon(
                      _controller.lastNameEditController,
                      "Your last name here".tr,
                      TextInputType.name,
                    ),
                    VSpacer10(),
                    textAutoSize("Phone".tr, fontSize: dp14),
                    textFieldBorderedWithSuffixIcon(
                      _controller.phoneEditController,
                      "Your phone number with dial code".tr,
                      TextInputType.phone,
                    ),
                    VSpacer10(),
                    textAutoSize("Country".tr, fontSize: dp14),
                    Obx(() {
                      return dropDownList(
                          _controller.getCountryList(),
                          _controller.selectedCountry.value,
                          "Select Country".tr, (value) {
                        _controller.selectedCountry.value = value;
                      });
                    }),
                    VSpacer10(),
                    textAutoSize("Gender".tr, fontSize: dp14),
                    Obx(() {
                      return dropDownList(
                          _controller.getGenderList(),
                          _controller.selectedGender.value,
                          "Select Gender".tr, (value) {
                        _controller.selectedGender.value = value;
                      });
                    }),
                    VSpacer20(),
                    buttonRoundedMain(
                      text: "Update".tr,
                      onPressCallback: () {
                        _controller.checkProfileData(user);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget editImageView() {
    return Padding(
      padding: const EdgeInsets.all(dp10),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Obx(() {
            return _controller.profileImage.value.path == ""
                ? showCircleAvatar(stringNullCheck(user.photo))
                : showCircleAvatarLocal(_controller.profileImage.value);
          }),
          buttonIconWithRoundBg(AssetConstants.ic_camera,
              size: dp30,
              padding: dp30,
              iconColor: Get.theme.primaryColor, onPress: () {
            showImageChooser(context, (chooseFile, isGallery) {
              if (isGallery) {
                _controller.profileImage.value = chooseFile;
              } else {
                saveFileOnTempPath(chooseFile);
              }
            });
          }),
        ],
      ),
    );
  }

  void saveFileOnTempPath(File chooseFile) async {
    getImageDirectoryPath(AssetConstants.pathTempProfileImageName)
        .then((tempPath) {
      if (_controller.profileImage.value.path
          .contains(AssetConstants.pathTempProfileImageName)) {
        _controller.profileImage.value.deleteSync();
      }
      File(tempPath).createSync(recursive: true);
      File newFile = chooseFile.copySync(tempPath);
      chooseFile.deleteSync();
      _controller.profileImage.value = newFile;
    });
  }
}
