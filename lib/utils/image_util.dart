import 'dart:io';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import '../data/local/constants.dart';
import 'view_utils/common_utils.dart';
import 'view_utils/alert_dialog_util.dart';
import 'package:path_provider/path_provider.dart';

Widget showCircleAvatar(String url, {double size = dp90}) {
  return ClipOval(
    child: CachedNetworkImage(
      imageUrl: url,
      //DefaultValue.randomImage,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) => imageView(imagePath: AssetConstants.avatar),
      errorWidget: (context, url, error) => imageView(imagePath: AssetConstants.avatar),
    ),
  );
}

Widget imageView(
    {IconData? icon,
    String? imagePath = "",
    double? width,
    double? height,
    VoidCallback? onPressCallback,
    Color? iconColor,
    double? iconSize}) {
  return InkWell(
    onTap: onPressCallback,
    child: Container(
        // width: widthSize,
        // height: heightSize,
        child: imagePath!.isNotEmpty
            ? imagePath.contains(".svg")
                ? SvgPicture.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    width: width,
                    height: height,
                    color: iconColor,
                  )
                : Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    width: width,
                    height: height,
                  )
            : Icon(
                icon!,
                size: iconSize,
                color: iconColor,
              )),
  );
}

Widget imageViewWithRoundedBox({
  String? imagePath,
  double? iconWidthSize,
  double? iconHeightSize,
  VoidCallback? onPressCallback,
}) {
  return InkWell(
    onTap: onPressCallback,
    child: Container(
      width: dp60,
      height: dp60,
      padding: EdgeInsets.symmetric(vertical: dp15, horizontal: dp15),
      decoration: getRoundTransparentBoxWithBorderRadius5(),
      child: imageView(
          imagePath: imagePath!, width: iconWidthSize, height: iconHeightSize),
    ),
  );
}

Widget imageViewWithCircleBox({
  String? imagePath,
  double? imageWidthSize,
  double? imageHeightSize,
  VoidCallback? onPressCallback,
}) {
  return InkWell(
    onTap: onPressCallback,
    child: Container(
      width: dp90,
      height: dp90,
      decoration: getCircleCornerBorder(),
      padding: EdgeInsets.symmetric(horizontal: dp10, vertical: dp10),
      child: imageViewNetwork(
          imagePath: imagePath!,
          width: imageWidthSize,
          height: imageHeightSize),
    ),
  );
}

Widget imageViewNetwork(
    {IconData? icon,
    String? imagePath,
    double? width,
    double? height,
    VoidCallback? onPressCallback,
    Color? iconColor,
    double? iconSize}) {
  return InkWell(
    onTap: onPressCallback,
    child: Container(
        // width: widthSize,
        // height: heightSize,
        child: imagePath!.isNotEmpty
            ? imagePath.contains(".svg")
                ? SvgPicture.network(imagePath,
                    fit: BoxFit.contain,
                    width: width,
                    height: height,
                    color: iconColor)
                : Image.network(imagePath,
                    fit: BoxFit.contain, width: width, height: height)
            : Icon(icon!, size: iconSize, color: iconColor)),
  );
}

// Widget showCircleAvatar2({String? url, double size = dp90}) {
//   return ClipOval(
//     child: CachedNetworkImage(
//       imageUrl: url!.isNotEmpty
//           ?url!.contains(".svg")
//           ? SvgPicture.network(url!)
//               : Image.network(url!)
//           : Container(),
//       //DefaultValue.randomImage,
//       width: size,
//       height: size,
//       fit: BoxFit.cover,
//       placeholder: (context, url) => SvgPicture.asset(AssetConstants.ic_logo),
//       errorWidget: (context, url, error) =>
//           SvgPicture.asset(AssetConstants.ic_logo),
//     ),
//   );
// }

Widget showImage(String url, {double size = dp90}) {
  return Container(
    padding: const EdgeInsets.all(dp5),
    child: CachedNetworkImage(
      imageUrl: url,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) => SvgPicture.asset(AssetConstants.ic_logo),
      errorWidget: (context, url, error) {
        return SvgPicture.asset(AssetConstants.ic_logo, height: size/2, width: size / 2,);
      },
    ),
  );
}

Widget showImageLocal(File file, {double size = dp90}) {
  return Container(
    padding: const EdgeInsets.all(dp5),
    child: Image.file(
      file,
      width: size,
      height: size,
      fit: BoxFit.cover,
    ),
  );
}

Widget iconWithTap(String iconPath,  {Color? iconColor, VoidCallback? onPress, double size = 20}) {
  return InkWell(
    onTap: onPress,
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: iconPath.contains(".svg")
          ? SvgPicture.asset(
        iconPath,
        width: size,
        height: size,
        color: iconColor,
      ) :
      Image.asset(
        iconPath,
        width: size,
        height: size,
        color: iconColor,
      ),
    ),
  );
}

Widget showCircleAvatarLocal(File file, {double size = 90}) {
  return ClipOval(
      child: Image.file(
        file,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ));
}

// void showImageChooser(
//     BuildContext context, Function(File slectedFile) onChoose) {
//   hideKeyboard(context);
//   changePhotoModalBottomSheet(() {
//     Get.back();
//     getImage(false, onChoose);
//   }, () {
//     Get.back();
//     getImage(true, onChoose);
//   }, width: Get.width * 0.85);
// }
void showImageChooser(BuildContext context, Function(File, bool) onChoose) {
  hideKeyboard(context);
  changePhotoModalBottomSheet(() {
    Get.back();
    getImage(false, onChoose);
  }, () {
    Get.back();
    getImage(true, onChoose);
  }, width: Get.width * 0.85);
}

Future getImage(bool isGallery, Function(File, bool) onChoose) async {
  if (isGallery) {
    List<Media>? res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
      language: Language.System,
      cropOpt: CropOption(
        aspectRatio: const CropAspectRatio(2, 2),
      ),
    );
    if (res != null) {
      var file = File(res[0].path);
      onChoose(file, isGallery);
    }
  } else {
    List<Media>? res = await ImagesPicker.openCamera(
      pickType: PickType.image,
      cropOpt: CropOption(
        aspectRatio: const CropAspectRatio(2, 2),
      ),
      quality: 0.5,
    );
    if (res != null) {
      var file = File(res.first.path);
      onChoose(file, isGallery);
    }
  }
}



Future<String> getImageDirectoryPath(String path) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  return "${appDocDir.path}${AssetConstants.pathTempImageFolder}${DateTime.now().millisecondsSinceEpoch}$path";
}