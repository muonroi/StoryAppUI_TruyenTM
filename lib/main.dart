import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muonroi/core/Authorization/enums/key.dart';
import 'package:muonroi/core/advertising/ads.admob.service.dart';
import 'package:muonroi/core/notification/widget.notification.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/settings/enum/enum.platform.dart';
import 'package:muonroi/features/chapters/provider/provider.chapter.template.settings.dart';
import 'package:muonroi/features/homes/settings/settings.dart';
import 'package:muonroi/features/notification/provider/provider.notification.dart';
import 'package:muonroi/features/system/provider/provider.theme.mode.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.mode.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/shared/static/certificate/widget.static.cert.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shared/settings/enums/enum.log.type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    _isSigninView = false;
    _accountResult = null;
    initLocalStored();
    uid = null;
    NotificationPush.initialize(flutterLocalNotificationsPlugin);
    super.initState();
  }

  initLocalStored() async {
    await SharedPreferences.getInstance().then((value) {
      if (context.mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          var method = value.getString("MethodLogin");
          setState(() {
            _isSigninView = value.getString(KeyToken.accessToken.name) == null;
          });

          if (method == EnumPlatform.google.name) {
            final FirebaseAuth auth = FirebaseAuth.instance;
            var userInfo = auth.currentUser;
            if (userInfo != null) {
              var accountRepository = AccountRepository();
              uid = userInfo.uid;
              var accountInfo = await accountRepository.signIn(
                userInfo.email!,
                "${userInfo.uid}12345678Az*",
                uid,
              );

              if (accountInfo.result == null) {
                _isSigninView = true;
              }

              value.setString(
                KeyToken.accessToken.name,
                accountInfo.result!.jwtToken,
              );
              value.setString(
                KeyToken.refreshToken.name,
                accountInfo.result!.refreshToken,
              );
              value.setString(
                'userLogin',
                accountSignInToJson(accountInfo),
              );

              if (mounted) {
                setState(() {
                  _isSigninView = false;
                  _accountResult =
                      accountSignInFromJson(value.getString('userLogin')!)
                          .result!;
                });
              }
            }
          }

          if (method == EnumPlatform.system.name) {
            if (!_isSigninView) {
              if (mounted) {
                setState(() {
                  _accountResult =
                      accountSignInFromJson(value.getString('userLogin')!)
                          .result!;
                });
              }
            }
          }
        });
      }

      return value;
    });
  }

  late String? uid;
  late bool _isSigninView;
  late AccountResult? _accountResult;
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
                brightness: themePick == Modes.dark
                    ? Brightness.dark
                    : Brightness.light),
            debugShowCheckedModeBanner: false,
            home: homeLoading(
                accountResult: _accountResult, signinView: _isSigninView));
      }),
    );
  }
}
