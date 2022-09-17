import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'notifications_controller.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  NotificationsController _controller = Get.put(NotificationsController());

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.getNotificationItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kCommonBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              buildAppBarWithBack(
                  title: "Notifications".tr, hideRightIcon: true),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //_notificationGroupedList(),
                      _notificationList(),
                      VSpacer20(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _notificationList() {
    return Obx(() {
      return _controller.notificationList.length == 0
          ? handleEmptyViewWithLoadingNotification(
              isLoading: _controller.isDataLoaded,
              message: "Sorry!! You don't have any notification.")
          : Container(
              //height: Get.height - (Get.bottomBarHeight + Get.statusBarHeight + dp 100),
              height: Get.height,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _controller.notificationList.length,
                itemBuilder: (BuildContext context, int index) {
                  // if (_controller.hasMoreData &&
                  //     index == (_controller.notificationList.length - 1)) {
                  //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  //     _controller.getNotificationItems(false);
                  //   });
                  // }

                  return notificationItemView(_controller.notificationList[index]);
                },
              ),
            );
    });
  }

  // Widget _notificationGroupedList() {
  //   // return Obx(() {
  //   //   return _controller.notificationItemList!.length == 0
  //   //       ? Container()
  //   //       :
  //   return Container(
  //     height: Get.height - dp80,
  //     child: GroupedListView<dynamic, String>(
  //       padding: EdgeInsets.zero,
  //       elements: _controller.notificationItemList,
  //       groupBy: (element) => element['group'],
  //       groupSeparatorBuilder: (String groupByValue) => _notificationSection(groupByValue),
  //       itemBuilder: (context, dynamic element) => notificationItem(),
  //       order: GroupedListOrder.DESC, // optional
  //     ),
  //   );
  //   //});
  // }

  Widget _notificationSection(String title) {
    return Container(
      height: dp30,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(child: textSubtitleDetails(title)),
          buttonText("Clear all".tr, () {}, fontSize: dp14)
        ],
      ),
    );
  }
}
