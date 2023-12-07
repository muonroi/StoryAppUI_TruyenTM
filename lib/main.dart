import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:muonroi/core/advertising/ads.admob.service.dart';
import 'package:muonroi/core/notification/widget.notification.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.ladding.page.dart';
import 'package:muonroi/features/chapters/provider/provider.chapter.template.settings.dart';
import 'package:muonroi/features/homes/presentation/pages/page.book.case.dart';
import 'package:muonroi/features/notification/provider/provider.notification.dart';
import 'package:muonroi/features/system/provider/provider.theme.mode.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.mode.theme.dart';
import 'package:muonroi/shared/settings/setting.box.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/shared/static/certificate/widget.static.cert.dart';
import 'package:provider/provider.dart';
import 'shared/settings/enums/enum.log.type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // audioHandler = await AudioService.init(
  //   builder: () => TextPlayerHandler(),
  //   config: const AudioServiceConfig(
  //       androidNotificationChannelId: 'com.muonroi.truyentm.channel.audio',
  //       androidNotificationChannelName: 'Audio playback',
  //       androidNotificationOngoing: true,
  //       androidNotificationIcon: 'mipmap/launcher_icon'),
  // );
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  chapterBox = await Hive.openBox(CustomBox.chapter);
  templateChapterBox = await Hive.openBox(CustomBox.templateChapter);
  userBox = await Hive.openBox(CustomBox.user);
  systemBox = await Hive.openBox(CustomBox.systemBox);
  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }
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
    NotificationPush.initialize(flutterLocalNotificationsPlugin);
    _connectionStatus = InternetStatus.connected;
    super.initState();
    _subscription = InternetConnection().onStatusChange.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  late StreamSubscription<InternetStatus> _subscription;
  late InternetStatus _connectionStatus;
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
            home: _connectionStatus == InternetStatus.disconnected
                ? const BookCase()
                : const LaddingPage());
      }),
    );
  }
}
