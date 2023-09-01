class ApiNetwork {
  static const String apiVersion = "1.0";
  // #region Base api
  static const String baseApi = "https://muonroi.online/api/v$apiVersion/";
  static const String renewToken = "tokens/access-token";
  static const String baseSearchStory = "stories/search?";
  // #endregion

// #region Account endpoint
  static const String login = "users/login";
  static const String register = "users";
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
  static const String getLatestChapterNumber =
      "chapters/latest/all?pageIndex=%s&pageSize=%s&isSetCache=false";
  static const String getListChapterPaging =
      "chapters/paging-chapter?storyId=%s";
  static const String getFromToChapterPaging =
      "chapters/group?storyId=%s&fromChapterId=%s&toChapterId=%s";
  // #endregion
  // #region Categories endpoint
  static const String getCategoriesPaging =
      "categories?pageSize=%s&pageIndex=%s";
  // #endregion
}
