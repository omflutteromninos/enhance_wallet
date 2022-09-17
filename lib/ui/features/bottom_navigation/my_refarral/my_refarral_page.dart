import 'package:cPocket/ui/ui_helpers/web_view.dart';
import 'package:cPocket/utils/image_util.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/ui/features/notifications/notifications_page.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'all_referral/all_referral_page.dart';
import 'my_referral_controller.dart';

class MyReferralPage extends StatefulWidget {
  const MyReferralPage({Key? key}) : super(key: key);

  @override
  _MyReferralPageState createState() => _MyReferralPageState();
}

class _MyReferralPageState extends State<MyReferralPage> {
  MyReferralController _controller = Get.put(MyReferralController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.getReferralLink();
      _controller.getReferralAndReference();
      _controller.getEarning();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          appBarMain(context, title: "My Referral".tr, rightIconAction: () {
            Get.to(() => NotificationsPage());
          }, rightIconPath: AssetConstants.ic_notification),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: dp0, horizontal: dp15),
              child: Column(
                children: [
                  VSpacer20(),
                  textBodyBold16(text: "Invite Your Contact".tr),
                  VSpacer20(),
                  textBodyNormal14(
                      text: "Share this link to your contact".tr),
                  VSpacer10(),
                  Obx(() {
                    return textWithCopyButton(
                        "Copy".tr, _controller.referralLink.value);
                  }),
                  // buttonRoundedCopyRefCode(
                  //     btnText: 'Copy'.tr,
                  //     //iconPath: AssetConstants.ic_copy_btn,
                  //     text: '32d3yacyRKAoXZttC1RQc5fSXjWgZ8mn9D',
                  //     onPressCallback: () {}),
                  VSpacer20(),
                  textBodyBold16(text: "Or".tr),
                  VSpacer20(),
                  textBodyNormal14(text: "Share your code on".tr),
                  VSpacer10(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageView(
                          imagePath: AssetConstants.ic_facebook_btn,
                          onPressCallback: () {
                            Get.to(() => WebViewPage(
                                  url: URLConstants.fbReferral +
                                      _controller.referralLink.value,
                                ));
                          }),
                      HSpacer20(),
                      imageView(
                          imagePath: AssetConstants.ic_twitter_btn,
                          onPressCallback: () {
                            Get.to(() => WebViewPage(
                                  url: URLConstants.twitterReferral +
                                      _controller.referralLink.value,
                                ));
                          }),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     buttonRoundedWithIcon(
                  //         "Facebook".tr, AssetConstants.ic_facebook, () {
                  //       Get.to(() => WebViewPage(
                  //             url: URLConstants.fbReferral +
                  //                 _controller.referralLink.value,
                  //           ));
                  //     },
                  //         bgColor: facebook,
                  //         textColor: white,
                  //         width: Get.width / 3),
                  //     buttonRoundedWithIcon(
                  //         "Twitter".tr, AssetConstants.ic_twitter, () {
                  //       Get.to(() => WebViewPage(
                  //             url: URLConstants.twitterReferral +
                  //                 _controller.referralLink.value,
                  //           ));
                  //     },
                  //         bgColor: twitter,
                  //         textColor: white,
                  //         width: Get.width / 3)
                  //   ],
                  // ),
                  VSpacer20(),
                  _referralLevelView(),
                  VSpacer20(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textAutoSize("My References".tr, width: dp150),
                      textAutoSize("See All".tr,
                          width: dp50, textAlign: TextAlign.end, onTap: () {
                        Get.to(() => const AllReferralPage(
                            fromPage: FromKey.references));
                      })
                    ],
                  ),
                  _referenceList(),
                  VSpacer20(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textAutoSize("My Earnings".tr, width: dp150),
                      textAutoSize("See All".tr,
                          width: dp50, textAlign: TextAlign.end, onTap: () {
                        Get.to(() => const AllReferralPage(
                            fromPage: FromKey.earnings));
                      })
                    ],
                  ),
                  VSpacer5(),
                  _earningList(),
                  // getTitleSellAll(
                  //     title: 'My Referrals'.tr,
                  //     action: () {
                  //       Get.to(() => SeeAllMyReferralPage());
                  //     }),
                  // VSpacer20(),
                  // Container(
                  //   decoration: getTransparentBoxWithGradient(),
                  //   height: dp70,
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       textBodyBold14(text: "Level 1".tr),
                  //       textBodyBold14(text: "Level 2".tr),
                  //       textBodyBold14(text: "Level 3".tr),
                  //     ],
                  //   ),
                  // ),
                  // _myReferralList(),
                  // VSpacer20(),
                  // getTitleSellAll(
                  //     title: 'My References'.tr,
                  //     action: () {
                  //       Get.to(() => SeeAllMyReferencesPage());
                  //     }),
                  // VSpacer20(),
                  // _myReferencesList(),
                  // VSpacer20(),
                  // getTitleSellAll(
                  //     title: 'My Earnings'.tr,
                  //     action: () {
                  //       Get.to(() => SeeAllMyEarningsPage());
                  //     }),
                  // VSpacer20(),
                  // Container(
                  //   decoration: getTransparentBoxWithGradient(),
                  //   height: dp70,
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       textBodyBold14(text: "Period".tr),
                  //       textBodyBold14(text: "Commissions".tr),
                  //     ],
                  //   ),
                  // ),
                  // _myEarningsList(),
                  VSpacer20(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _referenceList() {
    return Obx(() {
      return _controller.referenceList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoadingReference,
              message: "empty_message_reference_list".tr)
          : Column(
              children: List.generate(_controller.referenceList.length,
                  (index) => referenceItem(_controller.referenceList[index])),
            );
    });
  }

  Widget _earningList() {
    return Obx(() {
      return _controller.earningsList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoadingEarnings,
              message: "empty_message_earning_list".tr)
          : Column(
              children: List.generate(_controller.earningsList.length,
                  (index) => earningItem(_controller.earningsList[index])),
            );
    });
  }

  Widget _referralLevelView() {
    return Obx(() {
      return _controller.referralLevel.isEmpty
          ? const SizedBox()
          : Column(
              children: [
                textAutoSize("My Referrals".tr),
                const SizedBox(height: dp5),
                _referralLevelItem(
                    _controller.referralLevel.keys.toList(), true),
                _referralLevelItem(
                    _controller.referralLevel.values.toList(), false),
              ],
            );
    });
  }

  Widget _referralLevelItem(List<dynamic> dataList, bool isTitle) {
    var decoration = isTitle
        ? getTransparentGradientBoxWithTopRound() //boxDecorationTopRound(color: Get.theme.primaryColorDark.withOpacity(0.5), isGradient: true)
        : getTransparentGradientBox(); //boxDecoration(color: Get.theme.primaryColorDark.withOpacity(0.5), isGradient: true);
    //getTransparentBoxWithGradient(),getTransparentGradientBox(),
    return Container(
      decoration: decoration,
      //decoration: getTransparentBoxWithGradient(),
      padding: const EdgeInsets.symmetric(vertical: dp10, horizontal: dp10),
      //margin: const EdgeInsets.only(left: dp10, right:dp10),
      height: dp50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: textAutoSize(dataList[0].toString(),
                  fontSize: dp12, textAlign: TextAlign.center)),
          Expanded(
              flex: 1,
              child: textAutoSize(dataList[1].toString(),
                  fontSize: dp12, textAlign: TextAlign.center)),
          Expanded(
              flex: 1,
              child: textAutoSize(dataList[2].toString(),
                  fontSize: dp12, textAlign: TextAlign.center)),
        ],
      ),
    );
  }

// Widget _myReferralList() {
//   return Obx(() {
//     return _controller.myReferralList!.length == 0
//         ? emptyView()
//         : Container(
//             //height: Get.height - (dp115),
//             height: Get.height / 2.5,
//             child: ListView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: _controller.myReferralList!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return myReferralsItem();
//               },
//             ),
//           );
//   });
// }
//
// Widget _myReferencesList() {
//   return Obx(() {
//     return _controller.myReferencesList!.length == 0
//         ? emptyView()
//         : Container(
//             height: Get.height - (dp115),
//             child: ListView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: _controller.myReferencesList!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return myReferencesItem();
//               },
//             ),
//           );
//   });
// }
//
// Widget _myEarningsList() {
//   return Obx(() {
//     return _controller.myEarningsList!.length == 0
//         ? emptyView()
//         : Container(
//             //height: Get.height - (dp115),
//             height: Get.height / 2.5,
//             child: ListView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: _controller.myEarningsList!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return myEarningsItem();
//               },
//             ),
//           );
//   });
// }

}
