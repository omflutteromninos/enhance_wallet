import 'dart:convert';

import 'package:cPocket/data/models/general_settings.dart';
import 'package:cPocket/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../data/local/constants.dart';
import 'colors.dart';

void showToast(String text, {bool isError = false, bool isLong = false}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor:
        isError ? Get.theme.colorScheme.secondary : Get.theme.primaryColor,
    textColor: Colors.white,
    //fontSize: 16.0
  );
}

GeneralSettings? getGeneralSettingsLocal() {
  var objMap = GetStorage().read(PreferenceKey.generalSettings);
  if (objMap != null) {
    try {
      GeneralSettings settings = GeneralSettings.fromJson(objMap);
      return settings;
    } catch (_) {
      GetUtils.printFunction("getGeneralSettingsLocal", _, "error");
    }
  }
  return null;
}

void showLoadingDialog({bool isDismissible = false}) {
  if (Get.isDialogOpen == null || !Get.isDialogOpen!) {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: isDismissible);
  }
}

void hideLoadingDialog() {
  if (Get.isDialogOpen != null && Get.isDialogOpen!) {
    Get.back();
  }
}

bool isLoggedIn() {
  return GetStorage().read(PreferenceKey.isLoggedIn);
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

void editTextFocusDisable(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}

const dateFormatYyyyMMDd = "yyyy-MM-dd";
const dateTimeFormatYyyyMMDdHhMm = "yyyy-MM-dd kk:mm";
const dateFormatMMDdYyyy = "MM/dd/yyyy";
const dateFormatDdMmYy = "dd/MM/yy";
const dateFormatMMMMDdDyyy = "MMMM dd, yyyy";
const dateTimeFormatDdMMMMYyyyHhMm = "dd MMMM yyyy | hh:mm a";

String formatDate(DateTime? dateTime, {String format = dateFormatYyyyMMDd}) {
  if (dateTime != null) {
    String formatStr = DateFormat(format).format(dateTime);
    return formatStr;
  }
  return "";
}

DateTime stringToDate(String date) {
  try {
    DateTime tempDate = new DateFormat("MM/dd/yyyy").parse(date);
    return tempDate;
  } catch (e) {
    return null!;
  }
}

String stringNullCheck(String? value) {
  return value ?? "";
}

Future<String> htmlString(String path) async {
  String fileText = await rootBundle.loadString(path);
  String htmlStr = Uri.dataFromString(fileText,
          mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
      .toString();
  return htmlStr;
}

double makeDouble(dynamic value) {
  if (value == null) {
    return 0.0;
  }

  if (value is String && value.isNotEmpty) {
    return double.parse(value);
  } else if (value is int) {
    return value.toDouble();
  } else if (value is double) {
    return value;
  }
  return 0.0;
}

DateTime? makeDate(dynamic value) {
  if (value is String && value.isNotEmpty) {
    return DateTime.parse(value);
  }
  return null;
}

int makeInt(dynamic value) {
  if (value is String && value.isNotEmpty) {
    return int.parse(value);
  } else if (value is double) {
    return value.toInt();
  } else if (value is int) {
    return value;
  }
  return 0;
}

DateTime? makesDate(Map<String, dynamic> json, String key,
    {bool isDefault = false}) {
  if (json.containsKey(key)) {
    var value = json[key];
    if (value is String && value.isNotEmpty) {
      if (!value.contains("z") && !value.contains("Z")) {
        value = value + "Z";
      }
      return DateTime.parse(value);
    }
  }
  if (isDefault) {
    return DateTime.now();
  }
  return null;
}

bool isValidPassword(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';

  String pattern2 = r'(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])\w+';
  RegExp regExp = new RegExp(pattern2);
  return regExp.hasMatch(value);
}

void copyToClipboard(String string) {
  Clipboard.setData(ClipboardData(text: string)).then((_) {
    showToast("Text copied to clipboard".tr);
  });
}

/// *** APP CUSTOM VIEWS ***///

String getUserName(User user) {
  String name = "";
  String firstName = stringNullCheck(user.firstName);
  String latsName = stringNullCheck(user.lastName);
  if (firstName.isNotEmpty) {
    name = firstName;
  }
  if (latsName.isNotEmpty) {
    name = name + " " + latsName;
  }
  return name;
}

Color getStatusColor(int? status) {
  Color statusColor = Get.theme.primaryColor;
  if (status == UserStatus.pending) {
    statusColor = yellow;
  } else if (status == UserStatus.accepted) {
    statusColor = kGreenColor;
  } else if (status == UserStatus.rejected) {
    statusColor = kRedColor;
  }
  return statusColor;
}

Color getStatusColorString(String? status) {
  Color statusColor = Get.theme.primaryColor;
  if (status == UserStatusString.pending) {
    statusColor = yellow;
  } else if (status == UserStatusString.accepted) {
    statusColor = kGreenColor;
  } else if (status == UserStatusString.rejected) {
    statusColor = kRedColor;
  }
  return statusColor;
}

Color getIdVerificationStatusColor(String? status) {
  Color statusColor = Colors.red;
  if (status == IdVerificationStatus.pending) {
    statusColor = Colors.yellow;
  } else if (status == IdVerificationStatus.accepted) {
    statusColor = Colors.green;
  } else if (status == IdVerificationStatus.rejected) {
    statusColor = Colors.red;
  }
  return statusColor;
}

String getIdVerificationStatus(String? status) {
  String statusStr = "Not submitted".tr;
  if (status == IdVerificationStatus.pending) {
    statusStr = "Pending".tr;
  } else if (status == IdVerificationStatus.accepted) {
    statusStr = "Accepted".tr;
  } else if (status == IdVerificationStatus.rejected) {
    statusStr = "Rejected".tr;
  }
  return statusStr;
}

String getUserStatus(int? status) {
  String statusStr = "Pending".tr;
  if (status == UserStatus.accepted) {
    statusStr = "Accepted".tr;
  } else if (status == UserStatus.rejected) {
    statusStr = "Rejected".tr;
  } else if (status == UserStatus.suspended) {
    statusStr = "Suspended".tr;
  } else if (status == UserStatus.deleted) {
    statusStr = "Deleted".tr;
  }
  return statusStr;
}

String getUserStatusString(String? status) {
  String statusStr = "Pending".tr;
  if (status == UserStatusString.accepted) {
    statusStr = "Accepted".tr;
  } else if (status == UserStatusString.rejected) {
    statusStr = "Rejected".tr;
  } else if (status == UserStatusString.suspended) {
    statusStr = "Suspended".tr;
  } else if (status == UserStatusString.deleted) {
    statusStr = "Deleted".tr;
  }
  return statusStr;
}

String getVerificationStatus(int? isVerified) {
  String status = "Inactive".tr;
  if (isVerified == 1) {
    status = "Active".tr;
  }
  return status;
}
