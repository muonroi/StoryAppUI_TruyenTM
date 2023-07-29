import 'package:flutter/material.dart';

import '../../Settings/settings.colors.dart';
import '../../Settings/settings.fonts.dart';

class BookOfUser extends StatefulWidget {
  const BookOfUser({super.key});

  @override
  State<BookOfUser> createState() => _BookOfUserState();
}

class _BookOfUserState extends State<BookOfUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: ColorDefaults.mainColor,
          fontFamily: FontsDefault.inter),
      home: const BookOfUserBody(),
    );
  }
}

class BookOfUserBody extends StatefulWidget {
  const BookOfUserBody({super.key});

  @override
  State<BookOfUserBody> createState() => _BookOfUserBodyState();
}

class _BookOfUserBodyState extends State<BookOfUserBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {},
          child: Text('< Trở về'),
        ),
      ),
    );
  }
}
