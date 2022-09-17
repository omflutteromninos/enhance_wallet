import 'dart:io';

import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (String url) {
              showLoadingDialog(isDismissible: true);
            },
            onPageFinished: (String url) {
              hideLoadingDialog();
            },
            onWebResourceError: (error){
              print("onWebResourceError : "+error.description);
            },
          ),
        ),
      ),
      floatingActionButton: buttonOnlyIcon(() {
        Get.back();
      }, iconPath: AssetConstants.ic_arrow_left, bgColor: Colors.black),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
