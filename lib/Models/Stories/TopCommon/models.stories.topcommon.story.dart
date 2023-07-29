import 'package:flutter/cupertino.dart';

class StoryTopCommon {
  late String name;
  late String category;
  late double totalView;
  late Widget image;
  StoryTopCommon({
    required this.image,
    required this.name,
    required this.category,
    required this.totalView,
  });
}
