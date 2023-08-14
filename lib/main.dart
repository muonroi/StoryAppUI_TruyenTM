import 'package:flutter/material.dart';
import 'Pages/LaddingPages/pages.ladding.index.dart';
import 'Settings/settings.colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorDefaults.mainColor,
      ),
      home: const IndexPage(),
    );
  }
}
