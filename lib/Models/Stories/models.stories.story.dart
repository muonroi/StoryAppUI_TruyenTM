class StoryModel {
  late String name;
  late String? category;
  late double? totalView;
  late String image;
  late String? authorName;
  late int? lastUpdated;
  late List<String>? tagsName;
  late double? numberOfChapter;
  late int? rankNumber;
  StoryModel(
      {required this.image,
      required this.name,
      this.category,
      this.totalView,
      this.authorName,
      this.tagsName,
      this.numberOfChapter,
      this.lastUpdated,
      this.rankNumber});
}
