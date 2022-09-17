import 'dart:io';
import 'package:cPocket/ui/features/notifications/notifications_page.dart';
import 'package:cPocket/utils/chart_util.dart';
import 'package:cPocket/utils/image_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dasboard_tab_list_page.dart';
import 'dashboard_controller.dart';
import 'deposite_or_withdraw_list/deposit_or_withdraw_list_page.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  DashBoardController _controller = Get.put(DashBoardController());
  final _tabSelectedIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.getDashBoardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          appBarMain(context, title: "Dashboard".tr, rightIconAction: () {
            Get.to(() => NotificationsPage());
          }, rightIconPath: AssetConstants.ic_notification),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  VSpacer10(),
                  tradingScriptView(),
                  VSpacer10(),
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          coinCard1(),
                          coinCard2(),
                          coinCard3(),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   height: dp150,
                  //   child: ListView.builder(
                  //       itemCount: 3,
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: (ctx, index) {
                  //         return CoinCard();
                  //       }),
                  // ),
                  VSpacer20(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: dp0, horizontal: dp15),
                    child: Column(
                      children: [
                        textBodyBold16(text: "Deposit Withdraw".tr),
                        VSpacer20(),
                        // imageView(
                        //     imagePath: AssetConstants.chart1,
                        //     width: Get.width),
                        // Obx(() {
                        //   return ChartUtil().buildSplineChart(
                        //       _controller.dashBoardData.value.monthlyDeposit ?? [],
                        //       _controller.dashBoardData.value.monthlyWithdrawal ?? [],
                        //       lineColor: brightTurquoise);
                        // }),
                        Obx(() {
                          return ChartUtil().buildSplineChart(
                              _controller
                                      .dashBoardData.value.monthlyDeposit ??
                                  [],
                              _controller.dashBoardData.value
                                      .monthlyWithdrawal ??
                                  []);
                        }),
                        VSpacer20(),
                        textBodyBold16(text: "Buy Coin Report".tr),
                        VSpacer20(),
                        Obx(() {
                          return ChartUtil().buildBarChart(
                              //_controller.dashBoardData.value.lastSixMonth ?? [],
                              _controller
                                      .dashBoardData.value.monthlyBuyCoin ??
                                  []);
                          //return ChartUtil().buildBarChart(_controller.dashBoardData.value.lastSixMonth ?? [], [0.3, 0.4, 0.5, 0.8, 0.9, 0.0], [0.3, 0.4, 0.2, 0.8, 0.0, 0.4]);
                        }),
                        VSpacer20(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _getTabView(),
                            textAutoSize("See All".tr,
                                width: dp50,
                                fontSize: dp16,
                                textAlign: TextAlign.end, onTap: () {
                              Get.to(() => DepositOrWithdrawListPage(
                                    fromPage:
                                        _controller.currentTransactionListKey,
                                  ));
                            })
                          ],
                        ),
                        VSpacer20(),
                        _getTabBarView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getTabView() {
    return SizedBox(
      width: dp220,
      child: TabBar(
        controller: _controller.tabController,
        labelColor: kThemeTextColor,
        unselectedLabelColor: kThemeSubtitleTextColor,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: EdgeInsets.only(left: dp0, right: dp10),
        indicator: BoxDecoration(color: Colors.transparent),
        tabs: [
          Tab(child: textAutoSize("Deposit List".tr)),
          Tab(child: textAutoSize("Withdraw List".tr))
        ],
        onTap: (int x) {
          _tabSelectedIndex.value = x;
        },
      ),
    );
  }

  Widget _getTabBarView() {
    return Obx(() {
      switch (_tabSelectedIndex.value) {
        case 0:
          _controller.currentTransactionListKey = FromKey.deposit;
          return DashboardTabListPage(
              fromPage: _controller.currentTransactionListKey);
        case 1:
          _controller.currentTransactionListKey = FromKey.withdraw;
          return DashboardTabListPage(
              fromPage: _controller.currentTransactionListKey);
        default:
          return Container();
      }
    });
  }

  Widget coinCard1() {
    return Container(
      height: dp160,
      width: dp140,
      decoration: CoinOverviewBoxDecoration(
          color1: kCoinBox1, color2: kCoinBox1Second, radius: dp10),
      margin: EdgeInsets.symmetric(horizontal: dp5),
      padding: EdgeInsets.symmetric(horizontal: dp15, vertical: dp15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageView(
              imagePath: AssetConstants.ic_money,
              iconColor: Colors.white,
              height: 25),
          VSpacer5(),
          textBodyNormalWhite14(text: 'Total'.tr),
          VSpacer8(),
          textBodyNormalWhite14(text: 'Available Coin'.tr),
          VSpacer8(),
          //textBodyNormalWhite20(text: '2.976.50'),
          Obx((){
            return textAutoSize(stringNullCheck(_controller.dashBoardData.value.balance.toString()),
                maxLines: 2,
                fontSize: 20,
                lineHeight: 1.1,
                fontWeight: FontWeight.w900,
                color: Colors.white);
          })
          //textBodyNormalWhite20(text: _controller.dashBoardData.value.balance, maxLines: 2)
        ],
      ),
    );
  }

  Widget coinCard2() {
    return Container(
      height: dp160,
      width: dp140,
      decoration: CoinOverviewBoxDecoration(
          color1: kCoinBox2, color2: kCoinBox2Second, radius: dp10),
      margin: EdgeInsets.symmetric(horizontal: dp5),
      padding: EdgeInsets.symmetric(horizontal: dp15, vertical: dp15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageView(
              imagePath: AssetConstants.ic_blocked_coin,
              iconColor: Colors.white,
              height: 25),
          VSpacer5(),
          textBodyNormalWhite14(text: 'Total'.tr),
          VSpacer8(),
          textBodyNormalWhite14(text: 'Blocked Coin'.tr),
          VSpacer8(),
          Obx((){
            return textAutoSize(
                stringNullCheck(_controller.dashBoardData.value.blockedCoin.toString()),
                maxLines: 2,
                fontSize: 20,
                lineHeight: 1.1,
                fontWeight: FontWeight.w900,
                color: Colors.white);
          })
          //textBodyNormalWhite20(text: _controller.dashBoardData.value.blockedCoin, maxLines: 2)
        ],
      ),
    );
  }

  Widget coinCard3() {
    return Container(
      height: dp160,
      width: dp140,
      decoration: CoinOverviewBoxDecoration(
          color1: kCoinBox3, color2: kCoinBox3Second, radius: dp10),
      margin: EdgeInsets.symmetric(horizontal: dp5),
      padding: EdgeInsets.symmetric(horizontal: dp15, vertical: dp15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageView(
              imagePath: AssetConstants.ic_money,
              iconColor: Colors.white,
              height: 25),
          VSpacer5(),
          textBodyNormalWhite14(text: 'Total'.tr),
          VSpacer8(),
          textBodyNormalWhite14(text: 'Total Buy Coin'.tr),
          VSpacer8(),
          Obx(() {
            return textAutoSize(
                stringNullCheck(_controller.dashBoardData.value.totalBuyCoin.toString()),
                maxLines: 2,
                fontSize: 20,
                lineHeight: 1.1,
                fontWeight: FontWeight.w900,
                color: Colors.white);
          })
          //textBodyNormalWhite20(text: _controller.dashBoardData.value.totalBuyCoin, maxLines: 2)
        ],
      ),
    );
  }
}
