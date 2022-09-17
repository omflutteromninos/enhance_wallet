import 'package:cPocket/data/models/pocket_wallet/pocket_wallet.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Wallet_activity_log_controller.dart';
import 'wallet_activity_log_tab_List_views.dart';

class WalletActivityLogPage extends StatefulWidget {
  final PocketWallet pocketWallet;

  const WalletActivityLogPage({Key? key, required this.pocketWallet})
      : super(key: key);

  @override
  _WalletActivityLogPageState createState() => _WalletActivityLogPageState();
}

class _WalletActivityLogPageState extends State<WalletActivityLogPage> {
  WalletActivityLogController _controller = Get.put(WalletActivityLogController());
  final _tabSelectedIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    print("wallet id ${widget.pocketWallet.id}");
    return Scaffold(
      backgroundColor: kCommonBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBarWithBack(
              title: stringNullCheck(widget.pocketWallet.name),
              hideRightIcon: false,
            ),
            _getTabView(),
            VSpacer10(),
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: dp0, horizontal: dp15),
              child: _getTabBarView(),
            )),
            VSpacer10(),
          ],
        ),
      ),
    );
  }

  Widget _getTabView() {
    return Container(
      height: dp50,
      child: TabBar(
        controller: _controller.tabController,
        labelColor: kThemeTextColor,
        unselectedLabelColor: kThemeTextColor.withOpacity(0.60),
        indicatorSize: TabBarIndicatorSize.label,
        //labelPadding: EdgeInsets.only(left: dp15, right: dp15),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(dp30),
          color: kTextFieldColor,
          border: Border.all(color: kTabBorder),
        ),
        tabs: [
          _tabItem("Deposit List".tr),
          _tabItem("Withdraw List".tr),
        ],
        onTap: (int x) {
          _tabSelectedIndex.value = x;
        },
      ),
    );
  }

  Widget _tabItem(String title) {
    return Tab(
      child: Container(
        height: dp50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dp30),
          color: Colors.transparent,
        ),
        child: Align(
          alignment: Alignment.center,
          //child: Text(title, style: Get.textTheme.bodyText1),
          child: textAutoSize(title,textAlign: TextAlign.center),
        ),
      ),
    );
  }


  Widget _getTabBarView() {
    return Obx(() {
      switch (_tabSelectedIndex.value) {
        case 0:
          return WalletActivityLogTabListViews(
            fromPage: FromKey.depositList,pocketWallet: widget.pocketWallet
          );
        case 1:
          return WalletActivityLogTabListViews(
            fromPage: FromKey.withdrawList,pocketWallet: widget.pocketWallet
          );
        default:
          return Container();
      }
    });
  }
  //
  // Widget _getTabView() {
  //   return Container(
  //     height: dp25,
  //     child: TabBar(
  //       controller: _controller.tabController,
  //       labelColor: kThemeTextColor,
  //       unselectedLabelColor: kThemeSubtitleTextColor,
  //       indicatorSize: TabBarIndicatorSize.label,
  //       labelPadding: EdgeInsets.only(left: dp0, right: dp0),
  //       indicator: BoxDecoration(color: Colors.transparent),
  //       tabs: [
  //         Align(
  //             alignment: Alignment.centerLeft,
  //             child: _tabItem("Deposit List".tr)),
  //         Align(
  //             alignment: Alignment.centerLeft,
  //             child: _tabItem("Withdraw List".tr)),
  //         Align(
  //             alignment: Alignment.centerRight, child: _tabItem("See All".tr)),
  //       ],
  //       onTap: (int x) {
  //         _tabSelectedIndex.value = x;
  //       },
  //     ),
  //   );
  // }
  //
  // Widget _tabItem(String title) {
  //   return Tab(
  //     child: Text(title, style: TextStyle(fontSize: dp16)),
  //   );
  // }
  //
  // var _tabSelectedIndex = 0.obs;
  //
  // Widget _getTabBarView() {
  //   return Obx(() {
  //     switch (_tabSelectedIndex.value) {
  //       case 0:
  //         return WalletActivityLogTabViews(
  //           fromPage: FromKey.depositList,
  //         );
  //       case 1:
  //         return WalletActivityLogTabViews(
  //           fromPage: FromKey.withdrawList,
  //         );
  //       case 2:
  //         return WalletActivityLogTabViews(
  //           fromPage: FromKey.seeAll,
  //         );
  //       default:
  //         return Container();
  //     }
  //   });
  // }
}
