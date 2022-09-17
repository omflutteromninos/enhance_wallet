import 'dart:io';
import 'package:cPocket/data/models/profile/id_Verification/id_verifications.dart';
import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/utils/image_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/alert_dialog_util.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../my_profile_controller.dart';

class IdVerificationPage extends StatefulWidget {
  @override
  _IdVerificationPageState createState() => _IdVerificationPageState();
}

class _IdVerificationPageState extends State<IdVerificationPage> {
  final User user = Get.find<RootController>().userRx.value;
  final MyProfileController _controller = Get.put(MyProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.getIdVerification();
    });
  }

  @override
  void dispose() {
    _controller.clearIdVerificationView();
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
                    VSpacer20(),
                    viewProfilePhotoWithName(user),
                    Obx((){
                      return _idVerificationItem(
                          IdVerificationType.nid,
                          "National Id Card".tr,
                          _controller.idVerification.value.nid,
                          AssetConstants.ic_nid);
                    }),
                    Obx((){
                      return _idVerificationItem(
                          IdVerificationType.passport,
                          "Passport".tr,
                          _controller.idVerification.value.passport,
                          AssetConstants.ic_passport);
                    }),
                    Obx((){
                      return _idVerificationItem(
                          IdVerificationType.driving,
                          "Driving License".tr,
                          _controller.idVerification.value.drivingLicense,
                          AssetConstants.ic_driving_license);
                    }),
                    VSpacer20(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _idVerificationItem(IdVerificationType type, String title,
      IdDetails? idDetails, String iconPath) {
    String status = "id_status_format"
        .trParams({"status": getIdVerificationStatus(idDetails?.status)});
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(dp10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textSpan(title, status,
                color: getIdVerificationStatusColor(idDetails?.status)),
            VSpacer5(),
            Container(
              // height: Get.width / 2,
              // width: Get.width,
              // decoration: boxDecorationRoundCorner(
              //   color: Get.theme.primaryColorDark.withOpacity(0.5)),
              width: Get.width,
              height: dp170,
              decoration: getRoundSoftTransparentBox(),
              child: (idDetails == null ||
                      idDetails.front == null ||
                      idDetails.front!.isEmpty)
                  ? buttonOnlyIcon(null, iconPath: iconPath)
                  : showImage(idDetails.front!),
            ),
          ],
        ),
      ),
      onTap: () {
        if (idDetails?.status != IdVerificationStatus.accepted) {
          showModalSheetFullScreen(showUploadView(type), context, onClose: () {
            _controller.clearIdVerificationView();
          });
        }
      },
    );
  }

  Widget showUploadView(IdVerificationType type) {
    return Container(
      margin: const EdgeInsets.all(dp10),
      child: Column(
        children: [
          textAutoSize(
            "Front side".tr,
          ),
          VSpacer10(),
          Obx(() {
            return _showUploadImage(_controller.frontImage.value, true);
          }),
          VSpacer10(),
          textAutoSize(
            "Back side".tr,
          ),
          VSpacer10(),
          Obx(() {
            return _showUploadImage(_controller.backImage.value, false);
          }),
          VSpacer20(),
          buttonRoundedFill("Upload".tr, () {
            _controller.uploadIdPhotos(type);
          }),
        ],
      ),
    );
  }

  Widget _showUploadImage(File file, bool isFont) {
    return InkWell(
      child: Container(
        // height: Get.width / 2,
        // width: Get.width,
        // margin: const EdgeInsets.all(dp10),
         decoration: boxDecorationRoundCorner(color: Get.theme.primaryColorDark),
        width: Get.width,
        height: dp170,
        //decoration: getRoundTransparentBox(),
        child: file.path.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonOnlyIcon(
                    null,
                    iconPath: AssetConstants.ic_upload,
                  ),
                  VSpacer10(),
                  textAutoSize("Tap to upload photo".tr,
                      textAlign: TextAlign.center, fontSize: dp14),
                ],
              )
            : showImageLocal(file),
      ),
      onTap: () {
        showImageChooser(context, (chooseFile, isGallery){
          if(isGallery) {
            isFont ? _controller.frontImage.value = chooseFile : _controller.backImage.value = chooseFile;
          } else {
            saveFileOnTempPath(chooseFile, isFont);
          }
        });
      },
    );
  }

  void saveFileOnTempPath(File chooseFile, bool isFont) async {
    String imageName = isFont ? AssetConstants.pathTempFrontImageName : AssetConstants.pathTempBackImageName;
    getImageDirectoryPath(imageName).then((tempPath) {
      File preFile = isFont ? _controller.frontImage.value : _controller.backImage.value;
      if(preFile.path.contains(imageName)){
        preFile.deleteSync();
      }
      File(tempPath).createSync(recursive: true);
      File newFile = chooseFile.copySync(tempPath);
      chooseFile.deleteSync();
      isFont ? _controller.frontImage.value = newFile : _controller.backImage.value = newFile;
    });
  }

}
