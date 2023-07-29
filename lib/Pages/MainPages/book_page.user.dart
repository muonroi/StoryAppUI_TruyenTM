import 'package:flutter/material.dart';

import '../../Settings/settings.colors.dart';
import '../../Settings/settings.fonts.dart';

class RenderBookOfUser extends StatefulWidget {
  const RenderBookOfUser({super.key});

  @override
  State<RenderBookOfUser> createState() => _RenderBookOfUserState();
}

class _RenderBookOfUserState extends State<RenderBookOfUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
          child: Text(
            '< Trở về',
            style: FontsDefault.h1,
          ),
        ),
      ),
    );
  }
}
