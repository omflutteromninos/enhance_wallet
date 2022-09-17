import 'package:cPocket/data/models/general_settings.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/ui/features/notifications/notifications_page.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'buy_coin_controller.dart';
import 'buy_coin_tab_views.dart';

class BuyCoinPage extends StatefulWidget {
  @override
  _BuyCoinPageState createState() => _BuyCoinPageState();
}

class _BuyCoinPageState extends State<BuyCoinPage> {
  BuyCoinPageController _controller = Get.put(BuyCoinPageController());
  GeneralSettings generalSettings =
      Get.find<RootController>().generalSettings.value;

  @override
  void initState() {
    super.initState();
    _controller.initViewData();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.getBuyCoinAndPhaseInformation();
    });
  }

  @override
  void dispose() {
    _controller.clearView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          appBarMain(context, title: "Buy Coin".tr, rightIconAction: () {
            Get.to(() => NotificationsPage());
          }, rightIconPath: AssetConstants.ic_notification),
          VSpacer20(),
          _getTabView(),
          VSpacer20(),
          _getTabBarView()
        ],
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
          _tabItem("Buy Coin".tr),
          _tabItem("Buy Coin History".tr),
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

  var _tabSelectedIndex = 0.obs;

  Widget _getTabBarView() {
    return Obx(() {
      switch (_tabSelectedIndex.value) {
        case 0:
          return BuyCoinTabViews(
            fromPage: FromKey.buyCoin,
          );
        case 1:
          return BuyCoinTabViews(
            fromPage: FromKey.buyCoinHistory,
          );
        default:
          return Container();
      }
    });
  }
}
