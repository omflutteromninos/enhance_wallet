import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'send_or_request_coin_controller.dart';
import 'send_or_request_coin_tab_views.dart';

class SendOrRequestCoinPage extends StatefulWidget {
  @override
  _SendOrRequestCoinPageState createState() => _SendOrRequestCoinPageState();
}

class _SendOrRequestCoinPageState extends State<SendOrRequestCoinPage> {
  SendOrRequestCoinController _controller = Get.put(SendOrRequestCoinController());
  //final RootController _rootPageController = Get.find<RootController>();


  @override
  void dispose() {
    _controller.clearView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kCommonBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBarWithBack(title: "SendRequest Coin".tr, hideRightIcon: false),
            VSpacer20(),
            _getTabView(),
            VSpacer20(),
            Expanded(
              child: SingleChildScrollView(
                child: _getTabBarView(),
              ),
            )
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
          _tabItem("Coin Request".tr),
          _tabItem("Send Coin".tr),
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
          return SendOrRequestCoinTabViews(
            fromPage: FromKey.coinRequest,
          );
        case 1:
          return SendOrRequestCoinTabViews(
            fromPage: FromKey.sendCoin,
          );
        default:
          return Container();
      }
    });
  }
}
