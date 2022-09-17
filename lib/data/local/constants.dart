import 'dart:ui';

import 'package:cPocket/data/models/user.dart';

enum PhotoUploadType { profile, front, back }
enum IdVerificationType { none, nid, passport, driving }

class AssetConstants {
  static const pathTempImageFolder = "/tmpImages/";
  static const pathTempFrontImageName = "_frontImage_id_verify.jpeg";
  static const pathTempBackImageName = "_backImage_id_verify.jpeg";
  static const pathTempProfileImageName = "_profileImage_id_verify.jpeg";

  static const pathHtmlTrading = "assets/trading_slider.html";
  static const pathHtmlTradingIos = "assets/trading_slider_ios.html";

  static const base_path_images = "assets/images/";
  static const splash_bg = base_path_images + "splash_bg.png";
  static const ic_dashboard = base_path_images + "dashboard.svg";
  static const ic_buy_coin = base_path_images + "buy_coin.svg";
  static const ic_wallet = base_path_images + "Wallet.svg";
  static const ic_referral = base_path_images + "referral.svg";
  static const ic_premium = base_path_images + "premium.svg";
  static const ic_category = base_path_images + "Category.svg";
  static const item_background = base_path_images + "item_background.svg";
  static const ic_background = base_path_images + "Background.png";
  static const chart1 = base_path_images + "chart1.png";
  static const chart2 = base_path_images + "chart2.png";
  static const ic_gold_badge1 = base_path_images + "ic_gold_badge1.png";
  static const img_not_available = base_path_images + "img_not_available.png";
  static const no_image = base_path_images + "no_image.png";
  static const qr_code = base_path_images + "qr_code.svg";
  static const ic_google_authenticator =
      base_path_images + "ic_google_authenticator.png";
  static const avatar = base_path_images + "avatar.png";
  static const bg_coin_overview = base_path_images + "bg_coin_overview.svg";
  static const ic_google_authenticator_logo_png = base_path_images + "ic_google_authenticator_logo_png.png";

  static const base_path_icons = "assets/icons/";
  static const ic_icon = base_path_icons + "icon.svg";
  static const ic_menu = base_path_icons + "ic_menu.svg";
  static const ic_pass = base_path_icons + "ic_pass.png";
  static const ic_notification = base_path_icons + "ic_notification.svg";
  static const ic_notification1 = base_path_icons + "ic_notification1.svg";
  static const ic_notification2 = base_path_icons + "ic_notification2.svg";
  static const ic_notification3 = base_path_icons + "ic_notification3.svg";
  static const ic_notification4 = base_path_icons + "ic_notification5.svg";
  static const ic_notification5 = base_path_icons + "ic_notification5.svg";
  static const ic_arrow_left = base_path_icons + "ic_arrow_left.svg";
  static const ic_arrow_right = base_path_icons + "ic_arrow_right.svg";
  static const ic_arrow_down = base_path_icons + "ic_arrow_down.svg";
  static const ic_chart = base_path_icons + "ic_chart.svg";
  static const ic_close_box = base_path_icons + "ic_close_box.svg";
  static const ic_faq_circle = base_path_icons + "ic_faq_circle.svg";
  static const ic_filter = base_path_icons + "ic_filter.svg";
  static const ic_home_color = base_path_icons + "ic_home_color.svg";
  static const ic_home = base_path_icons + "ic_home.svg";
  static const ic_logout = base_path_icons + "ic_logout.svg";
  static const ic_password = base_path_icons + "ic_password.svg";
  static const ic_profile = base_path_icons + "ic_profile.svg";
  static const ic_setting = base_path_icons + "ic_setting.svg";
  static const ic_facebook_btn = base_path_icons + "ic_facebook_btn.svg";
  static const ic_twitter_btn = base_path_icons + "ic_twitter_btn.svg";
  static const ic_gold_badge = base_path_icons + "ic_gold_badge.svg";
  static const ic_action_key = base_path_icons + "ic_action_key.svg";
  static const ic_action_withdraw = base_path_icons + "ic_action_withdraw.svg";
  static const ic_action_wallet_activity_log = base_path_icons + "ic_action_wallet_activity_log.svg";
  static const ic_action_show = base_path_icons + "ic_action_show.svg";
  static const ic_action_wallet_deposit = base_path_icons + "ic_action_wallet_deposit.svg";
  static const ic_action_swap = base_path_icons + "ic_action_swap.svg";
  static const ic_action_send_receive_coin = base_path_icons + "ic_action_send_receive_coin.svg";
  static const ic_action_coin2 = base_path_icons + "ic_action_coin2.svg";
  static const ic_big_profile = base_path_icons + "ic_big_profile.svg";
  static const ic_call = base_path_icons + "ic_call.svg";
  static const ic_document = base_path_icons + "ic_document.svg";
  static const ic_edit = base_path_icons + "ic_edit.svg";
  static const ic_driving_license = base_path_icons + "ic_driving_license.svg";
  static const ic_nid = base_path_icons + "ic_nid.svg";
  static const ic_passport = base_path_icons + "ic_passport.svg";
  static const ic_check_large = base_path_icons + "ic_check_large.svg";
  static const ic_camera_bg_round = base_path_icons + "ic_camera_bg_round.svg";
  static const ic_camera = base_path_icons + "ic_camera.svg";
  static const ic_logo_png = base_path_icons + "imagel.png";
  static const ic_logo_png1 = base_path_icons + "imagel.png";
  static const ic_upload = base_path_icons + "ic_upload.svg";
  static const ic_logo = base_path_icons + "imagel.svg";
  static const ic_password_hide = base_path_icons + "ic_password_hide.svg";
  static const ic_password_show = base_path_icons + "ic_password_show.svg";
  static const ic_google_authenticator_logo = base_path_icons + "ic_google_authenticator_logo.svg";
  static const ic_facebook = base_path_icons + "ic_facebook.svg";
  static const ic_twitter = base_path_icons + "ic_twitter.svg";
  static const ic_money = base_path_icons + "ic_money.svg";
  static const ic_blocked_coin = base_path_icons + "ic_blocked_coin.svg";
  static const icBoxSquare = base_path_icons + "ic_box_square.svg";
  static const icTickRound = base_path_icons + "ic_tick_round.svg";
  static const icTickSquare = base_path_icons + "ic_tick_square.svg";
}
class RateType {
  static const same = "same";
  static const reverse = "reverse";
}

class IdVerificationStatus {
  static const notSubmitted = "Not submitted";
  static const pending = "Pending";
  static const accepted = "Approved";
  static const rejected = "Rejected";
}

class UserStatus {
  static const pending = 0;
  static const accepted = 1;
  static const rejected = 2;
  static const suspended = 4;
  static const deleted = 5;
}
class UserStatusString {
  static const pending = "Pending";
  static const accepted = "Accepted";
  static const rejected = "Rejected";
  static const suspended = "Suspended";
  static const deleted = "Deleted";
}

class PreferenceKey {
  static const isLoggedIn = "is_logged_in";
  static const accessToken = "access_token";
  static const userObject = "user_object";
  static const userClubInfoObject = "user_club_info_object";
  static const settingsObject = "settings_object";
  static const generalSettings = "settings_general";

  static const darkMode = "dark_mode";
  static const languageKey = "language_key";
}

class DefaultValue {
  static const int kPasswordLength = 6;
  static const int kCodeLength = 6;
  static const int userType = 1; //driver = 1, user = 2
  static const int kSplashDuration = 3;
  static const int kResponseDuration = 2;
  static const int listLimitLarge = 20;
  static const int listLimitMedium = 10;
  static const int listLimitShort = 5;

  static const String languageKey = "en";
  static const String country = "United Kingdom";
  static const String addCard = "addCard";

  static const bool kDefaultBoolean = false;
  static const int kDefaultInt = 0;
  static const double kDefaultDouble = 0.0;
  static const String kDefaultString = '';
  static const String kLongString =
      "Expandable widgets are often used within a scroll view. When the user expands a widget, be it an ExpandablePanel or an Expandable with a custom control, they expect the expanded widget to fit within the viewable area (if possible). For example, if you show a list of articles with a summary of each article, and the user expands an article to read it, they expect the expanded article to occupy as much screen space as possible. The Expandable package contains a widget to help implement this behavior, ScrollOnExpand. Here's how to use it:";

  static const String imagePathChecker = "/kyc/default.jpeg";
  static const String randomImage = "https://picsum.photos/200";
  static const String longString =
      "Expandable widgets are often used within a scroll view. "
      "When the user expands a widget, be it an ExpandablePanel or an Expandable with a custom control,"
      " they expect the expanded widget to fit within the viewable area (if possible). "
      "For example, if you show a list of articles with a summary of each article, "
      "and the user expands an article to read it, they expect the expanded article to "
      "occupy as much screen space as possible. The Expandable package contains a widget to "
      "help implement this behavior, ScrollOnExpand. Here's how to use it.";
}

class FromKey {
  static const depositList = "depositList";
  static const withdrawList = "withdrawList";
  static const deposit = "deposit";
  static const withdraw = "withdraw";
  static const seeAll = "seeAll";

  static const references = "references";
  static const earnings = "earnings";

  static const buyCoin = "buyCoin";
  static const buyCoinHistory = "buyCoinHistory";

  static const swapCoin = "swapCoin";
  static const swapCoinHistory = "swapCoinHistory";

  static const coinRequest = "coinRequest";
  static const sendCoin = "sendCoin";

  static const transferCoin = "transferCoin";
  static const myMembership = "myMembership";
}

class KeyConstants {
  static const TOKEN_KEY = "token";
  static const EMAIL_VERIFIED_KEY = "email_verified";
  static const DEVICE_VERIFIED_KEY = "device_verified";
  static const DEVICE_COOKIE = "device_cookie";
  static const CURRENCY_KEY = "currency";
  static const LANGUAGE_KEY = "language";
  static const MESSAGE_KEY = "message";
}

class DemoConstants {
  static const randomImage =
      "https://images.unsplash.com/photo-1619441174172-26e021833857?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80";
}

class APIConstants {
  //static const baseUrl = "https://cpocket-test.cdibrandstudio.com/api";
  static const baseUrl = "https://cpocket.itech-theme.com/api";
  // static const baseUrl = "http://192.168.68.138:8001/api";
//"https://cpocket.itech-theme.com/api";
  //https://shubhkarman.com/enhancewallet/api
  // #  End Urls

  // Auth
  static const urlLogin = "/login";
  static const urlSignUp = "/sign-up";
  static const urlEmailVerify = "/email-verify";
  static const urlForgotPassword = "/forgot-password";
  static const urlResetPassword = "/reset-password";

  // Profile
  static const urlMyProfileView = "/profile-view";
  static const urlMyProfileEdit = "/profile-edit";
  static const urlUpdateProfile = "/save-edited-profile";
  static const urlPhoneVerification = "/phone-verification";
  static const urlSendPhoneVerificationCode = "/send-phone-verification-code";
  static const urlIdVerification = "/id-verification";
  static const urlChangePassword = "/change-password";
  static const urlSubmitNidPhoto = "/submit-nid-photo";
  static const urlSubmitPassportPhoto = "/submit-passport-photo";
  static const urlSubmitDrivingLicensePhoto = "/submit-driving-license-photo";

  static const urlNotificationList = "/notification-list";
  static const urlFAQList = "/faq-list";

  static const urlGeneralSettings = "/general-settings";
  static const urlSettingsData = "/goto-setting-page";
  static const urlSaveLanguage = "/save-language";
  static const urlGoogleSecretSave = "/google-secret-save";
  static const url2FALoginEnableDisable = "/google-login-enable-or-disable";
  static const urlGoogle2FACode = "/g2f-verify-app";

  static const urlActivityList = "/activity-list";

  static const urlLogout = "/log-out-app";

  static const urlResendVerificationCode = "/resend-verification-code";

  static const urlMyPocketWalletList = "/my-pocket-list";
  static const urlPocketWalletCoinList = "/pocket-coin-list";
  static const urlCreateWallet = "/create-wallet";

  static const urlGoToAddress = "/goto-address-app";
  static const urlGenerateNewAddress = "/generate-new-address-app";
  static const urlShowPassAddress = "/show-pass-address";

  //static const urlWalletDetails = "/wallet-details-app";
  static const urlWalletDetails = "/wallet-details-by-id";
  static const urlWithdrawProcess = "/withdrawal-process";

  static const urlDepositList = "/deposite-list";
  static const urlWithdrawList = "/withdraw-list";


  static const urlGenerateReferralLink = "/generate-referral-link";
  static const urlReferenceAndReferral = "/my-reference-referral";
  static const urlReferenceList = "/my-reference-list";
  static const urlEarning = "/my-earnings";

  static const urlDepositOrWithdrawList = "/deposite-or-withdraw-list";
  static const urlDashBoard = "/user-dashboard-app";


  static const urlDefaultCoinRequest = "/default-coin-request-app";
  static const urlSendCoinRequest = "/give-coin-app";
  static const urlDefaultRequestCoinApp = "/request-coin-app";
  static const urlApprovalActionForCoinRequest = "/approval-action-for-coin-request";
  static const urlSendCoinHistoryList = "/send-coin-history";
  static const urlReceiveCoinHistoryList = "/receive-coin-history";
  static const urlPendingCoinHistoryList = "/pending-coin-request";

  static const urlBuyCoinAndPhaseInformation = "/get-buy-coin-and-phase-information";
  static const urlBuyCoinHistoryList = "/buy-coin-history-app";

  static const urlMembershipBonusHistoryList = "/membership-bonus-history";
  static const urlMembershipDetails = "/membership-details";
  static const urlAllMembershipPlanList = "/membership-plan-list";
  static const urlTransferCoinToClubWallet = "/transfer-coin-to-club-wallet";
  static const urlTransferCoinToMainWallet = "/transfer-coin-to-main-wallet";

  static const urlSwapCoinAllWallet = "/coin-swap-app";
  static const urlSwapCoin = "/swap-coin-app";
  static const urlSwapCoinHistoryList = "/show-swap-coin-history";

  static const urlGetCoinRate = "/get-coin-rate";

  static const urlBuyCoinRate = "/buy-coin-rate-app";
  static const urlBuyCoinThroughApp = "/buy-coin-through-app";

  // #  response parameter key

  static const kId = "id";

  static const kFirstName = "first_name";
  static const kLastName = "last_name";
  static const kUserName = "user_name";
  static const kEmail = "email";
  static const kCurrentPassword = "current_password";
  static const kPassword = "password";
  static const kConfirmPassword = "password_confirmation";
  static const kCountry = "country";
  static const kGender = "gender";

  static const kUrl = "url";

  static const kUserInfo = "user_info";
  static const kUser = "user";
  static const kUserClubInfo = "clubInfos";

  //nid verification
  static const kFrontImage = "front_image";
  static const kBackImage = "back_image";
  static const kNidFrontImage = "nid_front";
  static const kNidBackImage = "nid_back";
  static const kPassportFrontImage = "pass_front";
  static const kPassportBackImage = "pass_back";
  static const kDriverLicenseFrontImage = "drive_front";
  static const kDriverLicenseBackImage = "drive_back";
  static const kVerificationCode = "verification_code";
  static const kPhone = "phone";
  static const kEmailOrPhone = "email_or_phone";
  static const kCity = "city";
  static const kPhoto = "photo";
  static const kCode = "code";
  static const kAccessCode = "access_code";
  static const kDetails = "details";

  static const kAccept = "Accept";
  static const kAuthorization = "Authorization";
  static const kAccessToken = "access_token";

  static const vAccept = "application/json";
  static const vBearer = "Bearer";

  static const kProfilePhotoPath = "";

  static const kPage = "page";
  static const kLimit = "limit";

  //static const kNotificationId = "notification_id";

  //settings
  static const kLanguage = "lang";

  //static const kLanguage = "languages";
  static const kRemove = "remove";
  static const kGoogle2factSecret = "google2fa_secret";
  static const kG2faVerify = "g2f_verify";

  //My pocket, Deposit
  static const kWalletName = "wallet_name";
  static const kCoinType = "coin_type";
  static const kType = "type";

  //static const kCoinId = "coin_id";
  static const kWalletId = "wallet_id";
  static const kReceiverWalletId = "receiver_wallet_id";
  static const kAddress = "address";

  static const kWalletDetails = "wallet_details";

  static const kAmount = "amount";
  static const kMessage = "message";

  static const kWithdraws = "withdraws";
  static const kDeposits = "deposites";

  static const kFromCoinId = "from_coin_id";
  static const kToCoinId = "to_coin_id";

  static const kPaymentType = "payment_type";
  static const kPaymentCoinType = "payment_coin_type";
  static const kBankId = "bank_id";
  static const kBankDepositId = "bank_deposit_id";
  static const kPayType = "pay_type";
  static const kCoin = "coin";
  static const kPhaseId = "phase_id";
  static const kBankSlipImage = "sleep";
  static const kStripeToken = "stripeToken";


  static const kRequestId = "request_id";
  static const kActionFlag = "action_flag";
}

class ErrorConstants {
  static const unauthorized = "Unauthorized";
}

// Regular Expression
const String kRegExpEmail =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const String kRegExpPhone = "(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?" +
    "([0-9][0-9\\- \\.]+[0-9])";

const String patternMail =
    r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";

// Constant Keys

const String kKeyIsLoggedIn = 'is_logged_in';
const String kKeyAccessToken = 'access_token';
const String kUserId = 'user_id';

class URLConstants {
  static const fbReferral = "https://www.facebook.com/sharer/sharer.php?u=";
  static const twitterReferral = "https://www.twitter.com/share?url=";
}
class ListConstants {
  //static const List<String> genderType = ["M", "F"];
  static const List<String> genderValue = ["Male", "Female", "Other"];
  static const List<String> registrationType = ["email", "phone"];
  static const List<String> paymentType = ['Bank', 'Card', 'Coin'];
  static const List<String> transactionType = ["Buy", "Sell"];
  static const List<String> coinType = [
    "BTC",
    "LTCT",
    "ETH",
    "LTC",
    "DOGE",
    "BCH",
    "DASH",
    "ETC",
    "USDT"
  ];
  static const List<String> rateType = ['Dynamic Rate', 'Static Rate'];
  static const List<String> dynamicRateType = ['Above', 'Below'];
  static const List<String> countryList = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "American Samoa",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antarctica",
    "Antigua and/or Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Bouvet Island",
    "Brazil",
    "British Indian Ocean Territory",
    "Brunei Darussalam",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Cayman Islands",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Christmas Island",
    "Cocos (Keeling) Islands",
    "Colombia",
    "Comoros",
    "Congo",
    "Cook Islands",
    "Costa Rica",
    "Croatia (Hrvatska)",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "East Timor",
    "Ecudaor",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Ethiopia",
    "Falkland Islands (Malvinas)",
    "Faroe Islands",
    "Fiji",
    "Finland",
    "France",
    "France, Metropolitan",
    "French Guiana",
    "French Polynesia",
    "French Southern Territories",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Gibraltar",
    "Greece",
    "Greenland",
    "Grenada",
    "Guadeloupe",
    "Guam",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Heard and Mc Donald Islands",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran (Islamic Republic of)",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Ivory Coast",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea, Democratic People's Republic of",
    "Korea, Republic of",
    "Kosovo",
    "Kuwait",
    "Kyrgyzstan",
    "Lao People's Democratic Republic",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libyan Arab Jamahiriya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macau",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Martinique",
    "Mauritania",
    "Mauritius",
    "Mayotte",
    "Mexico",
    "Micronesia, Federated States of",
    "Moldova, Republic of",
    "Monaco",
    "Mongolia",
    "Montserrat",
    "Morocco",
    "Mozambique",
    "Myanmar",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "Netherlands Antilles",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Niue",
    "Norfork Island",
    "Northern Mariana Islands",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Pitcairn",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Qatar",
    "Reunion",
    "Romania",
    "Russian Federation",
    "Rwanda",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Vincent and the Grenadines",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "South Georgia South Sandwich Islands",
    "South Sudan",
    "Spain",
    "Sri Lanka",
    "St. Helena",
    "St. Pierre and Miquelon",
    "Sudan",
    "Suriname",
    "Svalbarn and Jan Mayen Islands",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syrian Arab Republic",
    "Taiwan",
    "Tajikistan",
    "Tanzania, United Republic of",
    "Thailand",
    "Togo",
    "Tokelau",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Turks and Caicos Islands",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "United States minor outlying islands",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Vatican City State",
    "Venezuela",
    "Vietnam",
    "Virigan Islands (British)",
    "Virgin Islands (U.S.)",
    "Wallis and Futuna Islands",
    "Western Sahara",
    "Yemen",
    "Yugoslavia",
    "Zaire",
    "Zambia",
    "Zimbabwe"
  ];
}

const htmlTextDemo = """
<h1>Header 1</h1>
<h3>Ruby Support:</h3>
      <p>
        <ruby>
          漢<rt>かん</rt>
          字<rt>じ</rt>
        </ruby>
        &nbsp;is Japanese Kanji.
      </p>
      <h3>Support for <code>sub</code>/<code>sup</code></h3>
      Solve for <var>x<sub>n</sub></var>: log<sub>2</sub>(<var>x</var><sup>2</sup>+<var>n</var>) = 9<sup>3</sup>
      <p>One of the most <span>common</span> equations in all of physics is <br /><var>E</var>=<var>m</var><var>c</var><sup>2</sup>.</p>
      <h3>Inline Styles:</h3>
      <p>The should be <span style='color: blue;'>BLUE style='color: blue;'</span></p>
      <p>The should be <span style='color: red;'>RED style='color: red;'</span></p>
      <p>The should be <span style='color: rgba(0, 0, 0, 0.10);'>BLACK with 10% alpha style='color: rgba(0, 0, 0, 0.10);</span></p>
      <p>The should be <span style='color: rgb(0, 97, 0);'>GREEN style='color: rgb(0, 97, 0);</span></p>
      <p>The should be <span style='background-color: red; color: rgb(0, 97, 0);'>GREEN style='color: rgb(0, 97, 0);</span></p>
      <p style="text-align: center;"><span style="color: rgba(0, 0, 0, 0.95);">blasdafjklasdlkjfkl</span></p>
      <p style="text-align: right;"><span style="color: rgba(0, 0, 0, 0.95);">blasdafjklasdlkjfkl</span></p>
      <p style="text-align: justify;"><span style="color: rgba(0, 0, 0, 0.95);">blasdafjklasdlkjfkl</span></p>
      <p style="text-align: center;"><span style="color: rgba(0, 0, 0, 0.95);">blasdafjklasdlkjfkl</span></p>
      <h3>Table support (with custom styling!):</h3>
      <p>
      <q>Famous quote...</q>
      </p>
      <table>
      <colgroup>
        <col width="50%" />
        <col span="2" width="25%" />
      </colgroup>
      <thead>
      <tr><th>One</th><th>Two</th><th>Three</th></tr>
      </thead>
      <tbody>
      <tr>
        <td rowspan='2'>Rowspan\nRowspan\nRowspan\nRowspan\nRowspan\nRowspan\nRowspan\nRowspan\nRowspan\nRowspan</td><td>Data</td><td>Data</td>
      </tr>
      <tr>
        <td colspan="2"><img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /></td>
      </tr>
      </tbody>
      <tfoot>
      <tr><td>fData</td><td>fData</td><td>fData</td></tr>
      </tfoot>
      </table>
      <h3>Custom Element Support (inline: <bird></bird> and as block):</h3>
      <flutter></flutter>
      <flutter horizontal></flutter>
      <h3>SVG support:</h3>
      <svg id='svg1' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'>
            <circle r="32" cx="35" cy="65" fill="#F00" opacity="0.5"/>
            <circle r="32" cx="65" cy="65" fill="#0F0" opacity="0.5"/>
            <circle r="32" cx="50" cy="35" fill="#00F" opacity="0.5"/>
      </svg>
      <h3>List support:</h3>
      <ol>
            <li>This</li>
            <li><p>is</p></li>
            <li>an</li>
            <li>
            ordered
            <ul>
            <li>With<br /><br />...</li>
            <li>a</li>
            <li>nested</li>
            <li>unordered
            <ol>
            <li>With a nested</li>
            <li>ordered list.</li>
            </ol>
            </li>
            <li>list</li>
            </ul>
            </li>
            <li>list! Lorem ipsum dolor sit amet.</li>
            <li><h2>Header 2</h2></li>
            <h2><li>Header 2</li></h2>
      </ol>
      <h3>Link support:</h3>
      <p>
        Linking to <a href='https://github.com'>websites</a> has never been easier.
      </p>
      <h3>Image support:</h3>
      <h3>Network png</h3>
      <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' />
      <h3>Network svg</h3>
      <img src='https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg' />
      <h3>Local asset png</h3>
      <img src='asset:assets/html5.png' width='100' />
      <h3>Local asset svg</h3>
      <img src='asset:assets/mac.svg' width='100' />
      <h3>Base64</h3>
      <img alt='Red dot' src='data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==' />
      <h3>Custom source matcher (relative paths)</h3>
      <img src='/wikipedia/commons/thumb/e/ef/Octicons-logo-github.svg/200px-Octicons-logo-github.svg.png' />
      <h3>Custom image render (flutter.dev)</h3>
      <img src='https://flutter.dev/images/flutter-mono-81x100.png' />
      <h3>No image source</h3>
      <img alt='No source' />
      <img alt='Empty source' src='' />
      <h3>Broken network image</h3>
      <img alt='Broken image' src='https://www.notgoogle.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' />
""";
