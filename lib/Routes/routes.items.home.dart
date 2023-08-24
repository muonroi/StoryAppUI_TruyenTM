import 'package:flutter/cupertino.dart';
import 'package:muonroi/Items/Static/Buttons/widget.static.button.search.dart';
import 'package:muonroi/Items/Static/Buttons/widget.static.filter.home.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/Common_Stories/widget.static.stories.common.items.home.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/Complete_Stories/widget.static.stories.complete.items.home.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/New_Stories/widget.static.stories.new.items.home.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/New_Update_Stories/widget.static.stories.new.update.items.home.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/Stories_Editors_Choose/widget.static.editor.choose.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/widget.static.banner.home.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/widget.static.categories.home.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/widget.static.category.stories.home.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/widget.static.chapter.home.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/widget.static.common.stories.home.dart';
import 'package:muonroi/Models/Chapters/models.chapters.list.chapter.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';

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
      List<StoryItems> listStoriesTopCommon,
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
      const Padding(
        padding: EdgeInsets.only(bottom: 32.0),
        child: MainCategories(),
      ),
      GroupCategoryTextInfo(
          titleText: L(ViCode.editorChoiceTextInfo.toString()),
          nextRoute:
              const EditorStories(isShowLabel: false, isShowBack: false)),
      StoriesOfCategoriesData(
        pageEditorController: pageEditorChoiceController,
        data: listStoriesChoiceOfEditor,
        padding: 8.0,
      ),

      GroupCategoryTextInfo(
          titleText: L(ViCode.newUpdatedStoriesTextInfo.toString()),
          nextRoute: const StoriesNewUpdate(
            isShowLabel: false,
            isShowBack: false,
          )),
      StoriesNewUpdatedData(data: listStoriesNewUpdatedFirstRow),

      GroupCategoryTextInfo(
          titleText: L(ViCode.commonOfStoriesTextInfo.toString()),
          nextRoute: const StoriesCommon(
            isShowLabel: true,
            isShowBack: false,
          )),
      const FilterByDateButton(),
      CommonTopStoriesData(
        storiesCommonInfo: listStoriesTopCommon,
      ),

      GroupCategoryTextInfo(
          titleText: L(ViCode.newStoriesTextInfo.toString()),
          nextRoute: const StoriesNew(
            isShowLabel: false,
            isShowBack: false,
          )),
      StoriesOfCategoriesData(
          pageEditorController: pageNewStoriesController,
          data: listNewStories,
          padding: 8.0),

      GroupCategoryTextInfo(
          titleText: L(ViCode.completeStoriesTextInfo.toString()),
          nextRoute: const StoriesComplete(
            isShowLabel: false,
            isShowBack: false,
          )),
      StoriesOfCategoriesData(
          pageEditorController: pageStoriesCompleteController,
          data: listStoriesComplete,
          padding: 8.0),
      // #endregion

      // #region Footer
      OnlyTitleTextInfo(
        textInfo: L(ViCode.newChapterUpdatedTextInfo.toString()),
      ),
      const ListNewChapter(),
      // #endregion
    ];
    return components;
  }
}
