import 'package:flutter/material.dart';
import 'package:muonroi/features/Chapters/provider/models.chapter.scroll.button.setting.dart';
import 'package:muonroi/features/Chapters/provider/models.chapter.ui.available.settings.dart';
import 'package:provider/provider.dart';
import 'features/Homes/presentation/pages/pages.ladding.index.dart';
import 'shared/Settings/settings.colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingObject()),
        ChangeNotifierProvider(create: (_) => ButtonScrollSettings()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: ColorDefaults.mainColor,
        ),
        darkTheme: ThemeData.dark(),
        home: const IndexPage(),
      ),
    );
  }
}
