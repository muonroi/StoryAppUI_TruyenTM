import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muonroi/core/Authorization/enums/key.dart';
import 'package:muonroi/core/ads/admob.service.ads.dart';
import 'package:muonroi/core/notification/widget.notification.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signin.dart';
import 'package:muonroi/features/chapters/provider/models.chapter.template.settings.dart';
import 'package:muonroi/features/homes/presentation/pages/pages.ladding.index.dart';
import 'package:muonroi/features/notification/provider/notification.provider.dart';
import 'package:muonroi/features/system/provider/theme.mode.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.mode.theme.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/shared/static/certificate/widget.static.cert.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'shared/settings/enums/enum.log.type.dart';

//ca-app-pub-7594358837893425~2188984996 ~ IOS: ca-app-pub-7594358837893425~9518957901
//ca-app-pub-7594358837893425/8777803444 ~ IOS: ca-app-pub-7594358837893425/7003603062
void main() async {
  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // #region Initialize Logging
  await FlutterLogs.initLogs(
      logLevelsEnabled: [
        LogLevel.INFO,
        LogLevel.WARNING,
        LogLevel.ERROR,
        LogLevel.SEVERE
      ],
      timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
      directoryStructure: DirectoryStructure.FOR_DATE,
      logTypesEnabled: [
        LogKind.device.name,
        LogKind.network.name,
        LogKind.errors.name,
        LogKind.info.name
      ],
      logFileExtension: LogFileExtension.LOG,
      logsWriteDirectoryName: "MyLogs",
      logsExportDirectoryName: "MyLogs/Exported",
      debugFileOperations: true,
      isDebuggable: true);
  // #endregion
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    accountResult = null;
    NotificationPush.initialize(flutterLocalNotificationsPlugin);
    initLocalStored();
    super.initState();
  }

  initLocalStored() async {
    await SharedPreferences.getInstance().then((value) {
      setState(() {
        _isSigninView = value.getString(KeyToken.accessToken.name) == null;
        if (!_isSigninView) {
          accountResult =
              accountSignInFromJson(value.getString('userLogin')!).result!;
        }
      });
      return value;
    });
  }

  late bool _isSigninView = false;
  late AccountResult? accountResult;
  @override
  Widget build(BuildContext context) {
    final initFuture = MobileAds.instance.initialize();
    final adState = AdMobService(initFuture);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TemplateSetting()),
        ChangeNotifierProvider(create: (_) => CustomThemeModeProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        Provider<AdMobService>(create: (_) => adState)
      ],
      child: Consumer<CustomThemeModeProvider>(builder:
          (BuildContext context, CustomThemeModeProvider value, Widget? child) {
        var themePick = value.mode == Modes.none ? Modes.light : value.mode;
        ManagerSystemMode.setMode = value;
        return MaterialApp(
          theme: ThemeData(
              brightness:
                  themePick == Modes.dark ? Brightness.dark : Brightness.light),
          debugShowCheckedModeBanner: false,
          home: accountResult != null
              ? _isSigninView
                  ? const SignInPage()
                  : IndexPage(
                      accountResult: accountResult!,
                    )
              : const SignInPage(),
        );
      }),
    );
  }
}
