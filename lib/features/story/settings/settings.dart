import 'package:muonroi/features/story/data/models/models.single.story.dart';

StorySingleResult storySingleDefaultData() {
  return StorySingleResult(
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
