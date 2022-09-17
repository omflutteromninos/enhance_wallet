import 'dart:async';
import 'package:cPocket/ui/features/auth/sign_in/sign_in_page.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/image_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/utils/view_utils/decorations.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //SplashController _controller = Get.put(SplashController());

  //
  // @override
  // void dispose() {
  //   hideKeyboard(context);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarIconBrightness: Brightness.light,
    //     systemNavigationBarColor: kCommonBackgroundColor,
    //     systemNavigationBarIconBrightness: Brightness.light,
    //   ),
    // );

    return Scaffold(
      body: GetBuilder<SplashController>(
          // specify type as Controller
          init: SplashController(), // initialize with the Controller
          builder: (splashController) {
            return Container(
                decoration: decorationBackgroundImage,
                child: Center(
                   child: imageView(imagePath: AssetConstants.ic_logo_png,height: dp120,width: dp120),
                ));
          }),
    );

    //   return Scaffold(
    //     body: Container(
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           image: DecorationImage(
    //             image: AssetImage(AssetConstants.splash_bg),
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         child: Center(
    //           child: SvgPicture.asset(
    //             AssetConstants.splash_logo,
    //             fit: BoxFit.contain,
    //           ),
    //         )),
    //   );
    // }
    //
    // @override
    // void didChangeDependencies() {
    //   super.didChangeDependencies();
    //   Timer(Duration(seconds: DefaultValue.splashDuration), () async {
    //     var isLogin = _controller.isLoggedIn();
    //     if (isLogin) {
    //       Get.off(() => BottomBarPage());
    //     } else {
    //       Get.off(() => SignIn());
    //     }
    //   });
  }
}
