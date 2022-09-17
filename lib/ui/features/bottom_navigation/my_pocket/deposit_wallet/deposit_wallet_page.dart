import 'package:cPocket/data/models/pocket_wallet/past_address.dart';
import 'package:cPocket/data/models/pocket_wallet/pocket_wallet.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'deposit_wallet_controller.dart';

class DepositWalletPage extends StatefulWidget {final PocketWallet pocketWallet;

  const DepositWalletPage({Key? key, required this.pocketWallet})
      : super(key: key);

  @override
  _DepositWalletPageState createState() => _DepositWalletPageState();
}

class _DepositWalletPageState extends State<DepositWalletPage> {
  DepositWalletPageController _controller = Get.put(DepositWalletPageController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.getWalletAddress(widget.pocketWallet);
    });
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: dp15, vertical: dp0),
                  //height: Get.height+80,
                  child: Column(
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
                            //textNormalCenter32(text: "10.00075 BTC"),
                            textAutoSize(
                                stringNullCheck(widget.pocketWallet.balance
                                        .toString() +
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
                      VSpacer30(),
                      Obx(() {
                        return qrView(_controller.currentAddress.value);
                      }),
                      VSpacer30(),
                      Obx(() {
                        return textWithCopyButton(
                            "Copy".tr, _controller.currentAddress.value);
                      }),
                      VSpacer20(),
                      buttonRoundedWithBorder(
                          text: "Generate New Address".tr,
                          margin: dp0,
                          onPressCallback: () {
                            _controller.generateNewAddress(widget.pocketWallet);
                          }),
                      VSpacer20(),
                      buttonRoundedMain(
                          text: "Show Past Address".tr,
                          onPressCallback: () {
                            _controller.getPastAddresses(widget.pocketWallet);
                          }),
                      VSpacer10(),
                      _addressList(),
                      VSpacer15(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _addressList() {
    return Obx(() {
      var address = _controller.pastAddress.value.addresses ?? [];
      //var pocketWallet = _controller.pocketWalletRx.value;
      return address.isEmpty
          ? (_controller.pastAddress.value.isDataLoaded ?? false
              ? handleEmptyViewWithLoading(_controller.isLoading)
              : VSpacer1()) //const SizedBox())
          : Column(
            children: List.generate(address.length,
                (index) => _addressItem(index, address[index])),
          );
    });
  }

  Widget _addressItem(int index, Address address) {
    return Container(
      decoration: index == 0
          ? getTransparentGradientBoxWithTopRound()
          : getTransparentGradientBox(),
      // ? boxDecorationTopRound(
      //     color: Get.theme.primaryColor.withOpacity(0.1), isGradient: true)
      // : boxDecoration(
      //     color: Get.theme.primaryColor.withOpacity(0.1), isGradient: true),
      padding: const EdgeInsets.all(dp10),
      //margin: const EdgeInsets.only(left: dp10, right: dp10),
      height: dp100,
      child: InkWell(
        onTap: () {
          //copyToClipboard(stringNullCheck(address.address));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                textBodyBold14(text: 'Address_colon'.tr),
                VSpacer5(),
              ],
            ),
            VSpacer5(),
            InkWell(
              onTap: () {
                copyToClipboard(stringNullCheck(address.address));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  textAutoSize(stringNullCheck(address.address),
                      maxLines: 2,
                      fontSize: dp14,
                      fontWeight: FontWeight.normal,
                      lineHeight: 1.3,
                      width: Get.width - 70)
                ],
              ),
            ),
            VSpacer5(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                textBodyBold14(text: "Created At_colon".tr),
                textBodyNormal14(text: "2021-01-24  12:50:17"),
                //textBodyNormal14(text: formatDate(pocketWallet.createdAt, format: dateTimeFormatYyyyMMDdHhMm)),
              ],
            ),
            //color:  Get.theme.primaryColor.withOpacity(0.5)
          ],
        ),
      ),
    );
  }
}
