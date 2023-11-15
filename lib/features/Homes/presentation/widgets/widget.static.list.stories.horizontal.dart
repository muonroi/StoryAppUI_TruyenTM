import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class StoriesListHorizontal extends StatelessWidget {
  final String imageUrl;
  const StoriesListHorizontal({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MainSetting.getPercentageOfDevice(context, expectWidth: 101.2)
            .width,
        height: MainSetting.getPercentageOfDevice(context, expectHeight: 150.71)
            .height,
        child: GestureDetector(
          onTap: () {},
          child: netWorkImage(context, imageUrl, true),
        ));
  }
}
