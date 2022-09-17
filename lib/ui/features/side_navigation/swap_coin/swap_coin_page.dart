import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'swap_coin_controller.dart';
import 'swap_coin_tab_views.dart';

class SwapCoinPage extends StatefulWidget {
 // const SwapCoinPage({Key? key}) : super(key: key);

  @override
  _SwapCoinPageState createState() => _SwapCoinPageState();
}

class _SwapCoinPageState extends State<SwapCoinPage> {
  SwapCoinController _controller = Get.put(SwapCoinController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // _controller.getSwapCoinAllWalletList();
      // _controller.getAllSwapCoinHistoryList();
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
      backgroundColor: kCommonBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBarWithBack(title: "Swap Coin".tr, hideRightIcon: false),
            VSpacer20(),
            _getTabView(),
            VSpacer20(),
            _getTabBarView(),
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
          _tabItem("Swap Coin".tr),
          _tabItem("Swap Coin History".tr),
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
          return SwapCoinTabViews(
            fromPage: FromKey.swapCoin,
          );
        case 1:
          return SwapCoinTabViews(
            fromPage: FromKey.swapCoinHistory,
          );
        default:
          return Container();
      }
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: kCommonBackgroundColor,
  //     body: SafeArea(
  //       child: Column(
  //         children: [
  //           buildAppBarWithBack(
  //             title: "Swap Coin".tr,
  //             hideRightIcon: false,
  //           ),
  //           Expanded(
  //             child: SingleChildScrollView(
  //               padding: EdgeInsets.symmetric(horizontal: dp15, vertical: dp0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.symmetric(
  //                         vertical: dp20, horizontal: dp15),
  //                     decoration: getRoundSoftTransparentBox(),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         textAutoSize("Select From Coin Wallet".tr,
  //                             fontSize: dp14, fontWeight: FontWeight.bold),
  //                         VSpacer5(),
  //                         Obx(() {
  //                           return dropDownList(
  //                               _controller.getWalletNamesList(),
  //                               _controller.selectedWalletFrom.value,
  //                               "Select".tr, (value) {
  //                             _controller.selectedWalletFrom.value = value;
  //                             _controller.checkSelection();
  //                           });
  //                         }),
  //                         VSpacer10(),
  //                         textAutoSize("Swap with".tr,
  //                             fontSize: dp14, fontWeight: FontWeight.bold),
  //                         VSpacer5(),
  //                         Obx(() {
  //                           return dropDownList(
  //                               _controller.getWalletNamesList(),
  //                               _controller.selectedWalletTo.value,
  //                               "Select".tr, (value) {
  //                             _controller.selectedWalletTo.value = value;
  //                             _controller.checkSelection();
  //                           });
  //                         }),
  //                         VSpacer20(),
  //                         textBodyBold14(text: "Coin Amount".tr),
  //                         VSpacer10(),
  //                         textFieldBorderedWithSuffixIcon(_controller.amountEditController, "Coin".tr, TextInputType.number,
  //                         onTextChange: (text) {
  //                           _controller.onTextChanged(_controller.amountEditController.text);
  //                         }),
  //                         VSpacer10(),
  //                         Obx(() {
  //                            return _controller.swapCoinRate.value.toWallet == null
  //                           //return _controller.selectedWalletFrom.value.isEmpty && _controller.selectedWalletTo.value.isEmpty
  //                               ? Container(height: 0)
  //                               : textAutoSize("Converted swap_coin coin rate text".trParams({
  //                                     "coinAmountFrom": _controller.swapCoinRate.value.amount.toString(),
  //                                     "coinTypeFrom": stringNullCheck(_controller.swapCoinRate.value.fromWallet!.coinType),
  //                                     "coinAmountTo": _controller.swapCoinRate.value.convertRate.toString(),
  //                                     "coinTypeTo": stringNullCheck(_controller.swapCoinRate.value.toWallet!.coinType),
  //                                   }),
  //                                   fontSize: dp14,
  //                                   color: kAccentColorOrange,
  //                                   fontWeight: FontWeight.normal,
  //                                   maxLines: 2);
  //                         }),
  //                         VSpacer20(),
  //                         buttonRoundedMain(
  //                             text: "Next".tr,
  //                             onPressCallback: () {
  //                               if (_controller
  //                                   .checkSwapCoinInputValues(context)) {
  //                                 hideKeyboard(context);
  //                                 _controller.makeSwapCoin();
  //                               }
  //                             }),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }


}
