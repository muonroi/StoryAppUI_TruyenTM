import 'package:flutter/cupertino.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.button.search.dart';
import 'package:muonroi/features/story/settings/enums/enum.stories.common.dart';
import 'package:muonroi/features/story/settings/enums/enum.stories.special.dart';
import 'package:muonroi/shared/static/buttons/widget.static.filter.home.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.banner.home.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.categories.home.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.category.stories.home.dart';
import 'package:muonroi/features/story/presentation/pages/page.editor.choose.dart';
import 'package:muonroi/features/story/presentation/pages/page.stories.common.items.home.dart';

class HomePageItems {
  List<Widget> getHomePageItems(
      BuildContext context,
      PageController pageEditorChoiceController,
      PageController pageNewStoriesController,
      PageController pageStoriesCompleteController,
      TextEditingController textSearchController,
      ValueChanged<String> funcOnChangedSearch,
      bool isShowClearText,
      PageController pageBannerController,
      {int numberOfBanner = 3}) {
    late List<Widget> components = [
      // #region Header
      SearchContainer(
          searchController: textSearchController,
          onChanged: funcOnChangedSearch,
          isShowClearText: isShowClearText),
      BannerHomePage(
        bannerController: pageBannerController,
        numberOfBanner: numberOfBanner,
      ),

      // #endregion

      // #region Body
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: MainCategories(),
      ),

      // #region All stories
      GroupCategoryTextInfo(
          titleText: L(context, LanguageCodes.trendStoriesTextInfo.toString()),
          nextRoute: RegularStories(
            nameTypeRegularStories:
                L(context, LanguageCodes.trendStoriesTextInfo.toString()),
            type: EnumStoriesSpecial.storiesAll,
          )),
      StoriesOfCategoriesData(
        isHaveData: false,
        pageEditorController: pageEditorChoiceController,
        type: EnumStoriesSpecial.storiesAll,
        padding: 8.0,
      ),
      // #endregion

      // #region New updated stories
      GroupCategoryTextInfo(
          titleText:
              L(context, LanguageCodes.newUpdatedStoriesTextInfo.toString()),
          nextRoute: RegularStories(
            nameTypeRegularStories:
                L(context, LanguageCodes.newUpdatedStoriesTextInfo.toString()),
            type: EnumStoriesSpecial.storiesNewUpdate,
          )),
      const StoriesNewUpdatedData(
        type: EnumStoriesSpecial.storiesNewUpdate,
      ),
      // #endregion

      // #region Top stories
      GroupCategoryTextInfo(
          titleText:
              L(context, LanguageCodes.commonOfStoriesTextInfo.toString()),
          nextRoute: const StoriesCommon(
            type: EnumStoriesCommon.all,
          )),
      SizedBox(
          height: MainSetting.getPercentageOfDevice(context, expectHeight: 400)
              .height,
          child: const FilterByDateButton()),
      // #endregion

      // #region New stories
      GroupCategoryTextInfo(
          titleText: L(context, LanguageCodes.newStoriesTextInfo.toString()),
          nextRoute: RegularStories(
            nameTypeRegularStories:
                L(context, LanguageCodes.newStoriesTextInfo.toString()),
            type: EnumStoriesSpecial.storiesNew,
          )),
      StoriesOfCategoriesData(
          isHaveData: false,
          pageEditorController: pageNewStoriesController,
          type: EnumStoriesSpecial.storiesNew,
          padding: 8.0),
      // #endregion

      // #region Stories complete
      GroupCategoryTextInfo(
          titleText:
              L(context, LanguageCodes.completeStoriesTextInfo.toString()),
          nextRoute: RegularStories(
            nameTypeRegularStories:
                L(context, LanguageCodes.completeStoriesTextInfo.toString()),
            type: EnumStoriesSpecial.storiesComplete,
          )),
      StoriesOfCategoriesData(
          isHaveData: false,
          pageEditorController: pageStoriesCompleteController,
          type: EnumStoriesSpecial.storiesComplete,
          padding: 8.0),
      // #endregion

      // #endregion

      // // #region Footer
      // OnlyTitleTextInfo(
      //   textInfo:
      //       L(context, LanguageCodes.newChapterUpdatedTextInfo.toString()),
      // ),
      // const ListNewChapter(),
      // // #endregion
    ];
    return components;
  }
}
