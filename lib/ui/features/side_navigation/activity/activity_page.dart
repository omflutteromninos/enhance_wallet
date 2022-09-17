import 'package:cPocket/data/models/activity.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'activity_controller.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final ActivityController _controller = Get.put(ActivityController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.getActivityList(isFromLoadMore: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kCommonBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                buildAppBarWithBack(title: "Activity".tr, hideRightIcon: true),
                Obx(() {
                  return _controller.activityList.isEmpty
                      ? const SizedBox(
                          height: 1,
                        )
                      : _sectionHeaderView();
                }),
                _activityList()
                //VSpacer20(),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: dp16),
                //   //height: Get.height - 94,
                //   child: Column(
                //     children: [
                //       Obx(() {
                //         return _controller.activityList.isEmpty
                //             ? handleEmptyViewWithLoading(
                //                 _controller.isLoading) //Container()//emptyView()
                //             : Column(
                //                 children: [
                //                   _sectionHeaderView(),
                //                   _activityList(),
                //                 ],
                //               );
                //       }),
                //       // Obx(() {
                //       //   return _controller.activityList.isEmpty
                //       //       ? VSpacer1()
                //       //       : _sectionHeaderView();
                //       // }),
                //       // _activityList(),
                //       VSpacer10(),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ));
  }

  Widget _sectionHeaderView() {
    return Container(
      decoration: getTransparentGradientBoxWithTopRound(),
      padding: EdgeInsets.symmetric(horizontal: dp15),
      //margin: EdgeInsets.symmetric(horizontal: dp16),
      height: dp60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 1, child: textAutoSize("Action".tr, fontSize: dp14)),
          Expanded(
              flex: 2,
              child: textAutoSize("IP Address".tr,
                  fontSize: dp14, textAlign: TextAlign.center)),
          Expanded(
              flex: 2,
              child: textAutoSize("Updated At".tr,
                  fontSize: dp14, textAlign: TextAlign.end)),
        ],
      ),
    );
  }

  Widget _activityList() {
    return Obx(() {
      return _controller.activityList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoading)
          : Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _controller.activityList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_controller.hasMoreData &&
                      index == (_controller.activityList.length - 1)) {
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                      _controller.getActivityList(isFromLoadMore: true);
                    });
                  }
                  return _activityItem(_controller.activityList[index]);
                },
              ),
            );
    });
  }

  Widget _activityItem(Activity activity) {
    String actionString =
        "${stringNullCheck(activity.action)}\n${stringNullCheck(activity.source)}";
    return Container(
      padding: EdgeInsets.symmetric(vertical: dp0, horizontal: dp15),
      decoration: getTransparentGradientBox(),
      //margin: EdgeInsets.symmetric(horizontal: dp0, vertical: dp0),
      height: dp60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              child: textAutoSize(actionString, fontSize: dp12, maxLines: 2)),
          Expanded(
            flex: 2,
            child: textAutoSize(stringNullCheck(activity.ipAddress),
                fontSize: dp12, maxLines: 2, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 2,
            child: textAutoSize(
                formatDate(activity.updatedAt,
                    format: dateTimeFormatDdMMMMYyyyHhMm),
                fontSize: dp12,
                textAlign: TextAlign.right,
                maxLines: 2),
          ),
        ],
      ),
    );
  }

//
// Widget _activityList() {
//   return Container(
//     height: Get.height - 164,
//     child: Expanded(
//       child: ListView.builder(
//         scrollDirection: Axis.vertical,
//         itemCount: _controller.activityList.length,
//         itemBuilder: (BuildContext context, int index) {
//           if (_controller.hasMoreData &&
//               index == (_controller.activityList.length - 1)) {
//             WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
//               _controller.getActivityList(isFromLoadMore: true);
//             });
//           }
//           return _activityItem(_controller.activityList[index]);
//         },
//       ),
//     ),
//   );
// }

// Widget _activityList() {
//   return Obx(() {
//     return _controller.activityList.isEmpty
//         ? handleEmptyViewWithLoading(_controller.isLoading)
//         : Expanded(
//             child: ListView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: _controller.activityList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 if (_controller.hasMoreData &&
//                     index == (_controller.activityList.length - 1)) {
//                   WidgetsBinding.instance!.addPersistentFrameCallback((timeStamp) {
//                    // _controller.getActivityList(isFromLoadMore: true);
//                   });
//                 }
//                 return _activityItem(_controller.activityList[index]);
//               },
//             ),
//           );
//   });
// }

}
