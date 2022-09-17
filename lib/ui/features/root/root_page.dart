import 'package:cPocket/data/models/user.dart';
import 'package:cPocket/ui/features/bottom_navigation/buy_coin/buy_coin_page.dart';
import 'package:cPocket/ui/features/bottom_navigation/membership_club/membership_club_page.dart';
import 'package:cPocket/ui/features/bottom_navigation/my_pocket/my_pocket_page.dart';
import 'package:cPocket/ui/features/side_navigation/activity/activity_page.dart';
import 'package:cPocket/ui/features/side_navigation/change_password/change_password_page.dart';
import 'package:cPocket/ui/features/side_navigation/faq/faq_page.dart';
import 'package:cPocket/ui/features/side_navigation/my_profile/my_profile_page.dart';
import 'package:cPocket/ui/features/side_navigation/send_or_receive/pending_request/pending_request_page.dart';
import 'package:cPocket/ui/features/side_navigation/send_or_receive/receive_history/receive_history_page.dart';
import 'package:cPocket/ui/features/side_navigation/send_or_receive/send_history/send_history_page.dart';
import 'package:cPocket/ui/features/side_navigation/send_or_receive/send_or_request_coin/send_or_request_coin_page.dart';
import 'package:cPocket/ui/features/side_navigation/settings/settings_page.dart';
import 'package:cPocket/ui/features/side_navigation/swap_coin/swap_coin_page.dart';
import 'package:cPocket/utils/image_util.dart';
import 'package:cPocket/utils/view_utils/colors.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';
import 'package:cPocket/utils/view_utils/common_widget.dart';
import 'package:cPocket/data/local/constants.dart';
import 'package:cPocket/utils/view_utils/custom_buttons.dart';
import 'package:cPocket/utils/view_utils/text_utils.dart';
import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../bottom_navigation/dashboard/dashboard_page.dart';
import '../bottom_navigation/my_refarral/my_refarral_page.dart';
import 'root_controller.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  RootController _controller = Get.put(RootController());

  @override
  void initState() {
    super.initState();
    _controller.setMyProfile();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      //
    });
  }

  @override
  void dispose() {
    hideKeyboard(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColorDark,
      body: SafeArea(
        child: _getBody(),
      ),
      bottomNavigationBar: getBottomNavigationBar(),
      drawer: _getDrawer(context),
    );
  }

  /// Returns color of the selected item
  Color? _getItemColor(int index) {
    return _controller.selectedIndex.value == index ? kAccentColorOrange : null;
  }

  void _onItemTapped(int index) {
    setState(() {
      _controller.selectedIndex.value = index;
    });
  }

  Widget _getBody() {
    switch (_controller.selectedIndex.value) {
      case 0:
        return DashBoardPage();
      case 1:
        return BuyCoinPage();
      case 2:
        return MyPocketPage();
      case 3:
        return MyReferralPage();
      case 4:
        return MembershipClubPage();
      default:
        return Container();
    }
  }

  void navigate(MaterialPageRoute route) {
    Navigator.of(context).push(route);
  }

  _getDrawer(context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: kCommonBackgroundColor.withOpacity(0.95),
      ),
      child: Container(
        alignment: Alignment.topLeft,
        //color: kCommonBackgroundColor,
        width: Get.width / 1.2,
        child: Drawer(
          elevation: 0,
          child: ListView(
            children: [
              ListTile(
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(AssetConstants.ic_close_box),
                ),
              ),
              Obx(() {
                return _profileView(_controller.userRx.value);
              }),
              _loggedInMenuView(),
              /*Obx(() {
                return _controller.isLogin.value
                    ? _profileView()
                    : _signUpView();
              }),
              Obx(() {
                return _controller.isLogin.value
                    ? _loggedInMenuView()
                    : _singUpMenuView();
              }),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpView() {
    return Container(
      height: Get.width * 0.75,
      child: Column(
        children: [
          textNormalCenter22(
              text: "Sign in to save items, place bids and message"),
          buttonRoundedMain(
              text: "Sign In".tr, onPressCallback: () {}, width: Get.width / 3)
        ],
      ),
    );
  }

  Widget _profileView(User user) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(dp0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showCircleAvatar(stringNullCheck(user.photo), size: dp100),
          VSpacer15(),
          textAutoSize(getUserName(user),
              textAlign: TextAlign.center, fontSize: dp18),
          VSpacer5(),
          textAutoSizeSubtitle(stringNullCheck(user.email),
              textAlign: TextAlign.center, fontSize: dp14),
        ],
      ),
    );
  }

  Widget _loggedInMenuView() {
    return Container(
      padding: EdgeInsets.only(
        left: dp24,
      ),
      child: Column(
        children: [
          VSpacer30(),
          // listTitleWithLeftIcon(
          //     "Home".tr, AssetConstants.ic_home, kThemeTextColor, () {
          //   Get.back();
          // }),
          listTitleWithLeftIconExpansionTile(
            title: "SendReceive".tr,
            iconPath: AssetConstants.ic_chart,
            menu1: "SendRequest Coin".tr,
            menu2: "Send History".tr,
            menu3: "Receive History".tr,
            menu4: "Pending Request".tr,
            actionMenu1: () {
              Get.to(() => SendOrRequestCoinPage());
            },
            actionMenu2: () {
              Get.to(() => SendHistoryPage());
            },
            actionMenu3: () {
              Get.to(() => ReceiveHistoryPage());
            },
            actionMenu4: () {
              Get.to(() => PendingRequestPage());
            },
          ),
          listTitleWithLeftIcon(
              "Swap Coin".tr, AssetConstants.ic_action_swap, kThemeTextColor,
                  () {
                Get.to(() => SwapCoinPage());
              }, iconColor: kThemeTextColor),
          listTitleWithLeftIcon(
              "My Profile".tr, AssetConstants.ic_profile, kThemeTextColor, () {
            Get.to(() => MyProfilePage());
          }),
          listTitleWithLeftIcon(
              "Change password".tr, AssetConstants.ic_password, kThemeTextColor,
                  () {
                Get.to(() => ChangePasswordPage());
              }),
          listTitleWithLeftIcon(
              "Activity".tr, AssetConstants.ic_filter, kThemeTextColor, () {
            Get.to(() => ActivityPage());
          }),
          listTitleWithLeftIcon(
              "Settings".tr, AssetConstants.ic_setting, kThemeTextColor, () {
            Get.to(() => SettingsPage(user: _controller.userRx.value));
          }),
          listTitleWithLeftIcon(
              "FAQ".tr, AssetConstants.ic_faq_circle, kThemeTextColor, () {
            Get.to(() => FAQPage());
          }),
          listTitleWithLeftIcon(
              "Log Out".tr, AssetConstants.ic_logout, kThemeTextColor, () {
            //_logoutConfirmationDialog();
            alertForLogOut(() {
              Get.back();
              _controller.logOut();
            });
          }),
        ],
      ),
    );
  }

  void alertForLogOut(VoidCallback okAction) {
    Get.defaultDialog(
      title: "",
      radius: dp10,
      backgroundColor: Get.theme.primaryColorDark,
      content: SizedBox(
        height: dp150,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            textAutoSize("Log out".tr, textAlign: TextAlign.center),
            const SizedBox(height: dp10),
            textAutoSize("Are you really want to log out?".tr,
                maxLines: 2, textAlign: TextAlign.center, fontSize: dp12),
            const SizedBox(height: dp10),
            buttonRoundedFill("Yes".tr, okAction, width: Get.width / 2)
          ],
        ),
      ),
    );
  }

  Widget _singUpMenuView() {
    return Container(
      padding: EdgeInsets.only(top: dp5, bottom: dp5),
      child: Column(
        children: [
          listTitleWithLeftIcon(
              "Home".tr, AssetConstants.ic_home_color, kThemeTextColor, () {
            Get.back();
          }),
          listTitleWithArrow("Settings".tr, AssetConstants.ic_arrow_right, () {
            Get.to(() => SettingsPage(user: _controller.userRx.value));
          }),
          listTitleWithArrow("FAQ".tr, AssetConstants.ic_arrow_right, () {
            openUrlInBrowser("https://en.wikipedia.org/wiki");
          }),
        ],
      ),
    );
  }

  Widget getBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 0.0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: kLightTextFieldColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetConstants.ic_dashboard,
              color: _getItemColor(0)),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetConstants.ic_buy_coin,
              color: _getItemColor(1)),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetConstants.ic_wallet,
              color: _getItemColor(2)),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetConstants.ic_referral,
              color: _getItemColor(3)),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetConstants.ic_premium,
              color: _getItemColor(4)),
          label: '',
        ),
      ],
      currentIndex: _controller.selectedIndex.value,
      onTap: _onItemTapped,
    );
  }

//Todo: for Exit
  Future _showExitDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.only(top: 00.0),
            content: Container(
              margin: const EdgeInsets.all(00),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 0.0, top: 15.0, right: 0.0, bottom: 0.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Confirm Exit'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Are you sure you want to Exit'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          color: Colors.grey[600],
                          width: double.infinity,
                          height: 0.3,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  print('Cancel'.tr);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel'.tr,
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              width: 0.3,
                              height: 40,
                              color: Colors.grey[600],
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () async {
                                  print('Exit'.tr);
                                  Navigator.pop(context);
                                  SystemNavigator.pop();
                                },
                                child: Text(
                                  'Exit'.tr,
                                  style: TextStyle(color: Colors.red[600]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

// _logoutConfirmationDialog() async {
//   return showDialog(
//       context: Get.context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(
//             'Log Out'.tr,
//             style: TextStyle(
//               color: black_5,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           content: Text('Do you want to log out'.tr,
//               style: TextStyle(
//                 color: black_5,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w700,
//               )),
//           actions: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 // Navigator.of(context).pop();
//                 // final storage = GetStorage();
//                 // storage.remove(kKeyIsLoggedIn);
//                 // storage.remove(kKeyAccessToken);
//                 // storage.erase();
//                 // Get.offAll(() =>SignIn());
//                 Get.back();
//               },
//               child: Text(
//                 'Cancel'.tr,
//                 style: TextStyle(
//                   color: black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             HSpacer30(),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//                 final storage = GetStorage();
//                 final userId = storage.read(kUserId);
//                 //messaging.unsubscribeFromTopic("users-" + userId);
//                 storage.remove(kKeyIsLoggedIn);
//                 storage.remove(kKeyAccessToken);
//                 storage.erase();
//                 Get.offAll(() => SignInPage());
//               },
//               child: Text(
//                 'Okay'.tr,
//                 style: TextStyle(
//                   color: red,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         );
//       });
// }
}

