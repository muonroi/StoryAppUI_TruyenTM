import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/Settings/settings.main.dart';

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
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            )));
  }
}
