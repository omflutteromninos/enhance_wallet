import 'package:cPocket/ui/features/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'data/remote/api_provider.dart';
import 'utils/view_utils/app_theme.dart';
import 'data/local/constants.dart';
import 'data/local/strings.dart';

void main() async {
  await GetStorage.init();
  //await Firebase.initializeApp();

  // Avoid errors caused by flutter upgrade.
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(MyApp()));
  Get.put(APIProvider());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appdata = GetStorage();

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _setDefaultValues();
    bool isDarkMode = appdata.read(PreferenceKey.darkMode);
    String currentKey = appdata.read(PreferenceKey.languageKey);
    Locale language = Locale(currentKey);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      theme:isDarkMode ? AppThemes().getDarkTheme() : AppThemes().getLightTheme(),
      translations: Strings(),
      locale: language,
      fallbackLocale: const Locale(DefaultValue.languageKey),
      initialRoute: "/",
      home: const SplashScreen(),
      //home: BottomBarPage(),
      //builder: EasyLoading.init(),
    );
  }

  void _setDefaultValues() {
    appdata.writeIfNull(PreferenceKey.darkMode, false);
    appdata.writeIfNull(PreferenceKey.isLoggedIn, false);
    appdata.writeIfNull(PreferenceKey.languageKey, DefaultValue.languageKey);
  }
}
