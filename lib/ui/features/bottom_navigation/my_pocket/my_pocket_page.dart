import 'package:cPocket/data/models/pocket_wallet/pocket_wallet.dart';
import 'package:cPocket/ui/features/side_navigation/send_or_receive/send_or_request_coin/send_or_request_coin_page.dart';
import 'package:cPocket/ui/features/side_navigation/swap_coin/swap_coin_page.dart';
import 'package:cPocket/utils/image_util.dart';
import 'package:cPocket/utils/text_field_util.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/alert_dialog_util.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/ui/features/notifications/notifications_page.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Wallet_activity_log/Wallet_activity_log_page.dart';
import 'deposit_wallet/deposit_wallet_page.dart';
import 'my_pocket_controller.dart';
import 'withdrawal/withdrawal_page.dart';

class MyPocketPage extends StatefulWidget {
  @override
  _MyPocketPageState createState() => _MyPocketPageState();
}

class _MyPocketPageState extends State<MyPocketPage> {
  MyPocketController _controller = Get.put(MyPocketController());

  @override
  void dispose() {
    _controller.clearAddView();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.getWalletList(false);
      _controller.getCoinList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(children: [
          appBarMain(context, title: "My Pocket".tr, rightIconAction: () {
        Get.to(() => NotificationsPage());
          }, rightIconPath: AssetConstants.ic_notification),
          VSpacer20(),
          buttonRoundedWithBorder(
          text: "Add Pocket".tr,
          margin: dp15,
          onPressCallback: () {
            showModalSheetFullScreen(_addNewPocketView(context), context,
                onClose: () {
              _controller.clearAddView();
            });
          }),
          VSpacer20(),
          Expanded(
          child: SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(horizontal: dp15, vertical: dp0),
              child: Column(children: [
                Obx(() {
                  List newList =
                      _controller.myPocketWalletGroupList.keys.toList();
                  return _controller.myPocketWalletGroupList.isEmpty
                      ? handleEmptyViewWithLoading(_controller.isLoading)
                      : Column(
                          children: List.generate(newList.length, (index) {
                            return _myPocketWalletSectionView(
                                newList[index]);
                          }),
                        );
                }),
                VSpacer20(),
              ])))
        ]));
  }

  Widget _myPocketWalletSectionView(String key) {
    List<PocketWallet> pocketWallets =
        _controller.myPocketWalletGroupList[key]!;
    return Column(children: [
      key.isEmpty
          ? Container(height: 0)
          : Column(
              children: [
                VSpacer20(),
                textAutoSize(key, fontSize: dp14),
              ],
            ),
      VSpacer10(),
      Container(
        decoration: getTransparentGradientBoxWithTopRound(),
        padding: EdgeInsets.symmetric(horizontal: dp15),
        //margin: EdgeInsets.symmetric(horizontal: dp16),
        height: dp60,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: textAutoSize("Name".tr,
                      fontSize: dp14, textAlign: TextAlign.start),
                )),
            Expanded(
                flex: 3,
                child: textAutoSize("Balance".tr,
                    fontSize: dp14, textAlign: TextAlign.start)),
            Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: textAutoSize("Action".tr,
                      fontSize: dp14, textAlign: TextAlign.start),
                )),
          ],
        ),
      ),
      Column(
        children: List.generate(pocketWallets.length,
            (index) => _myPocketWalletItem(pocketWallets[index])),
      ),
      //VSpacer10(),
    ]);
  }

  Widget _myPocketWalletItem(PocketWallet pocketWallet) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: dp0, horizontal: dp15),
          //margin: const EdgeInsets.symmetric(vertical: dp0, horizontal: dp10),
          //decoration: boxDecoration(color: Get.theme.primaryColorDark.withOpacity(0.5), isGradient: true),
          height: dp60,
          decoration: getTransparentGradientBox(),
          child: InkWell(
            onTap: () {},
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: textAutoSize(stringNullCheck(pocketWallet.name),
                          fontSize: dp14,
                          maxLines: 2,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.start),
                    )),
                Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: textAutoSize(
                              pocketWallet.balance.toString() +
                                  " " +
                                  pocketWallet.coinType.toString(),
                              textAlign: TextAlign.start,
                              fontSize: dp14,
                              fontWeight: FontWeight.normal,
                              maxLines: 2),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HSpacer0(),
                      iconWithTap(AssetConstants.ic_action_show, onPress: () {
                        showModalSheetFullScreen(
                            _showWalletDetailsView(pocketWallet), context);
                      }),
                      iconWithTap(AssetConstants.ic_action_wallet_deposit,
                          onPress: () {
                        Get.to(() =>
                            DepositWalletPage(pocketWallet: pocketWallet));
                      }),
                      iconWithTap(AssetConstants.ic_action_withdraw,
                          onPress: () {
                        Get.to(
                            () => WithdrawalPage(pocketWallet: pocketWallet));
                      }),
                      iconWithTap(AssetConstants.ic_action_wallet_activity_log,
                          onPress: () {
                        Get.to(() =>
                            WalletActivityLogPage(pocketWallet: pocketWallet));
                      }),
                      iconWithTap(AssetConstants.ic_action_swap, onPress: () {
                        Get.to(() => SwapCoinPage());
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _showWalletDetailsView(PocketWallet pocketWallet) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: dp15, horizontal: dp15),
      margin: const EdgeInsets.symmetric(vertical: dp16, horizontal: dp16),
      decoration:
          boxDecorationRoundCorner(color: primaryDark.withOpacity(0.96)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VSpacer10(),
          textAutoSize(stringNullCheck(pocketWallet.name),
              hMargin: dp0, fontWeight: FontWeight.w900),
          VSpacer20(),
          twoTextItem("Coin_Type_colon".tr, pocketWallet.coinType),
          VSpacer20(),
          twoTextItem("Balance_colon".tr, pocketWallet.balance.toString()),
          VSpacer20(),
          twoTextItem("Referral_Balance_colon".tr,
              pocketWallet.referralBalance.toString()),
          VSpacer20(),
          twoTextItem(
              "Updated_At_colon".tr,
              formatDate(pocketWallet.updatedAt,
                  format: dateTimeFormatDdMMMMYyyyHhMm)),
          VSpacer20(),
          Wrap(
            direction: Axis.horizontal,
            spacing: dp10,
            runSpacing: dp10,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            textDirection: TextDirection.ltr,
            children: [
              // imageViewWithRoundedBox(
              //     imagePath: AssetConstants.ic_action_key,
              //     onPressCallback: () {},
              //     iconHeightSize: dp25),
              imageViewWithRoundedBox(
                  imagePath: AssetConstants.ic_action_wallet_deposit,
                  onPressCallback: () {
                    Get.to(() => DepositWalletPage(pocketWallet: pocketWallet));
                  },
                  iconHeightSize: dp25),
              imageViewWithRoundedBox(
                  imagePath: AssetConstants.ic_action_withdraw,
                  onPressCallback: () {
                    Get.to(() => WithdrawalPage(pocketWallet: pocketWallet));
                  },
                  iconHeightSize: dp25),
              imageViewWithRoundedBox(
                  imagePath: AssetConstants.ic_action_wallet_activity_log,
                  onPressCallback: () {
                    Get.to(() =>
                        WalletActivityLogPage(pocketWallet: pocketWallet));
                  },
                  iconHeightSize: dp25),
              imageViewWithRoundedBox(
                  imagePath: AssetConstants.ic_action_send_receive_coin,
                  onPressCallback: () {
                    Get.to(() => SendOrRequestCoinPage());
                  },
                  iconHeightSize: dp25),
              imageViewWithRoundedBox(
                  imagePath: AssetConstants.ic_action_swap,
                  onPressCallback: () {
                    Get.to(() => SwapCoinPage());
                  },
                  iconHeightSize: dp25),
              // imageViewWithRoundedBox(
              //     imagePath: AssetConstants.ic_action_coin2,
              //     onPressCallback: () {},
              //     iconHeightSize: dp25),
            ],
          ),
          VSpacer10(),
        ],
      ),
    );
  }

  Widget _addNewPocketView(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: dp10, horizontal: dp10),
      margin: const EdgeInsets.symmetric(vertical: dp16, horizontal: dp16),
      decoration: boxDecorationRoundCorner(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VSpacer10(),
          textAutoSize("Want to add new pocket".tr,
              textAlign: TextAlign.center),
          VSpacer10(),
          textAutoSize("Wallet Name".tr,
              fontSize: dp14, fontWeight: FontWeight.normal),
          textFieldBorderedWithSuffixIcon(_controller.nameEditController,
              "Write your pocket name".tr, TextInputType.text),
          VSpacer10(),
          textAutoSize("Coin Type".tr,
              fontSize: dp14, fontWeight: FontWeight.normal),
          Obx(() {
            return dropDownList2(
                _controller.getCoinNames(),
                _controller.selectedCoinType.value,
                "Select coin type".tr, (value) {
              _controller.selectedCoinType.value = value;
            });
          }),
          buttonRoundedFill("Add wallet".tr, () {
            _controller.addWallet(context);
          }),
        ],
      ),
    );
  }
}
