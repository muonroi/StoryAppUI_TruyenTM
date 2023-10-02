import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:muonroi/core/Authorization/enums/key.dart';
import 'package:muonroi/core/Notification/widget.notification.dart';
import 'package:muonroi/features/chapters/provider/models.chapter.template.settings.dart';
import 'package:muonroi/features/homes/presentation/pages/pages.ladding.index.dart';
import 'package:muonroi/features/settings/provider/theme.mode.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'shared/settings/enums/enum.log.type.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
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
  void initState() {
    NotificationPush.initialize(flutterLocalNotificationsPlugin);
    initLocalStored();
    super.initState();
  }

  initLocalStored() async {
    await SharedPreferences.getInstance().then((value) {
      setState(() {
        _isSigninView = value.getString(KeyToken.accessToken.name) == null;
      });
      return value;
    });
  }

  late bool _isSigninView = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TemplateSetting()),
        ChangeNotifierProvider(create: (_) => CustomThemeModeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _isSigninView ? const SignInPage() : const IndexPage(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
