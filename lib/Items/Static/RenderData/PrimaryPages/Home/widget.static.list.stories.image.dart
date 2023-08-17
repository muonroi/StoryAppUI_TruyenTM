import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
        child: CachedNetworkImage(
      imageUrl: imageLink,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
    ));
  }
}
