import 'dart:io';
import 'package:cPocket/data/models/faq.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_appbar.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/edit_text.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'faq_controller.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  FAQPageController _controller = Get.put(FAQPageController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.getFAQList(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCommonBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBarWithBack(title: "FAQ".tr, hideRightIcon: false),
            _activityList(),
          ],
        ),
      ),
    );
  }

  Widget _activityList() {
    return Obx(() {
      return _controller.faqList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isLoading)
          : Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _controller.faqList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_controller.hasMoreData &&
                      index == (_controller.faqList.length - 1)) {
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                      _controller.getFAQList(true);
                    });
                  }
                  return _faqItem(_controller.faqList[index]);
                },
              ),
            );
    });
  }

  Widget _faqItem(FAQ faq) {
    return Container(
      decoration: faqBoxDecoration(
          color: Get.theme.primaryColorLight.withOpacity(0.05),
          isGradient: false,
          radius: dp10),
      padding: const EdgeInsets.all(dp10),
      margin: const EdgeInsets.all(dp10),
      //height: dp50,
      child: ExpansionTile(
        title: textAutoSize(stringNullCheck(faq.question), maxLines: 2),
        backgroundColor: Colors.transparent,
        collapsedIconColor: Get.theme.primaryColorLight,
        iconColor: Get.theme.primaryColorLight,
        children: <Widget>[
          textAutoSize(stringNullCheck(faq.answer),
              fontSize: dp14, maxLines: 50, fontWeight: FontWeight.w100),
        ],
      ),
    );
  }
}
