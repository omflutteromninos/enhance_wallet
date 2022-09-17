import 'package:cPocket/data/models/general_settings.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'swap_coin_controller.dart';

class SwapCoinTabViews extends StatefulWidget {
  //final BuyCoinAndPhaseInformation buyCoinAndPhaseInformation;
  final String? fromPage;

  const SwapCoinTabViews({Key? key, this.fromPage}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabControllerView();
}

class _TabControllerView extends State<SwapCoinTabViews> {
  SwapCoinController _controller = Get.put(SwapCoinController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.fromPage == FromKey.swapCoin
          ? _controller.getSwapCoinAllWalletList()
          : _controller.getAllSwapCoinHistoryList(false);
    });
  }

  @override
  void didUpdateWidget(covariant SwapCoinTabViews oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.fromPage == FromKey.swapCoin
          ? _controller.getSwapCoinAllWalletList()
          : _controller.getAllSwapCoinHistoryList(false);
    });
  }

  @override
  void dispose() {
    _controller.clearView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.fromPage == FromKey.swapCoin
        ? Expanded(child: SingleChildScrollView(child: _swapCoin()))
       // ? _swapCoin()
        : _swapCoinHistoryList();
  }

  Widget _swapCoin() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: dp16, vertical: dp0),
      //height: Get.height-226,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
              decoration: getRoundSoftTransparentBox(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textAutoSize("Select From Coin Wallet".tr,
                      fontSize: dp14, fontWeight: FontWeight.bold),
                  VSpacer5(),
                  Obx(() {
                    return dropDownList2(
                        _controller.getWalletNamesList(),
                        _controller.selectedWalletFrom.value,
                        "Select".tr, (value) {
                      _controller.selectedWalletFrom.value = value;
                      _controller.checkSelection();
                    });
                  }),
                  VSpacer10(),
                  textAutoSize("Swap with".tr,
                      fontSize: dp14, fontWeight: FontWeight.bold),
                  VSpacer5(),
                  Obx(() {
                    return dropDownList2(_controller.getWalletNamesList(),
                        _controller.selectedWalletTo.value, "Select".tr, (value) {
                      _controller.selectedWalletTo.value = value;
                      _controller.checkSelection();
                    });
                  }),
                  VSpacer20(),
                  textBodyBold14(text: "Coin Amount".tr),
                  VSpacer10(),
                  textFieldBorderedWithSuffixIcon(
                      _controller.amountEditController,
                      "Coin".tr,
                      TextInputType.number, onTextChange: (text) {
                    _controller
                        .onTextChanged(_controller.amountEditController.text);
                  }),
                  VSpacer10(),
                  Obx(() {
                    return _controller.swapCoinRate.value.toWallet == null
                        //return _controller.selectedWalletFrom.value.isEmpty && _controller.selectedWalletTo.value.isEmpty
                        ? Container(height: 0)
                        : textAutoSize(
                            "Converted swap_coin coin rate text".trParams({
                              "coinAmountFrom": _controller
                                  .swapCoinRate.value.amount
                                  .toString(),
                              "coinTypeFrom": stringNullCheck(_controller
                                  .swapCoinRate.value.fromWallet!.coinType),
                              "coinAmountTo": _controller
                                  .swapCoinRate.value.convertRate
                                  .toString(),
                              "coinTypeTo": stringNullCheck(_controller
                                  .swapCoinRate.value.toWallet!.coinType),
                            }),
                            fontSize: dp14,
                            color: kAccentColorOrange,
                            fontWeight: FontWeight.normal,
                            maxLines: 2);
                  }),
                  VSpacer20(),
                  buttonRoundedMain(
                      text: "Next".tr,
                      onPressCallback: () {
                        if (_controller.checkSwapCoinInputValues(context)) {
                          hideKeyboard(context);
                          _controller.makeSwapCoin();
                        }
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget _swapCoinHistoryList() {
  //   return Obx(() {
  //     String message = "empty_message_swap_coin_history_list".tr;
  //     return _controller.swapCoinHistoryList.isEmpty
  //         ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
  //         : Column(
  //             children: List.generate(
  //                 _controller.swapCoinHistoryList.length,
  //                 (index) => swapCoinHistoryItem(
  //                     _controller.swapCoinHistoryList[index])),
  //           );
  //   });
  // }

  Widget _swapCoinHistoryList() {
    return Obx(() {
      String message = "empty_message_swap_coin_history_list".tr;
      return _controller.swapCoinHistoryList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
          : Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _controller.swapCoinHistoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_controller.hasMoreData && index == (_controller.swapCoinHistoryList.length - 1)) {
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                      _controller.getAllSwapCoinHistoryList(true);
                    });
                  }
                  return swapCoinHistoryItem(_controller.swapCoinHistoryList[index]);
                },
              ),
            );
    });
  }
}
