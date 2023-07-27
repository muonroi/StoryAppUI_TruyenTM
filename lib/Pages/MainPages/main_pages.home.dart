import 'package:flutter/material.dart';
import 'package:taxi/Settings/settings.colors.dart';
import 'package:taxi/Settings/settings.fonts.dart';
import 'package:taxi/Settings/settings.language_code.vi..dart';
import '../../Settings/settings.main.dart';
import '../../Widget/Button/widget.button.search.dart';
import '../../Widget/Static/widget.static.banner.dart';
import '../../Widget/Static/widget.static.categories.dart';
import '../../Widget/Static/widget.static.chapter.home_page.dart';
import '../../Widget/Static/widget.static.common.stories.dart';
import '../../Widget/Static/widget.static.filter.dart';
import '../../Widget/Static/widget.static.menu.bottom.dart';
import '../../Widget/Static/widget.static.stories_of_category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: ColorDefaults.mainColor,
          fontFamily: FontsDefault.inter),
      home: const Homebody(),
    );
  }
}

class Homebody extends StatefulWidget {
  const Homebody({super.key});

  @override
  State<Homebody> createState() => _HomebodyState();
}

class _HomebodyState extends State<Homebody> {
  late TextEditingController _searchController;
  late PageController _pageEditorController;
  bool _isShowClearText = false;
  final List<String> buttonTexts = [
    'Button 1',
    'Button 2',
    'Button 3',
    'Button 4',
    'Button 5'
  ];

  late List<Widget> imageList2 = [
    SizedBox(
        width: 63.04,
        height: 120.71,
        child: Image.asset('assets/images/2x/image_3.png', fit: BoxFit.cover)),
    SizedBox(
        width: 63.04,
        height: 120.71,
        child: Image.asset('assets/images/2x/image_4.png', fit: BoxFit.cover)),
    SizedBox(
        width: 63.04,
        height: 120.71,
        child: Image.asset('assets/images/2x/image_5.png', fit: BoxFit.cover)),
    SizedBox(
        width: 63.04,
        height: 120.71,
        child: Image.asset('assets/images/2x/image_3.png', fit: BoxFit.cover)),
    SizedBox(
        width: 63.04,
        height: 120.71,
        child: Image.asset('assets/images/2x/image_4.png', fit: BoxFit.cover))
  ];
  late List<Widget> imageList = [
    SizedBox(
        width: 101.2,
        height: 150.71,
        child: GestureDetector(
            onTap: () {},
            child: Image.asset('assets/images/2x/image_1.png',
                fit: BoxFit.cover))),
    SizedBox(
        width: 101.2,
        height: 150.71,
        child: GestureDetector(
            onTap: () {},
            child: Image.asset('assets/images/2x/image_2.png',
                fit: BoxFit.cover))),
    SizedBox(
        width: 101.2,
        height: 150.71,
        child: Image.asset('assets/images/2x/image_3.png', fit: BoxFit.cover)),
    SizedBox(
        width: 101.2,
        height: 150.71,
        child: Image.asset('assets/images/2x/image_4.png', fit: BoxFit.cover)),
    SizedBox(
        width: 101.2,
        height: 150.71,
        child: Image.asset('assets/images/2x/image_5.png', fit: BoxFit.cover)),
  ];
  @override
  void initState() {
    _searchController = TextEditingController();
    _pageEditorController = PageController(viewportFraction: 0.9);
    super.initState();
  }

  @override
  void dispose() {
    _pageEditorController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onChangedSearch(String textInput) {
    setState(() {
      _isShowClearText = textInput.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorDefaults.lightAppColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const Icon(Icons.abc),
          backgroundColor: ColorDefaults.lightAppColor,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chat_outlined,
                    color: ColorDefaults.thirdMainColor)),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none,
                    color: ColorDefaults.thirdMainColor)),
          ],
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                // #region Header
                SearchContainer(
                    searchController: _searchController,
                    onChanged: _onChangedSearch,
                    isShowClearText: _isShowClearText),
                const BannerHomePage(),
                // #endregion
                // #region Body
                const CategoriesStr(),
                GroupCategory(
                    titleText: L(ViCode.editorChoiceTextInfo.toString()),
                    nextRoute: const HomePage()),
                StoriesChoiceEditors(
                    pageEditorController: _pageEditorController,
                    imageList: imageList),
                GroupCategory(
                    titleText: L(ViCode.newUpdatedStoriesTextInfo.toString()),
                    nextRoute: const HomePage()),
                StoriesNewUpdated(imageList2: imageList2),
                GroupCategory(
                    titleText: L(ViCode.commonOfStoriesTextInfo.toString()),
                    nextRoute: const HomePage()),
                const FilterStoriesByCommon(),
                CommonStories(
                  imageWidget: imageList[0],
                  nameOfStory: 'Nơi nào hạ mát?',
                  categoryOfStory: 'Ngôn tình',
                  totalViewOfStory: '1,000',
                ),
                GroupCategory(
                    titleText: L(ViCode.newStoriesTextInfo.toString()),
                    nextRoute: const HomePage()),
                StoriesChoiceEditors(
                    pageEditorController: _pageEditorController,
                    imageList: imageList),
                GroupCategory(
                    titleText: L(ViCode.completeStoriesTextInfo.toString()),
                    nextRoute: const HomePage()),
                StoriesChoiceEditors(
                    pageEditorController: _pageEditorController,
                    imageList: imageList),
                // #endregion
                // #region Footer
                const NewChapterTitle(),
                const ListNewChapter(
                    chapterTitle: 'Thần Cấp Đại Ma Hầu', minuteUpdated: '1'),
                // #endregion
              ],
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: ColorDefaults.mainColor,
          child: Icon(
            Icons.arrow_right,
            size: MainSetting.getPercentageOfDevice(context, expectWidth: 50)
                .width,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const DockerCenterBottomAppBar(
            fabLocation: FloatingActionButtonLocation.centerDocked));
  }
}
