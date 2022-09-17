import 'package:flutter/cupertino.dart';
import 'package:cPocket/ui/features/notifications/notifications_page.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'membership_club_controller.dart';
import 'membership_club_tab_views.dart';

class MembershipClubPage extends StatefulWidget {
  @override
  _MembershipClubPageState createState() => _MembershipClubPageState();
}

class _MembershipClubPageState extends State<MembershipClubPage> {
  MembershipClubPageController _controller =
      Get.put(MembershipClubPageController());
  var mainHeight, mainWidth;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      //_controller.getMembershipDetails();
    });
  }

  @override
  void dispose() {
    _controller.clearView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          appBarMain(context, title: "Membership Club".tr,
              rightIconAction: () {
            Get.to(() =>NotificationsPage());
          }, rightIconPath: AssetConstants.ic_notification),
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
          _tabItem("Transfer Coin".tr),
          _tabItem("My Membership".tr),
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
          return MembershipClubTabViews(
            fromPage: FromKey.transferCoin,
          );
        case 1:
          return MembershipClubTabViews(
            fromPage: FromKey.myMembership,
          );
        default:
          return Container();
      }
    });
  }
}
