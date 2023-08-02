import 'package:flutter/cupertino.dart';
import '../Items/Static/RenderData/widget.static.editor.choice.dart';
import '../Items/Static/RenderData/widget.static.stories.vertical.dart';
import '../Models/Chapters/models.chapters.chapter.dart';
import '../Models/Stories/models.stories.story.dart';
import '../Items/Static/Buttons/widget.static.button.search.dart';
import '../Settings/settings.language_code.vi..dart';
import '../Settings/settings.main.dart';
import '../Items/Static/Buttons/widget.static.filter.home.dart';
import '../Items/Static/RenderData/widget.static.banner.home.dart';
import '../Items/Static/RenderData/widget.static.categories.home.dart';
import '../Items/Static/RenderData/widget.static.chapter.home.dart';
import '../Items/Static/RenderData/widget.static.common.stories.home.dart';
import '../Items/Static/RenderData/widget.static.category.stories.home.dart';

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
      List<StoryModel> listStoriesTopCommon,
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
          nextRoute: EditorStories(
            storiesData: [
              [
                StoryModel(
                    image:
                        'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                    name: 'Than cap dai ma dau',
                    category: 'huyen huyen',
                    totalView: 1576),
                StoryModel(
                    image:
                        'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                    name: 'Than cap dai ma dau',
                    category: 'huyen huyen',
                    totalView: 1576),
                StoryModel(
                    image:
                        'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                    name: 'Than cap dai ma dau',
                    category: 'huyen huyen',
                    totalView: 1576),
                StoryModel(
                    image:
                        'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                    name: 'Than cap dai ma dau',
                    category: 'huyen huyen',
                    totalView: 1576),
              ],
              [
                StoryModel(
                    image:
                        'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                    name: 'Than cap dai ma dau',
                    category: 'huyen huyen',
                    totalView: 1576),
                StoryModel(
                    image:
                        'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                    name: 'Than cap dai ma dau',
                    category: 'huyen huyen',
                    totalView: 1576),
                StoryModel(
                    image:
                        'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                    name: 'Than cap dai ma dau',
                    category: 'huyen huyen',
                    totalView: 1576),
                StoryModel(
                    image:
                        'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                    name: 'Than cap dai ma dau',
                    category: 'huyen huyen',
                    totalView: 1576),
              ]
            ],
          )),
      StoriesOfCategoriesData(
        pageEditorController: pageEditorChoiceController,
        data: listStoriesChoiceOfEditor,
      ),

      GroupCategoryTextInfo(
          titleText: L(ViCode.newUpdatedStoriesTextInfo.toString()),
          nextRoute: StoriesVerticalData(
            isShowLabel: false,
            storiesData: [
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/085339edd8d1f181ea709879862bebddf69e1f426809e10b9015359fa887bbba.jpg',
                  name: 'Bách luyện thành tiên',
                  category: 'Tiên hiệp',
                  totalView: 16,
                  authorName: 'Lão trư',
                  numberOfChapter: 2560,
                  lastUpdated: 1,
                  tagsName: ['Sắc', 'Nhiều vợ']),
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/951c6f420501016a2f36700aa1e806b3072d45ff270b676ebba284416bc5fad4.jpg',
                  name: 'Ngã dục phong thiên',
                  category: 'Yêu nhân',
                  totalView: 1254,
                  authorName: 'Nhĩ căn',
                  numberOfChapter: 1231,
                  lastUpdated: 2,
                  tagsName: ['Yêu vật', 'Anh vũ']),
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/b65d0b5b1902b17daa87e615174905e60df4be42d649d85ac4b4877d7bc95306.jpg',
                  name: 'Tiên nghịch',
                  category: 'Huyền huyễn',
                  totalView: 1230,
                  authorName: 'Lão ngũ',
                  numberOfChapter: 3201,
                  lastUpdated: 2,
                  tagsName: ['Tiên', 'Ma']),
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/08608f3e3f75d30b8fdf7377e409e284b652cd1daf2f03adede578843eb40f29.jpg',
                  name: 'Thần cấp đại ma thần',
                  category: 'Tiên hiệp',
                  totalView: 1576,
                  authorName: 'Nhĩ căn',
                  numberOfChapter: 3000,
                  lastUpdated: 3,
                  tagsName: ['Hoàn thành', 'Não tàn']),
            ],
          )),
      StoriesNewUpdatedData(data: listStoriesNewUpdatedFirstRow),

      GroupCategoryTextInfo(
          titleText: L(ViCode.commonOfStoriesTextInfo.toString()),
          nextRoute: StoriesVerticalData(
            isShowLabel: true,
            storiesData: [
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/085339edd8d1f181ea709879862bebddf69e1f426809e10b9015359fa887bbba.jpg',
                  name: 'Bách luyện thành tiên',
                  category: 'Tiên hiệp',
                  totalView: 16,
                  authorName: 'Lão trư',
                  numberOfChapter: 2560,
                  lastUpdated: 1,
                  rankNumber: 10,
                  tagsName: ['Sắc', 'Nhiều vợ']),
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/951c6f420501016a2f36700aa1e806b3072d45ff270b676ebba284416bc5fad4.jpg',
                  name: 'Ngã dục phong thiên',
                  category: 'Yêu nhân',
                  totalView: 1254,
                  authorName: 'Nhĩ căn',
                  numberOfChapter: 1231,
                  lastUpdated: 2,
                  rankNumber: 2,
                  tagsName: ['Yêu vật', 'Anh vũ']),
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/b65d0b5b1902b17daa87e615174905e60df4be42d649d85ac4b4877d7bc95306.jpg',
                  name: 'Tiên nghịch',
                  category: 'Huyền huyễn',
                  totalView: 1230,
                  authorName: 'Lão ngũ',
                  numberOfChapter: 3201,
                  lastUpdated: 2,
                  rankNumber: 1,
                  tagsName: ['Tiên', 'Ma']),
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/08608f3e3f75d30b8fdf7377e409e284b652cd1daf2f03adede578843eb40f29.jpg',
                  name: 'Thần cấp đại ma thần',
                  category: 'Tiên hiệp',
                  totalView: 1576,
                  authorName: 'Nhĩ căn',
                  numberOfChapter: 3000,
                  lastUpdated: 3,
                  rankNumber: 3,
                  tagsName: ['Hoàn thành', 'Não tàn']),
            ],
          )),
      const FilterByDateButton(),
      CommonTopStoriesData(
        storiesCommonInfo: listStoriesTopCommon,
      ),

      GroupCategoryTextInfo(
          titleText: L(ViCode.newStoriesTextInfo.toString()),
          nextRoute: StoriesVerticalData(
            isShowLabel: false,
            storiesData: [
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/085339edd8d1f181ea709879862bebddf69e1f426809e10b9015359fa887bbba.jpg',
                  name: 'Bách luyện thành tiên',
                  category: 'Tiên hiệp',
                  totalView: 16,
                  authorName: 'Lão trư',
                  numberOfChapter: 2560,
                  lastUpdated: 1,
                  rankNumber: 10,
                  tagsName: ['Sắc', 'Nhiều vợ']),
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/951c6f420501016a2f36700aa1e806b3072d45ff270b676ebba284416bc5fad4.jpg',
                  name: 'Ngã dục phong thiên',
                  category: 'Yêu nhân',
                  totalView: 1254,
                  authorName: 'Nhĩ căn',
                  numberOfChapter: 1231,
                  lastUpdated: 2,
                  rankNumber: 2,
                  tagsName: ['Yêu vật', 'Anh vũ']),
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/b65d0b5b1902b17daa87e615174905e60df4be42d649d85ac4b4877d7bc95306.jpg',
                  name: 'Tiên nghịch',
                  category: 'Huyền huyễn',
                  totalView: 1230,
                  authorName: 'Lão ngũ',
                  numberOfChapter: 3201,
                  lastUpdated: 2,
                  rankNumber: 1,
                  tagsName: ['Tiên', 'Ma']),
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/08608f3e3f75d30b8fdf7377e409e284b652cd1daf2f03adede578843eb40f29.jpg',
                  name: 'Thần cấp đại ma thần',
                  category: 'Tiên hiệp',
                  totalView: 1576,
                  authorName: 'Nhĩ căn',
                  numberOfChapter: 3000,
                  lastUpdated: 3,
                  rankNumber: 3,
                  tagsName: ['Hoàn thành', 'Não tàn']),
            ],
          )),
      StoriesOfCategoriesData(
        pageEditorController: pageNewStoriesController,
        data: listNewStories,
      ),

      GroupCategoryTextInfo(
          titleText: L(ViCode.completeStoriesTextInfo.toString()),
          nextRoute: StoriesVerticalData(
            isShowLabel: false,
            storiesData: [
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/085339edd8d1f181ea709879862bebddf69e1f426809e10b9015359fa887bbba.jpg',
                  name: 'Bách luyện thành tiên',
                  category: 'Tiên hiệp',
                  totalView: 16,
                  authorName: 'Lão trư',
                  numberOfChapter: 2560,
                  lastUpdated: 1,
                  rankNumber: 10,
                  tagsName: ['Sắc', 'Nhiều vợ']),
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/951c6f420501016a2f36700aa1e806b3072d45ff270b676ebba284416bc5fad4.jpg',
                  name: 'Ngã dục phong thiên',
                  category: 'Yêu nhân',
                  totalView: 1254,
                  authorName: 'Nhĩ căn',
                  numberOfChapter: 1231,
                  lastUpdated: 2,
                  rankNumber: 2,
                  tagsName: ['Yêu vật', 'Anh vũ']),
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/b65d0b5b1902b17daa87e615174905e60df4be42d649d85ac4b4877d7bc95306.jpg',
                  name: 'Tiên nghịch',
                  category: 'Huyền huyễn',
                  totalView: 1230,
                  authorName: 'Lão ngũ',
                  numberOfChapter: 3201,
                  lastUpdated: 2,
                  rankNumber: 1,
                  tagsName: ['Tiên', 'Ma']),
              StoryModel(
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/08608f3e3f75d30b8fdf7377e409e284b652cd1daf2f03adede578843eb40f29.jpg',
                  name: 'Thần cấp đại ma thần',
                  category: 'Tiên hiệp',
                  totalView: 1576,
                  authorName: 'Nhĩ căn',
                  numberOfChapter: 3000,
                  lastUpdated: 3,
                  rankNumber: 3,
                  tagsName: ['Hoàn thành', 'Não tàn']),
            ],
          )),
      StoriesOfCategoriesData(
        pageEditorController: pageStoriesCompleteController,
        data: listStoriesComplete,
      ),
      // #endregion

      // #region Footer
      OnlyTitleTextInfo(
        textInfo: L(ViCode.newChapterUpdatedTextInfo.toString()),
      ),
      ListNewChapter(chapterInfos: listChapter),
      // #endregion
    ];
    return components;
  }
}
