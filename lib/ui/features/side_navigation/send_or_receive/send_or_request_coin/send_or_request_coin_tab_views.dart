import 'package:cPocket/data/models/default_wallet.dart';
import 'package:cPocket/data/models/pocket_wallet/pocket_wallet.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'send_or_request_coin_controller.dart';

class SendOrRequestCoinTabViews extends StatefulWidget {
  final String? fromPage;

  const SendOrRequestCoinTabViews({Key? key, this.fromPage}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabControllerView();
}

class _TabControllerView extends State<SendOrRequestCoinTabViews> {
  SendOrRequestCoinController _controller = Get.put(SendOrRequestCoinController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.getDefaultWalletList();
    });
  }

  @override
  void didUpdateWidget(covariant SendOrRequestCoinTabViews oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.getDefaultWalletList();
    });
  }

  @override
  void dispose() {
    _controller.clearView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.fromPage == FromKey.coinRequest
        ? _coinRequest()
        : _sendCoin();
  }

  Widget _coinRequest() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: dp16, vertical: dp20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textBodyBold16(
              text: 'Send Coin Request To User Using Email Address'.tr,
              maxLines: 2),
          VSpacer20(),
          textBodyBold14(text: "User Email".tr),
          VSpacer10(),
          // textFieldBorderedMain(
          //     hintText: "User Email".tr, textInputType: TextInputType.emailAddress, text: ''),
          textFieldBorderedWithSuffixIcon(
              _controller.emailEditController,
              "User Email".tr,
              TextInputType.emailAddress),
          textSubtitleNormal12(
              text:
                  "Note Input user email where you want to send request for coin".tr,
              textColor: kAccentColorOrange,
              maxLines: 2),
          VSpacer15(),
          textBodyBold14(text: "Coin Amount".tr),
          VSpacer10(),
          textFieldBorderedWithSuffixIcon(
              _controller.amountEditController,
              "Coin".tr,
              TextInputType.number),
          VSpacer10(),
          textAutoSize(
              "Note_for_max_min_request_or_send_amount_input".trParams({
                "amountMin": _controller.generalSettings.settings!.minimumWithdrawalAmount.toString(),
                "amountMax": _controller.generalSettings.settings!.maximumWithdrawalAmount.toString(),
                "name": stringNullCheck(_controller.generalSettings.settings!.coinName),
              }),
              fontSize: dp12,color: kAccentColorOrange,
              fontWeight: FontWeight.normal,
              maxLines: 4),
          VSpacer20(),
          buttonRoundedMain(
              text: "Send Request".tr,
              onPressCallback: () {
                if (_controller.checkRequestDefaultCoinInputValues(context)) {
                  hideKeyboard(context);
                  _controller.makeDefaultCoinRequest();
                }
              }),
          VSpacer20(),
        ],
      ),
    );
  }

  Widget _sendCoin() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: dp16, vertical: dp20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textBodyBold16(
              text:
                  'Send Coin To User From Your Wallet To User Primary Wallet Using Email Address'.tr,
              maxLines: 2),
          VSpacer20(),
          textBodyBold14(text: "Select Your Wallet".tr),
          VSpacer10(),
          Obx(() {
            return dropDownList(
                _controller.getDefaultWalletNames(_controller.defaultWalletList),
                _controller.selectedDefaultWalletType.value,
                "Select".tr, (value) {
              _controller.selectedDefaultWalletType.value = value;
            });
          }),
          VSpacer15(),
          textBodyBold14(text: "Coin Amount".tr),
          VSpacer10(),
          textFieldBorderedWithSuffixIcon(
              _controller.amountEditController,
              "Coin Amount".tr,
              TextInputType.number),
          VSpacer10(),
          textAutoSize(
              "Note_for_max_min_request_or_send_amount_input".trParams({
                "amountMin": _controller.generalSettings.settings!.minimumWithdrawalAmount.toString(),
                "amountMax": _controller.generalSettings.settings!.maximumWithdrawalAmount.toString(),
                "name": stringNullCheck(_controller.generalSettings.settings!.coinName),
              }),
              fontSize: dp12,color: kAccentColorOrange,
              fontWeight: FontWeight.normal,
              maxLines: 4),
          VSpacer15(),
          textBodyBold14(text: "User Email".tr),
          VSpacer10(),
          textFieldBorderedWithSuffixIcon(
              _controller.emailEditController,
              "User Email".tr,
              TextInputType.emailAddress),
          textSubtitleNormal12(
              text:
                  "Note Input user email where you want to send coin Coin will send to his her primary wallet".tr,
              textColor: kAccentColorOrange,
              maxLines: 2),
          VSpacer20(),
          buttonRoundedMain(
              text: "Send Coin".tr,
              onPressCallback: () {
                if (_controller.checkSendDefaultWalletCoinInputValues(context)) {
                hideKeyboard(context);
                _controller.makeDefaultCoinSend();}
              }),
          VSpacer20(),
        ],
      ),
    );
  }

}
