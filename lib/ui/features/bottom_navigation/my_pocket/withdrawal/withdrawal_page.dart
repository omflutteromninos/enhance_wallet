import 'package:cPocket/data/models/pocket_wallet/pocket_wallet.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/image_util.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/alert_dialog_util.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'withdrawal_controller.dart';

class WithdrawalPage extends StatefulWidget {
  final PocketWallet pocketWallet;

  const WithdrawalPage({Key? key, required this.pocketWallet})
      : super(key: key);

  @override
  _WithdrawalPageState createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  WithdrawalController _controller = Get.put(WithdrawalController());

  @override
  void initState() {
    super.initState();
    // _controller.setCoin(widget.pocketWallet);
    // _controller.getCoinList();
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
            buildAppBarWithBack(
              title: stringNullCheck(widget.pocketWallet.name),
              hideRightIcon: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: dp15, vertical: dp0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VSpacer20(),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: dp30, horizontal: dp15),
                      decoration: getRoundSoftTransparentBox(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          textNormalCenter22(text: "Available Balance".tr),
                          VSpacer20(),
                          textAutoSize(
                              stringNullCheck(
                                  widget.pocketWallet.balance.toString() +
                                      " " +
                                      widget.pocketWallet.coinType.toString()),
                              fontSize: dp32,
                              textAlign: TextAlign.center,
                              color: kAccentColorOrange,
                              maxLines: 2),
                          // VSpacer20(),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     textBodyNormal16(text: "\$ "),
                          //     textBodyNormal16(
                          //         text: stringNullCheck(widget
                          //             .pocketWallet.referralBalance
                          //             .toString()),
                          //         maxLines: 2),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    VSpacer20(),
                    textAutoSize("To".tr,
                        fontSize: dp14, fontWeight: FontWeight.normal),
                    textFieldBorderedWithSuffixIcon(
                        _controller.addressEditController,
                        "Address".tr,
                        TextInputType.text),
                    VSpacer10(),
                    textAutoSize(
                        "Note_for_withdrawal_address_input".trParams({"name": stringNullCheck(widget.pocketWallet.coinType)}),
                        fontSize: dp12,
                        fontWeight: FontWeight.normal,
                        maxLines: 2,
                        color: kAccentColorOrange),
                    textAutoSize(
                        "Warning_Note_for_withdrawal_address_input".trParams({"name": stringNullCheck(widget.pocketWallet.coinType)}),
                        fontSize: dp12,
                        fontWeight: FontWeight.normal,
                        maxLines: 4,
                        color: kRedColor),
                    VSpacer20(),
                    textAutoSize("Amount".tr,
                        fontSize: dp14, fontWeight: FontWeight.normal),
                    textFieldBorderedWithSuffixIcon(
                        _controller.amountEditController,
                        "Amount".tr,
                        TextInputType.number),
                    VSpacer10(),
                    textAutoSize(
                        "Note_for_withdrawal_amount_input".trParams({
                          "name": stringNullCheck(widget.pocketWallet.coinType),
                          "amountMin": stringNullCheck(widget.pocketWallet.minimumWithdrawal.toString()),
                          "amountMax": stringNullCheck(widget.pocketWallet.maximumWithdrawal.toString())
                          // "amountMin": stringNullCheck(_controller.generalSettings?.settings?.minimumWithdrawalAmount?.toString()),
                          // "amountMax": stringNullCheck(_controller.generalSettings?.settings?.maximumWithdrawalAmount?.toString())
                        }),
                        fontSize: dp12,color: kAccentColorOrange,
                        fontWeight: FontWeight.normal,
                        maxLines: 4),
                    VSpacer20(),
                    textAutoSize("Note".tr,
                        fontSize: dp14, fontWeight: FontWeight.normal),
                    textFieldBorderedWithSuffixIcon(
                        _controller.noteEditController,
                        "Type your message here (Optional)".tr,
                        TextInputType.text,
                        maxLines: 4),
                    VSpacer10(),
                    buttonRoundedFill("Submit".tr, () {
                      if (_controller.checkWithdrawCondition()) {
                        if (_controller.checkInputValues(context)) {
                          hideKeyboard(context);
                          showModalSheetFullScreen(show2FACodeView(context), context, onClose: () {
                            _controller.codeEditController.text = "";
                          });
                        }
                      }
                    })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget show2FACodeView(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: dp10, horizontal: dp10),
      margin: const EdgeInsets.symmetric(vertical: dp16, horizontal: dp16),
      decoration: boxDecorationRoundCorner(),
      child: Column(
        children: [
          VSpacer20(),
          iconWithTap(AssetConstants.ic_google_authenticator,
              size: Get.width / 4),
          VSpacer20(),
          textAutoSize("Google Authenticator withdraw message".tr,
              fontSize: dp12,
              fontWeight: FontWeight.w100,
              maxLines: 3,
              textAlign: TextAlign.center),
          VSpacer10(),
          textAutoSize("Code".tr,
              fontSize: dp10, fontWeight: FontWeight.normal),
          textFieldBorderedWithSuffixIcon(_controller.codeEditController,
              "Your Code".tr, TextInputType.number),
          VSpacer10(),
          buttonRoundedFill("Withdrawal".tr, () {
            hideKeyboard(context);
            _controller.makeWithdraw(widget.pocketWallet);
          }),
        ],
      ),
    );
  }
}
