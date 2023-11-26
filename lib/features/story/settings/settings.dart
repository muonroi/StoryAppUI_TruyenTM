import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:muonroi/features/story/data/models/model.single.story.dart';

StorySingleResult storySingleDefaultData() {
  return StorySingleResult(
      idForUser: 0,
      bookmarkId: 0,
      id: -1,
      guid: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      storyTitle: "",
      storySynopsis: "",
      imgUrl: "",
      isShow: false,
      totalView: 0,
      totalFavorite: 0,
      rankNumber: 0,
      rating: 0,
      slug: "",
      nameCategory: "",
      authorName: "",
      nameTag: [],
      totalVote: 0,
      totalChapter: 0,
      updatedDateTs: 0,
      updatedDateString: "",
      firstChapterId: 0,
      lastChapterId: 0,
      slugAuthor: "",
      isBookmark: false,
      totalPageIndex: 0);
}

String formatNumberThouSand(double value) {
  if (value >= 1000) {
    var number = value / 1000;
    var initNumber = number.truncate();
    var decimalNumber = ((number - initNumber) * 10).toInt();
    var numberString =
        '${initNumber}k${decimalNumber > 0 ? decimalNumber : ''}';
    return numberString;
  } else {
    return value.toInt().toString();
  }
}

const Color primaryColor = Color(0xFF2967FF);
const Color grayColor = Color(0xFF8D8D8E);

const double defaultPadding = 16.0;

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;
  return parsedString;
}

List<String> splitString(String input, int maxLength) {
  List<String> result = [];
  for (int i = 0; i < input.length; i += maxLength) {
    result.add(input.substring(
        i, i + maxLength > input.length ? input.length : i + maxLength));
  }
  return result;
}

enum TtsState { playing, stopped, paused, continued }

final GlobalKey<ScaffoldState> chapterAudioKey = GlobalKey<ScaffoldState>();
