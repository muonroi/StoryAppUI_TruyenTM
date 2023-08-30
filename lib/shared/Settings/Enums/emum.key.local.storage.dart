enum KeyChapterTemplate {
  chapterConfig,
  fontFamily,
  fontColor,
  backgroundColor,
  fontSize
}

enum KeyChapterButtonScroll {
  none,
  buttonScroll,
  show;

  String toJson() => name;
  static KeyChapterButtonScroll fromJson(String json) => values.byName(json);
}

enum KeyChapterColor { chapterColor, none, background, font }
