class ApiNetwork {
  static const String apiVersion = "1.0";
  static const String urlApp =
      "https://play.google.com/store/apps/details?id=com.muonroi.truyentm";
  // #region Base api
  static const String baseUrl = "https://muonroi.online/";
  static const String baseApi = "${baseUrl}api/v$apiVersion/";
  static const String renewToken = "tokens/access-token";
  // #endregion

// #region Settings
  static const String banners = "settings/banners?type=%s";
  static const String settingByType = "settings/all?type=%s";

// #endregion

  // #region Signalr
  static const String notification = "hub/notification?access_token=%s";
  // #endregion

// #region Account endpoint
  static const String logout = "tokens/logout";
// #endregion

// #region User endpoint
  static const String userInfoByUsername = "users/single/username?username=%s";
  static const String login = "users/login";
  static const String forgotPassword = "users/forgot-password";
  static const String curdUser = "users";
  static const String updateInfo = "users/profile";
  static const String uploadAvatar = "users/update-avatar";
  static const String validateOtp = "users/valid-otp";
  static const String changePassword = "users/change-password";
  static const String userSubscription = "users/subscription";
  static const String duplicateUsername =
      "users/duplicate/username?username=%s";
// #endregion

  // #region Stories endpoint
  static const String getStoriesPaging = "stories/all?pageIndex=%s&pageSize=%s";
  static const String getRecommendStoriesPaging =
      "stories/recommend?storyId=%s&pageIndex=%s&pageSize=%s";
  static const String getDetailStory = "stories/single?storyId=%s";
  static const String voteStory = "stories/vote";
  static const String bookmarkStory = "stories/bookmark";
  static const String storiesNotificationUser =
      "stories/notification/user?pageIndex=%s&pageSize=%s";
  static const String viewAllNotificationUser = "stories/notification/all";
  static const String viewSingleNotificationUser = "stories/notification";
  static const String createStoryForUser = "stories/for/user";
  static const String deleteStoryForUser = "stories/for/user";
  static const String getStoriesForUser =
      "stories/for/user?type=%s&pageIndex=%s&pageSize=%s";
  static const String getStoriesCommon =
      "stories/common?type=%s&pageIndex=%s&pageSize=%s";
  static const String getStoriesType =
      "stories/type?type=%s&pageIndex=%s&pageSize=%s";
  static const String baseSearchStory = "stories/search?";
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
      "chapters/group?storyId=%s&pageIndex=%s&fromChapterId=%s&toChapterId=%s&isSetCache=true";
  static const String getGroupChapters =
      "chapters/group-chapter?storyId=%s&pageIndex=%s&pageSize=%s";
  // #endregion

  // #region Categories endpoint
  static const String getCategoriesPaging =
      "categories?pageSize=%s&pageIndex=%s";
  // #endregion
}
