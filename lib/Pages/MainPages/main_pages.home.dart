import 'package:flutter/material.dart';
import 'package:taxi/Settings/settings.colors.dart';
import 'package:taxi/Settings/settings.fonts.dart';
import 'package:taxi/Settings/settings.images.dart';
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
  @override
  void initState() {
    _searchController = TextEditingController();
    _pageEditorController = PageController(viewportFraction: 0.9);
    _pageCompleteStoriesController = PageController(viewportFraction: 0.9);
    _pageNewStoriesController = PageController(viewportFraction: 0.9);
    _scrollLayoutController = ScrollController();
    _scrollLayoutController.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _pageEditorController.dispose();
    _pageCompleteStoriesController.dispose();
    _pageNewStoriesController.dispose();
    _searchController.dispose();
    _scrollLayoutController.removeListener(_scrollListener);
    _scrollLayoutController.dispose();
    super.dispose();
  }

  // #region Define methods
  void _scrollListener() {
    int firstVisibleIndex = _scrollLayoutController.hasClients
        ? (_scrollLayoutController.offset / _itemHeight).floor()
        : 0;

    setState(() {
      _currentIndex = firstVisibleIndex;
    });
  }
  // #endregion

  // #region Define variables
  double _itemHeight = 0.0;
  int _currentIndex = 0;
  bool _isShowClearText = false;
  late TextEditingController _searchController;
  late PageController _pageEditorController;
  late PageController _pageNewStoriesController;
  late PageController _pageCompleteStoriesController;
  late ScrollController _scrollLayoutController;
  final List<int> items = [];
  late List<Widget> storiesTheFirst = [
    SizedBox(
        width: 101.2,
        height: 120.71,
        child: Image.asset('assets/images/2x/image_4.png', fit: BoxFit.cover)),
    SizedBox(
        width: 101.2,
        height: 120.71,
        child: Image.asset('assets/images/2x/image_5.png', fit: BoxFit.cover)),
    SizedBox(
        width: 101.2,
        height: 120.71,
        child: Image.asset('assets/images/2x/image_3.png', fit: BoxFit.cover)),
    SizedBox(
        width: 101.2,
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
  late List<Widget> commonStories = [
    imageList[0],
    imageList[1],
    imageList[2],
    imageList[3]
  ];
  late List<Widget> components = [
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
    StoriesCategories(
        pageEditorController: _pageEditorController, imageList: imageList),
    GroupCategory(
        titleText: L(ViCode.newUpdatedStoriesTextInfo.toString()),
        nextRoute: const HomePage()),
    StoriesNewUpdated(storiesFillRow: storiesTheFirst),
    StoriesNewUpdated(storiesFillRow: storiesTheFirst),
    GroupCategory(
        titleText: L(ViCode.commonOfStoriesTextInfo.toString()),
        nextRoute: const HomePage()),
    const FilterStoriesByCommon(),
    CommonStories(
      imageWidget: commonStories,
      nameOfStory: 'Nơi nào hạ mát?',
      categoryOfStory: 'Ngôn tình',
      totalViewOfStory: '1,000',
    ),
    GroupCategory(
        titleText: L(ViCode.newStoriesTextInfo.toString()),
        nextRoute: const HomePage()),
    StoriesCategories(
        pageEditorController: _pageNewStoriesController, imageList: imageList),
    GroupCategory(
        titleText: L(ViCode.completeStoriesTextInfo.toString()),
        nextRoute: const HomePage()),
    StoriesCategories(
        pageEditorController: _pageCompleteStoriesController,
        imageList: imageList),
    // #endregion

    // #region Footer
    const OnlyTitle(),
    const ListNewChapter(
        chapterTitle: 'Thần Cấp Đại Ma Hầu', minuteUpdated: '1'),
    // #endregion
  ];
  // #endregion

  // #region Define method
  void _onChangedSearch(String textInput) {
    setState(() {
      _isShowClearText = textInput.isNotEmpty;
    });
  }
  // #endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorDefaults.lightAppColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Image.asset(ImageDefault.mainLogo),
          backgroundColor: ColorDefaults.lightAppColor,
          elevation: 0,
          actions: [
            _currentIndex > 0
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search,
                        color: ColorDefaults.thirdMainColor))
                : IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search,
                        color: Color.fromARGB(255, 255, 255, 255))),
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
        body: LayoutBuilder(
          builder: (context, constraints) {
            _itemHeight = constraints.maxHeight / components.length;
            return ListView.builder(
                scrollDirection: Axis.vertical,
                controller: _scrollLayoutController,
                itemCount: components.length,
                itemBuilder: ((context, index) {
                  return Column(children: [
                    components[index],
                  ]);
                }));
          },
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
