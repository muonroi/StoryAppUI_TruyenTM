import 'package:flutter/cupertino.dart';
import '../../../Models/Chapters/models.chapters.chapter.dart';
import '../../../Models/Stories/TopCommon/models.stories.topcommon.story.dart';
import '../Buttons/widget.button.search.dart';
import '../../../Settings/settings.language_code.vi..dart';
import '../../../Settings/settings.main.dart';
import '../Buttons/widget.static.filter.home.dart';
import 'widget.static.banner.home.dart';
import 'widget.static.categories.home.dart';
import 'widget.static.chapter.home.dart';
import 'widget.static.common.stories.home.dart';
import 'widget.static.category.stories.home.dart';
import '../../../Pages/MainPages/main_pages.home.dart';

class HomePageItems {
  List<Widget> getHomePageItems(
      PageController pageEditorChoiceController,
      List<Widget> listStoriesChoiceOfEditor,
      List<Widget> listStoriesNewUpdatedFirstRow,
      List<Widget> listStoriesNewUpdatedSecondRow,
      PageController pageNewStoriesController,
      List<Widget> listNewStories,
      PageController pageStoriesCompleteController,
      List<Widget> listStoriesComplete,
      TextEditingController textSearchController,
      ValueChanged<String> funcOnChangedSearch,
      bool isShowClearText,
      PageController pageBannerController,
      List<Widget> listBannerImage,
      List<ChapterInfo> listChapter,
      List<StoryTopCommon> listStoriesTopCommon,
      {int numberOfBanner = 3}) {
    late List<Widget> components = [
      // #region Header
      SearchContainer(
          searchController: textSearchController,
          onChanged: funcOnChangedSearch,
          isShowClearText: isShowClearText),
      BannerHomePage(
        bannerController: pageBannerController,
        bannerListImage: listBannerImage,
        numberOfBanner: numberOfBanner,
      ),

      // #endregion

      // #region Body
      const MainCategories(),
      GroupCategoryTextInfo(
          titleText: L(ViCode.editorChoiceTextInfo.toString()),
          nextRoute: const MainPage()),
      StoriesOfCategoriesData(
          pageEditorController: pageEditorChoiceController,
          imageList: listStoriesChoiceOfEditor),
      GroupCategoryTextInfo(
          titleText: L(ViCode.newUpdatedStoriesTextInfo.toString()),
          nextRoute: const MainPage()),
      StoriesNewUpdatedData(storiesData: listStoriesNewUpdatedFirstRow),
      StoriesNewUpdatedData(storiesData: listStoriesNewUpdatedSecondRow),
      GroupCategoryTextInfo(
          titleText: L(ViCode.commonOfStoriesTextInfo.toString()),
          nextRoute: const MainPage()),
      const FilterByDateButton(),
      CommonTopStoriesData(
        storiesCommonInfo: listStoriesTopCommon,
      ),
      GroupCategoryTextInfo(
          titleText: L(ViCode.newStoriesTextInfo.toString()),
          nextRoute: const MainPage()),
      StoriesOfCategoriesData(
          pageEditorController: pageNewStoriesController,
          imageList: listNewStories),
      GroupCategoryTextInfo(
          titleText: L(ViCode.completeStoriesTextInfo.toString()),
          nextRoute: const MainPage()),
      StoriesOfCategoriesData(
          pageEditorController: pageStoriesCompleteController,
          imageList: listStoriesComplete),
      // #endregion
      // #region Footer
      const OnlyTitleTextInfo(),
      ListNewChapter(chapterInfos: listChapter),
      // #endregion
    ];
    return components;
  }
}
