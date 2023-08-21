class ApiNetwork {
  // #region Base api
  static const String baseApi = "https://muonroi.online/api/";
  static const String renewToken = "tokens/access-token";
  static const String baseSearchStory = "stories/search?";
  // #endregion

  // #region Stories endpoint
  static const String getStoriesPaging = "stories/all?pageIndex=%s&pageSize=%s";
  static const String getRecommendStoriesPaging =
      "stories/recommend?storyId=%s&pageIndex=%s&pageSize=%s";
  static const String getDetailStory = "stories/single?storyId=%s";
  static const String voteStory = "stories/vote";

  // #endregion

  // #region Chapters endpoint
  static const String getChapterPaging =
      "chapters/all?storyId=%s&pageIndex=%s&pageSize=%s&isLatest=%s";
  static const String getGroupChapterDetail =
      "chapters/group?storyId=%s&fromChapterId=%s&pageIndex=%s&pageSize=%s&isSetCache=false";
  static const String getChapterDetail = "chapters/detail?chapterId=%s";
  static const String getActionChapterDetail =
      "chapters/%s?storyId=%s&chapterId=%s";

  // #endregion
  // #region Categories endpoint
  static const String getCategoriesPaging =
      "categories?pageSize=%s&pageIndex=%s";
  // #endregion
}
