import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/settings.main.dart';

class StoriesImageIncludeSizeBox extends StatelessWidget {
  final int storyId;
  final String nameStory;
  final String imageLink;
  const StoriesImageIncludeSizeBox({
    super.key,
    required this.imageLink,
    required this.storyId,
    required this.nameStory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: netWorkImage(context, imageLink, true, isHome: true),
    );
  }
}
