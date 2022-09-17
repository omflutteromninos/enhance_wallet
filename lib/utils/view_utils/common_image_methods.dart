// import 'dart:io';
// import 'package:cPocket/data/models/user.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:images_picker/images_picker.dart';
//
// import '../constants.dart';
// import 'common_utils.dart';
// import 'custom_modal_Sheet.dart';
//
// //Rx<User> myUser = User().obs;
// Rx<File> image = File("").obs;
//
// // Rx<SubmitNidPhotoResponse> submitNidPhoto = SubmitNidPhotoResponse().obs;
// // Rx<SubmitPassportPhotoResponse> submitPassportPhoto = SubmitPassportPhotoResponse().obs;
// // Rx<SubmitDriverLicensePhotoResponse> submitDrivingLicensePhoto = SubmitDriverLicensePhotoResponse().obs;
// Rx<File> profileImage = File("").obs;
// Rx<File> nidImageFront = File("").obs;
// Rx<File> nidImageBack = File("").obs;
// Rx<File> passportImageFront = File("").obs;
// Rx<File> passportImageBack = File("").obs;
// Rx<File> drivingLicenseFrontImage = File("").obs;
// Rx<File> drivingLicenseBackImage = File("").obs;
//
// RxBool isLogin = false.obs;
//
// ImageProvider setProfileImage(User myUser) {
//   if (image.value.path == "") {
//     var _path = stringNullCheck(myUser.photo!);
//     if (_path.isEmpty) {
//       return AssetImage(AssetConstants.no_image);
//     } else {
//       return NetworkImage(_path);
//     }
//   } else {
//     return FileImage(image.value);
//   }
// }
// //
// // ImageProvider setNidImage() {
// //   if (image.value.path == "") {
// //     var _path = stringNullCheck(submitNidPhoto.value.data!.nidFront!);
// //     if (_path.isEmpty) {
// //       return AssetImage(AssetConstants.img_not_available);
// //     } else {
// //       return NetworkImage(_path);
// //     }
// //   } else {
// //     return FileImage(image.value);
// //   }
// // }
// //
// // ImageProvider setPassportImage() {
// //   if (image.value.path == "") {
// //     var _path = stringNullCheck(
// //         submitDrivingLicensePhoto.value.data!.driveFront!);
// //     if (_path.isEmpty) {
// //       return AssetImage(AssetConstants.img_not_available);
// //     } else {
// //       return NetworkImage(_path);
// //     }
// //   } else {
// //     return FileImage(image.value);
// //   }
// // }
// //
// // ImageProvider setDrivingLicenseImage() {
// //   if (image.value.path == "") {
// //     var _path = stringNullCheck(submitPassportPhoto.value.data!.passFront!);
// //     if (_path.isEmpty) {
// //       return AssetImage(AssetConstants.img_not_available);
// //     } else {
// //       return NetworkImage(_path);
// //     }
// //   } else {
// //     return FileImage(image.value);
// //   }
// // }
//
// Future getImage({bool? isGallery}) async {
//   if (isGallery!) {
//     List<Media>? res = await ImagesPicker.pick(
//       count: 1,
//       pickType: PickType.image,
//       language: Language.System,
//       cropOpt: CropOption(
//         aspectRatio: CropAspectRatio(2, 2),
//       ),
//     );
//     if (res != null) {
//       image.value = File(res[0].path);
//     }
//   } else {
//     List<Media>? res = await ImagesPicker.openCamera(
//       pickType: PickType.image,
//       cropOpt: CropOption(
//         aspectRatio: CropAspectRatio(2, 2),
//       ),
//       quality: 0.5,
//     );
//     if (res != null) {
//       image.value = File(res[0].path);
//     }
//   }
// }
//
// Future getImageWide({bool? isGallery}) async {
//   if (isGallery!) {
//     List<Media>? res = await ImagesPicker.pick(
//       count: 1,
//       pickType: PickType.image,
//       language: Language.System,
//       cropOpt: CropOption(
//         aspectRatio: CropAspectRatio(3, 2),
//       ),
//     );
//     if (res != null) {
//       image.value = File(res[0].path);
//     }
//   } else {
//     List<Media>? res = await ImagesPicker.openCamera(
//       pickType: PickType.image,
//       cropOpt: CropOption(
//         aspectRatio: CropAspectRatio(3, 2),
//       ),
//       quality: 0.5,
//     );
//     if (res != null) {
//       image.value = File(res[0].path);
//     }
//   }
// }
//
// void showImageChooser(BuildContext context) {
//   hideKeyboard(context);
//   var width = Get.width * 0.85;
//   changePhotoModalBottomSheet(
//       buttonAction1: () {
//         Get.back();
//         getImage(isGallery: false);
//       },
//       buttonAction2: () {
//         Get.back();
//         getImage(isGallery: true);
//       },
//       width: width);
// }
//
// void showImageChooserWide(BuildContext context) {
//   hideKeyboard(context);
//   var width = Get.width * 0.85;
//   changePhotoModalBottomSheet(
//       buttonAction1: () {
//         Get.back();
//         getImageWide(isGallery: false);
//       },
//       buttonAction2: () {
//         Get.back();
//         getImageWide(isGallery: true);
//       },
//       width: width);
// }
