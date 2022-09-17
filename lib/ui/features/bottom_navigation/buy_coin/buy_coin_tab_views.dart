import 'dart:io';
import 'package:cPocket/data/models/general_settings.dart';
import 'package:cPocket/ui/features/root/root_controller.dart';
import 'package:cPocket/utils/image_util.dart';
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
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'buy_coin_controller.dart';

class BuyCoinTabViews extends StatefulWidget {
  //final BuyCoinAndPhaseInformation buyCoinAndPhaseInformation;
  final String? fromPage;

  const BuyCoinTabViews({Key? key, this.fromPage}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabControllerView();
}

class _TabControllerView extends State<BuyCoinTabViews> {
  BuyCoinPageController _controller = Get.put(BuyCoinPageController());
  GeneralSettings generalSettings = Get.find<RootController>().generalSettings.value;

  @override
  void initState() {
    super.initState();
    _controller.initViewData();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (widget.fromPage == FromKey.buyCoin) {
        _controller.getBuyCoinAndPhaseInformation();
      } else {
        _controller.getAllBuyCoinHistoryList(false);
      }
    });
  }

  @override
  void didUpdateWidget(covariant BuyCoinTabViews oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (widget.fromPage == FromKey.buyCoin) {
        _controller.getBuyCoinAndPhaseInformation();
      } else {
        _controller.getAllBuyCoinHistoryList(false);
      }
    });
  }

  @override
  void dispose() {
    _controller.clearView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.fromPage == FromKey.buyCoin
        ? Expanded(child: SingleChildScrollView(child: _buyCoin()))
        : _buyCoinHistoryList();
  }

  Widget _buyCoin() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: dp16, vertical: dp0),
      //height: Get.height-232,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            generalSettings.settings?.coinName == null
                ? SizedBox(height: 0)
                : Container(
              padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
              decoration: getRoundSoftTransparentBox(),
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textBodyBold14(text: "Today Coin Rate".tr),
                      VSpacer10(),
                      Container(
                          height: 50,
                          padding: EdgeInsets.all(dp10),
                          decoration: getRoundTransparentBoxWithBorder(),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                      textSubtitleNormal14(
                                          text: "1 ".tr + stringNullCheck(generalSettings.settings!.coinName)),
                                      textSubtitleNormal14(text: "="),
                                      //textSubtitleNormal14(text: stringNullCheck(_controller.buyCoinAndPhaseInformation.value.coinPrice.toString()) + " USD"),
                                      textSubtitleNormal14(
                                          text: generalSettings.settings!.coinPrice.toString() +" USD"),
                                    ]),
                        ),
                    ],
                  ),
                ),
            VSpacer20(),
            Container(
              padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
              decoration: getRoundSoftTransparentBox(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textBodyBold16(text: "Buy Our Coin From Here".tr),
                  VSpacer10(),
                  Obx(() {
                    return _controller.buyCoinAndPhaseInformation.value.activePhase?.status == true
                        ? Column(
                          children: [
                            textAutoSize("New Ico Phase are available now".tr,
                                fontSize: dp14, color: kGreenColor, fontWeight: FontWeight.normal, maxLines: 2),
                            textAutoSize("Now you can get some extra facility when buy coin".tr,
                                fontSize: dp14, color: kAccentColorOrange, fontWeight: FontWeight.normal, maxLines: 2)])
                        : Column(
                          children: [
                            textAutoSize("No phase active yet".tr,
                                fontSize: dp14, color: kRedColor, fontWeight: FontWeight.normal, maxLines: 2),
                            textAutoSize("Now you can buy our regular coin".tr,
                                fontSize: dp14, color: kAccentColorOrange, fontWeight: FontWeight.normal, maxLines: 2)]);
                  }),
                  VSpacer20(),
                  DottedLine(dashColor: kDivider),
                  VSpacer20(),
                  textBodyBold14(text: "Coin Amount".tr),
                  VSpacer10(),
                  textFieldBorderedWithSuffixIcon(
                      _controller.amountEditController,
                      "Your Amount".tr,
                      TextInputType.number, onTextChange: (text) {
                    //_controller.checkSelection();
                    _controller.onTextChanged(_controller.amountEditController.text);
                  }),
                  Obx(() {
                    return _controller.amountEditController.text.isEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VSpacer2(),
                                textAutoSize(
                                    "Buy coin rate text".trParams({
                                      "cPocketAmount": stringNullCheck(_controller.buyCoinAndPhaseInformation.value.coinPrice.toString()),
                                      "buyCoinAmount": "1",
                                      "coinAmount": _controller.buyCoinAndPhaseInformation.value.coinPrice.toString(),
                                      "coinCurrencyType": "USD",
                                    }),
                                    fontSize: dp12,
                                    color: Get.theme.primaryColor.withOpacity(.5),
                                    fontWeight: FontWeight.normal,
                                    maxLines: 2),
                              VSpacer2(),
                                textAutoSize(
                                    "Converted buy coin rate text".trParams({
                                      "buyCoinAmount": stringNullCheck(_controller.buyCoinAndPhaseInformation.value.coinPrice.toString()),
                                      "coinCurrencyType": "USD",
                                      "coinAmount": stringNullCheck(_controller.buyCoinAndPhaseInformation.value.btcDlr.toString()),
                                      "baseCoinType": stringNullCheck(_controller.buyCoinAndPhaseInformation.value.baseCoinType),
                                    }),
                                    fontSize: dp12,
                                    color: Get.theme.primaryColor.withOpacity(.5),
                                    fontWeight: FontWeight.normal,
                                    maxLines: 2),
                              VSpacer2(),
                              textAutoSize(
                                  "Ico Phase Bonus text".trParams({
                                    //"bonusAmount": stringNullCheck(_controller.buyCoinRate.value.bonus.toString()),
                                    "bonusAmount": (_controller.buyCoinRate.value.bonus ?? 0 ).toString() ,
                                    "coinName": stringNullCheck(_controller.buyCoinAndPhaseInformation.value.coinName),
                                  }),
                                  fontSize: dp12,
                                  color: Get.theme.primaryColor.withOpacity(.5),
                                  fontWeight: FontWeight.normal,
                                  maxLines: 2),
                              ])
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VSpacer2(),
                              textAutoSize(
                                  "Buy coin rate text".trParams({
                                    "cPocketAmount": stringNullCheck(_controller.buyCoinAndPhaseInformation.value.coinPrice.toString()),
                                    "buyCoinAmount": _controller.buyCoinRate.value.amount.toString(),
                                    "coinAmount": _controller.buyCoinRate.value.coinPrice.toString(),
                                    "coinCurrencyType": "USD",
                                  }),
                                  fontSize: dp12,
                                  color: Get.theme.primaryColor.withOpacity(.5),
                                  fontWeight: FontWeight.normal,
                                  maxLines: 2),
                              VSpacer2(),
                              textAutoSize(
                                  "Converted buy coin rate text".trParams({
                                    "buyCoinAmount": _controller.buyCoinRate.value.coinPrice.toString(),
                                    "coinCurrencyType": "USD",
                                    "coinAmount": _controller.buyCoinRate.value.btcDlr.toString(),
                                    "baseCoinType": stringNullCheck(_controller.buyCoinRate.value.coinType),
                                  }),
                                  fontSize: dp12,
                                  color: Get.theme.primaryColor.withOpacity(.5),
                                  fontWeight: FontWeight.normal,
                                  maxLines: 2),
                              VSpacer2(),
                              textAutoSize(
                                  "Ico Phase Bonus text".trParams({
                                    "bonusAmount": (_controller.buyCoinRate.value.bonus ?? 0 ).toString(),
                                    "coinName": stringNullCheck(_controller.buyCoinAndPhaseInformation.value.coinName),
                                  }),
                                  fontSize: dp12,
                                  color: Get.theme.primaryColor.withOpacity(.5),
                                  fontWeight: FontWeight.normal,
                                  maxLines: 2),
                            ],
                          );
                  }),
                  VSpacer20(),
                  textBodyBold14(text: "Payment Type".tr),
                  VSpacer10(),
                  Obx(() {
                    var tagListItem = _controller.getPaymentTypeList();
                    return tagListItem.isEmpty
                        ? Container(height: 0)
                        : tagView(
                            tagListItem, [_controller.selectedPaymentType.value],
                            (index) {
                            _controller.selectedPaymentType.value = index;
                          });
                  }),
                  VSpacer10(),
                  Obx(() {
                    return _controller.selectedPaymentType.value == 0
                        ? _coinPaymentView()
                        : (_controller.selectedPaymentType.value == 1
                            ? _bankPaymentView()
                            : _controller.selectedPaymentType.value == 2
                                ? _creditCardPaymentView()
                                : const SizedBox());
                  }),
                  VSpacer20(),
                  DottedLine(dashColor: kDivider),
                  VSpacer30(),
                  buttonRoundedMain(
                      text: "Buy Now".tr,
                      onPressCallback: () {
                        hideKeyboard(context);
                        _controller.buyCoinCheckInputValues(context);
                      }),
                  VSpacer10(),
                ],
              ),
            ),
            VSpacer20(),
            Obx(() {
              return _controller.buyCoinAndPhaseInformation.value.activePhase?.status == true
                  ? Container(
                padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
                decoration: getRoundSoftTransparentBox(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textBodyBold16(text: "New Ico Phase is running".tr),
                    VSpacer10(),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
                      decoration: getRoundThemeTransparentBox(),
                      child: Column(
                        children: [
                          textBodyBold14(text: stringNullCheck(_controller.buyCoinAndPhaseInformation.value.activePhase!.pahseInfo!.phaseName)),
                          horizontalBlackLine(),
                          IcoPhaseRunningRowItem(textLeft: "Phase_Rate_colon".tr,
                              textRight: "1 " +stringNullCheck(_controller.buyCoinAndPhaseInformation.value.coinName) +
                                  " = "+stringNullCheck(_controller.buyCoinAndPhaseInformation.value.activePhase!.pahseInfo!.rate)),
                          horizontalBlackLine(),
                          IcoPhaseRunningRowItem(textLeft: "BonusPercentage_colon".tr,
                              textRight: stringNullCheck(_controller.buyCoinAndPhaseInformation.value.activePhase!.pahseInfo!.bonus)+"%"),
                          horizontalBlackLine(),
                          IcoPhaseRunningRowItem(textLeft: "StartAt_colon".tr,
                              textRight: formatDate(_controller.buyCoinAndPhaseInformation.value.activePhase!.pahseInfo!.startDate, format: dateFormatDdMmYy)),
                          horizontalBlackLine(),
                          IcoPhaseRunningRowItem(textLeft: "EndAt_colon".tr,
                              textRight: formatDate(_controller.buyCoinAndPhaseInformation.value.activePhase!.pahseInfo!.endDate, format: dateFormatDdMmYy)),
                        ],
                      ),
                    ),
                    VSpacer20(),
                    horizontalBlackLine(),
                    VSpacer10(),
                    textBodyBold16(text:
                    "Coin Sales Progress".trParams({
                      "coinName": stringNullCheck(_controller.buyCoinAndPhaseInformation.value.coinName),
                    }),),
                    VSpacer20(),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: dp20, horizontal: dp15),
                      decoration: getRoundThemeTransparentBox(),
                      child: Column(
                        children: [
                          IcoPhaseRunningRowItem(textLeft: "RAISED AMOUNT".tr,
                              textRight: "1 " +stringNullCheck(_controller.buyCoinAndPhaseInformation.value.coinName) +
                                  " = "+stringNullCheck(_controller.buyCoinAndPhaseInformation.value.activePhase!.pahseInfo!.rate)),
                          horizontalBlackLine(),
                          IcoPhaseRunningRowItem(textLeft: "TARGET AMOUNT".tr,
                              textRight: stringNullCheck(_controller.buyCoinAndPhaseInformation.value.activePhase!.pahseInfo!.amount)+" " +stringNullCheck(_controller.buyCoinAndPhaseInformation.value.coinName)),
                        ],
                      ),
                    ),
                    VSpacer20(),
                    Center(
                      child: textSpanSameSizeText( "SALES END IN".tr+"- ",
                            formatDate(_controller.buyCoinAndPhaseInformation.value.activePhase!.pahseInfo!.endDate, format: dateFormatDdMmYy),color: Get.theme.colorScheme.secondary),
                    ),
                  ],
                ),
              )
                  : SizedBox(height: 0);
            }),
            VSpacer20(),
          ],
        ),
      ),
    );
  }

  Widget _coinPaymentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VSpacer0(),
        DottedLine(dashColor: kDivider),
        VSpacer10(),
        textBodyBold14(text: "Payable Coin".tr),
        VSpacer10(),
        textFieldBorderedWithSuffixIcon(
            null,
            // _controller.selectedCoin.value.isNotEmpty
            //     ? (_controller.buyCoinRate.value.btcDlr??"Amount").toString()
            //     : "Amount".tr,
            (_controller.buyCoinRate.value.btcDlr??"Payable coin amount".tr).toString(),
            TextInputType.number,
            isEnable: false),
        VSpacer10(),
        textBodyBold14(text: "Select Coin Type".tr),
        VSpacer10(),
        Obx(() {
          return dropDownList2(_controller.getCoinNameList(),
              _controller.selectedCoin.value, "Select".tr, (value) {
            _controller.selectedCoin.value = value;
            _controller.checkSelection();
          });
        }),
        VSpacer10(),
      ],
    );
  }

  Widget _bankPaymentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VSpacer0(),
        DottedLine(dashColor: kDivider),
        VSpacer10(),
        textBodyBold14(text: "Select Bank".tr),
        VSpacer10(),
        Obx(() {
          return dropDownList2(_controller.getBankNameList(),
              _controller.selectedBank.value, "Select".tr, (value) {
            _controller.selectedBank.value = value;
            _controller.checkSelection();
          });
        }),
        VSpacer10(),
        textBodyBold14(text: "Upload Bank Deposit Slip".tr),
        VSpacer10(),
        uploadImageView(),
        VSpacer10(),
      ],
    );
  }

  Widget _creditCardPaymentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VSpacer0(),
        DottedLine(dashColor: kDivider),
        VSpacer10(),
        textBodyBold14(text: "Name On Card".tr),
        VSpacer10(),
        textFieldBorderedWithSuffixIcon(_controller.nameOnCardEditController,
            "Your name on your card".tr, TextInputType.name,
            isEnable: true),
        VSpacer10(),
        textBodyBold14(text: "Card Number".tr),
        VSpacer10(),
        textFieldBorderedWithSuffixIcon(_controller.cardNumberEditController,
            "Your card number".tr, TextInputType.number,
            isEnable: true),
        VSpacer10(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Get.width / 3.7,
              child: Column(
                children: [
                  textAutoSize("CVC".tr,
                      fontSize: dp12, fontWeight: FontWeight.bold, maxLines: 2),
                  VSpacer10(),
                  textFieldBorderedWithSuffixIcon(
                      _controller.cardCVCEditController,
                      "Ex. 311".tr,
                      TextInputType.number,
                      isEnable: true),
                  VSpacer10(),
                ],
              ),
            ),
            HSpacer5(),
            Container(
              width: Get.width / 3.7,
              child: Column(
                children: [
                  textAutoSize("Expiration Month".tr,
                      fontSize: dp12, fontWeight: FontWeight.bold, maxLines: 2),
                  VSpacer10(),
                  textFieldBorderedWithSuffixIcon(
                      _controller.cardExpireMonthEditController,
                      "MM".tr,
                      TextInputType.text,
                      isEnable: true),
                  VSpacer10(),
                ],
              ),
            ),
            HSpacer5(),
            Container(
              width: Get.width / 3.7,
              child: Column(
                children: [
                  textAutoSize("Expiration Year".tr,
                      fontSize: dp12, fontWeight: FontWeight.bold, maxLines: 2),
                  VSpacer10(),
                  textFieldBorderedWithSuffixIcon(
                      _controller.cardExpireYearEditController,
                      "YYYY".tr,
                      TextInputType.text,
                      isEnable: true),
                  VSpacer10(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget uploadImageView() {
    return Padding(
      padding: const EdgeInsets.all(dp0),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Obx(() {
            return _showUploadImage(_controller.bankSlipImage.value);
          }),
        ],
      ),
    );
  }

  Widget _showUploadImage(File file) {
    return InkWell(
      child: Container(
        decoration: boxDecorationRoundCorner(
            color: Get.theme.primaryColor.withOpacity(0.2)),
        width: Get.width,
        height: dp170,
        //decoration: getRoundTransparentBox(),
        child: file.path.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonOnlyIcon(null, iconPath: AssetConstants.ic_upload),
                  VSpacer10(),
                  textAutoSize("Tap to upload bank slip".tr,
                      textAlign: TextAlign.center, fontSize: dp14)
                ],
              )
            : showImageLocal(file),
      ),
      onTap: () {
        showImageChooser(context, (chooseFile, isGallery) {
          if (isGallery) {
            _controller.bankSlipImage.value = chooseFile;
          } else {
            saveFileOnTempPath(chooseFile);
          }
        });
      },
    );
  }

  void saveFileOnTempPath(File chooseFile) async {
    getImageDirectoryPath(AssetConstants.no_image).then((tempPath) {
      if (_controller.bankSlipImage.value.path
          .contains(AssetConstants.no_image)) {
        _controller.bankSlipImage.value.deleteSync();
      }
      File(tempPath).createSync(recursive: true);
      File newFile = chooseFile.copySync(tempPath);
      chooseFile.deleteSync();
      _controller.bankSlipImage.value = newFile;
    });
  }

  // Widget _buyCoinHistoryList() {
  //   return Obx(() {
  //     String message = "empty_message_buy_coin_history_list".tr;
  //     return _controller.buyCoinHistoryList.isEmpty
  //         ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
  //         : Column(
  //             children: List.generate(
  //                 _controller.buyCoinHistoryList.length,
  //                 (index) => buyCoinHistoryItem(
  //                     _controller.buyCoinHistoryList[index])),
  //           );
  //   });
  // }
  Widget _buyCoinHistoryList() {
    return Obx(() {
      String message = "empty_message_buy_coin_history_list".tr;
      return _controller.buyCoinHistoryList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoading, message: message)
          : Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _controller.buyCoinHistoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_controller.hasMoreData &&
                      index == (_controller.buyCoinHistoryList.length - 1)) {
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                      _controller.getAllBuyCoinHistoryList(true);
                    });
                  }
                  return buyCoinHistoryItem(
                      _controller.buyCoinHistoryList[index]);
                },
              ),
            );
    });
  }

  List paymentOptions = [
    "Coin Payment".tr,
    "Bank Deposit".tr,
    "Credit Card".tr
  ];

  String? select;

  Row addRadioButton(int? btnValue, String? title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          splashRadius: dp10,
          activeColor: kAccentColorOrange,
          value: paymentOptions[btnValue!],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title!)
      ],
    );
  }
}
