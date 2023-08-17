class ApiNetwork {
  // #region Base api
  static const String baseApi = "https://muonroi.online/api/";
  // #endregion

  // #region Stories endpoint
  static const String getStoriesPaging = "stories/all?pageIndex=%s&pageSize=%s";
  static const String getRecommendStoriesPaging =
      "stories/recommend?storyId=%s&pageIndex=%s&pageSize=%s";
  static const String getDetailStory = "stories/single?storyId=%s";
  // #endregion

  // #region Chapters endpoint
  static const String getChapterPaging =
      "chapters/all?storyId=%s&pageIndex=%s&pageSize=%s&isLatest=%s";
  static const String getGroupChapterDetail =
      "chapters/group?storyId=%s&fromChapterId=%s&pageIndex=%s&pageSize=%s&isSetCache=false";
  // #endregion
}
