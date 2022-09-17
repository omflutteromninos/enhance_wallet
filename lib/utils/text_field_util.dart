import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// Widget textFieldBorderedWithSuffixIcon(
//     TextEditingController? controller, String hint, TextInputType type,
//     {String? iconPath,
//     VoidCallback? iconAction,
//     bool isObscure = false,
//     bool isEnable = true,
//     int maxLines = 1}) {
//   return Container(
//       padding: const EdgeInsets.only(top: 5),
//       child: TextField(
//     controller: controller,
//     keyboardType: type,
//     maxLines: maxLines,
//     cursorColor: Get.theme.colorScheme.secondary,
//     obscureText: isObscure,
//     enabled: isEnable,
//     style: Get.textTheme.bodyText1!,
//     decoration: InputDecoration(
//       filled: false,
//       isDense: true,
//       hintText: hint,
//       hintStyle: Get.textTheme.bodyText1!.copyWith(color: Get.theme.primaryColor.withOpacity(0.6), fontSize: 14),
//       enabledBorder: _textFieldBorder(),
//       disabledBorder: _textFieldBorder(),
//       focusedBorder: _textFieldBorder(isFocus: true),
//       suffixIcon: iconPath == null
//           ? const SizedBox()
//           : _buildTextFieldIcon(iconPath, iconAction, Get.theme.primaryColor),
//     ),
//   ));
// }

Widget textFieldBorderedWithSuffixIcon(TextEditingController? controller, String hint, TextInputType type,
    {String? iconPath, VoidCallback? iconAction, bool isObscure = false, bool isEnable = true, int maxLines = 1,
      Function(String)? onTextChange}) {
  return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 5),
      child: TextField(
        controller: controller,
        keyboardType: type,
        maxLines: maxLines,
        cursorColor: Get.theme.colorScheme.secondary,
        obscureText: isObscure,
        enabled: isEnable,
        style: Get.textTheme.bodyText1!,
        onChanged: (value) {
          if(onTextChange != null) {
            onTextChange(value);
          }
        },
        decoration: InputDecoration(
            filled: false,
            isDense: true,
            hintText: hint,
            fillColor: white.withOpacity(0.03),
            hintStyle: Get.textTheme.bodyText1!.copyWith(color: Get.theme.primaryColor.withOpacity(0.6), fontSize: 12),
            enabledBorder: _textFieldBorder(),
            disabledBorder: _textFieldBorder(),
            focusedBorder: _textFieldBorder(isFocus: true),
            suffixIcon: iconPath == null
                ? null
                : _buildTextFieldIcon(iconPath, iconAction, Get.theme.primaryColor)),
      ));
}

_textFieldBorder({bool isFocus = false}) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(dp6)),
    borderSide: BorderSide(
        width: 0.75,
        color: isFocus ? Get.theme.colorScheme.secondary : kGreyColor),
  );
}

Widget _buildTextFieldIcon(String iconPath, VoidCallback? action, Color color) {
  return InkWell(
    onTap: action,
    child: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          iconPath,
          color: color,
        )),
  );
}

// Widget textFieldBottomLine(TextEditingController controller, String hint,
//     {double width, bool enabled = true, TextInputType inputType = TextInputType.text,
//       TextAlign textAlign: TextAlign.left, Color cursorColor, Color borderColor = dividerColor3, bool autoFocus = true }) {
//   var _cursorColor = cursorColor;
//   if (_cursorColor == null) {
//     _cursorColor = Get.theme.accentColor;
//   }
//   return Container(
//       height: dp50,
//       width: width,
//       child: TextField(
//         controller: controller,
//         enabled: enabled,
//         style: Get.theme.textTheme.headline2,
//         cursorColor: _cursorColor,
//         textAlign: textAlign,
//         maxLines: 1,
//         keyboardType: inputType,
//         autofocus: autoFocus,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: Get.theme.textTheme.headline2
//               .copyWith(color: subText),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: borderColor),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Get.theme.accentColor),
//           ),
//           border: UnderlineInputBorder(
//             borderSide: BorderSide(color: borderColor),
//           ),
//         ),
//       ));
// }
//
// Widget textFieldBordered(TextEditingController controller, String hint,
//     {double width, bool enabled = true, Color borderColor = greyBorder}) {
//   return Container(
//       height: dp50,
//       margin: EdgeInsets.all(10),
//       width: width,
//       child: TextField(
//         controller: controller,
//         enabled: enabled,
//         style: Get.theme.textTheme.headline3,
//         maxLines: 1,
//         cursorColor: Get.theme.primaryColorDark,
//         decoration: InputDecoration(
//           filled: true,
//           isDense: true,
//           fillColor: textFieldColor,
//           hintText: hint,
//           hintStyle: Get.theme.textTheme.subtitle1
//               .copyWith(color: black, fontSize: 18),
//           enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: borderColor),
//               borderRadius: BorderRadius.all(Radius.circular(dp10))),
//           border: OutlineInputBorder(
//               borderSide: BorderSide(color: borderColor),
//               borderRadius: BorderRadius.all(Radius.circular(dp10))),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(dp10)),
//               borderSide: BorderSide(color: accentBlue)),
//         ),
//       ));
// }
//
// Widget textFieldBorderedWithPrefixIcon(
//     TextEditingController controller, String hint,
//     {String iconPath, VoidCallback iconAction, bool isObscure = false}) {
//   return Container(
//     //height: 44,
//       margin: EdgeInsets.all(10),
//       child: TextField(
//         controller: controller,
//         obscureText: isObscure,
//         style: Get.theme.textTheme.headline3,
//         maxLines: 1,
//         cursorColor: Get.theme.primaryColorDark,
//         decoration: InputDecoration(
//             filled: true,
//             isDense: true,
//             fillColor: Get.theme.primaryColor,
//             hintText: hint,
//             hintStyle: Get.theme.textTheme.subtitle1,
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(dp10))),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(
//                   dp10,
//                 )),
//                 borderSide: BorderSide(color: Get.theme.accentColor)),
//             prefixIcon: iconPath == null
//                 ? Container(
//               width: dp0,
//               height: dp0,
//             )
//                 : buildTextFieldIcon(
//                 iconPath, iconAction, Get.theme.primaryColorDark)),
//       ));
// }
//

// Widget textFormFieldDatePicker(BuildContext context,
//     TextEditingController controller, String hint, TextInputType type,
//     {String iconPath, VoidCallback iconAction}) {
//   return Container(
//       padding: EdgeInsets.all(10),
//       child: TextFormField(
//         controller: controller,
//         style: Get.theme.textTheme.headline3,
//         keyboardType: type,
//         maxLines: 1,
//         cursorColor: Get.theme.primaryColorDark,
//         decoration: InputDecoration(
//             filled: true,
//             isDense: true,
//             labelText: hint,
//             //labelText: hint != null ? '$hint${true ? '*' : ''}' : null,
//             labelStyle: Get.theme.textTheme.subtitle1.copyWith(color: black),
//             fillColor: Get.theme.primaryColor,
//             hintText: hint,
//             hintStyle: Get.theme.textTheme.subtitle1.copyWith(color: subText),
//             enabledBorder: textFieldBorder(),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(dp10)),
//                 borderSide: BorderSide(color: textFieldFocusedBlue)),
//             suffixIcon: iconPath == null
//                 ? Container(
//                     width: dp0,
//                     height: dp0,
//                   )
//                 : buildTextFieldIcon(
//                     iconPath, iconAction, Get.theme.primaryColorDark)),
//         onTap: () async {
//           DateTime date = DateTime(1900);
//           FocusScope.of(context).requestFocus(new FocusNode());
//
//           date = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime(1900),
//               lastDate: DateTime.now());
//           controller.text = formatDateItem(date);
//         },
//       ));
// }
//
// Widget textFieldBorderedWithPrefixAndSuffixIcon(TextEditingController controller, String hint,
//     String prefixIcon, VoidCallback prefixAction, String suffixIcon,
//     VoidCallback suffixAction, {TextInputType type, bool enable = true}) {
//   return Container(
//       padding: EdgeInsets.all(dp10),
//       child: TextField(
//           controller: controller,
//           style: Get.theme.textTheme.headline4,
//           keyboardType: type,
//           maxLines: 1,
//           enabled: enable,
//           cursorColor: Get.theme.primaryColorDark,
//           decoration: InputDecoration(
//             filled: true,
//             isDense: true,
//             labelText: hint,
//             labelStyle: Get.theme.textTheme.subtitle1.copyWith(
//                 color: black, fontSize: 20, fontWeight: FontWeight.w500),
//             fillColor: textFieldColor,
//             hintText: hint,
//             hintStyle: Get.theme.textTheme.subtitle1.copyWith(
//                 color: subText,
//                 fontSize: 20,
//                 fontWeight: FontWeight.normal),
//             enabledBorder: textFieldBorderSearch(),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(dp10)),
//                 borderSide: BorderSide(color: accentBlue)),
//             prefixIcon: buttonOnlyIcon(null, prefixAction, iconPath: prefixIcon),
//             suffixIcon: buttonOnlyIcon(null, suffixAction, iconPath: suffixIcon)
//           )));
// }
//
// /// *** Helper Methods *** ///
// textFieldBorder({bool isError = false}) {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(dp10)),
//     borderSide: BorderSide(
//         width: 1, color: isError ? Colors.red : Get.theme.accentColor),
//   );
// }
//
// textFieldBorderSearch({bool isError = false}) {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(dp10)),
//     borderSide: BorderSide(width: 1, color: isError ? Colors.red : greyBorder),
//   );
// }
//
// Widget buildTextFieldIcon(String iconPath, VoidCallback action, Color color) {
//   return InkWell(
//     onTap: action,
//     child: Padding(
//         padding: EdgeInsets.all(dp15),
//         child: SvgPicture.asset(
//           iconPath,
//           color: color,
//         )),
//   );
// }
//
// Widget buildTextFieldIconLeftDot(String iconPath, Color color) {
//   return Padding(
//       padding: EdgeInsets.all(dp3),
//       child: SvgPicture.asset(
//         iconPath,
//         color: color,
//       ));
// }
