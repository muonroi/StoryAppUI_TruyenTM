import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/provider/models.chapter.template.settings.dart';
import 'package:provider/provider.dart';
import 'features/homes/presentation/pages/pages.ladding.index.dart';
import 'shared/settings/settings.colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TemplateSetting()),
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
