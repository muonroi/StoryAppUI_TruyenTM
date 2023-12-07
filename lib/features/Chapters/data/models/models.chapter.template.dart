import 'dart:ui';

import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';

class ChapterTemplate {
  late Color? background;
  late Color? font;
  late String? fontFamily;
  late double? fontSize;
  late bool? isLeftAlign;
  late KeyChapterButtonScroll? locationScrollButton;
  late bool? isHorizontal;
  ChapterTemplate(
      {required this.background,
      required this.font,
      required this.fontFamily,
      required this.fontSize,
      required this.isLeftAlign,
      required this.locationScrollButton,
      required this.isHorizontal});
}
