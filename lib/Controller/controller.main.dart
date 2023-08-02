import 'package:flutter/material.dart';
import 'package:muonroi/Models/Chapters/models.chapters.chapter.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.images.dart';
import '../Models/Stories/models.stories.story.dart';
import '../Pages/PrimaryPages/pages.book.case.dart';
import '../Settings/settings.main.dart';
import '../Items/Static/Buttons/widget.static.menu.bottom.shared.dart';
import '../Routes/routes.items.home.dart';
import '../Pages/PrimaryPages/pages.home.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: ColorDefaults.mainColor,
          fontFamily: FontsDefault.inter),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// #region Setting shared
  @override
  void initState() {
    _textSearchController = TextEditingController();
    _scrollLayoutController = ScrollController();
    _scrollLayoutController.addListener(_scrollListener);
    _pageEditorChoiceController = PageController(viewportFraction: 0.9);
    _pageStoriesCompleteController = PageController(viewportFraction: 0.9);
    _pageNewStoriesController = PageController(viewportFraction: 0.9);
    _pageBannerController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _textSearchController.dispose();
    _scrollLayoutController.removeListener(_scrollListener);
    _scrollLayoutController.dispose();
    _pageEditorChoiceController.dispose();
    _pageStoriesCompleteController.dispose();
    _pageNewStoriesController.dispose();
    _pageBannerController.dispose();
    _debouncer.cancel();
    _throttle.cancel();
    super.dispose();
  }

// #region Define data test
  final List<Widget> publicStoriesTwoRows = [
    SizedBox(
        child: Image.asset('assets/images/2x/image_4.png', fit: BoxFit.cover)),
    SizedBox(
        child: Image.asset('assets/images/2x/image_5.png', fit: BoxFit.cover)),
    SizedBox(
        child: Image.asset('assets/images/2x/image_3.png', fit: BoxFit.cover)),
    SizedBox(
        child: Image.asset('assets/images/2x/image_4.png', fit: BoxFit.cover)),
    SizedBox(
        child: Image.asset('assets/images/2x/image_3.png', fit: BoxFit.cover)),
    SizedBox(
        child: Image.asset('assets/images/2x/image_4.png', fit: BoxFit.cover))
  ];
  final List<Widget> publicData = [
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
  final List<Widget> imageBanners = [
    Image.asset('assets/images/2x/Banner_1.1.png'),
    Image.asset('assets/images/2x/Banner_2.png'),
    Image.asset('assets/images/2x/Banner_3.png')
  ];
  final List<ChapterInfo> chapterList = [
    ChapterInfo(
        chapterTitle: "Thần cấp đại ma đầu",
        minuteUpdated: 3,
        chapterNumber: 102),
    ChapterInfo(
        chapterTitle: "Thần cấp hệ thống", minuteUpdated: 4, chapterNumber: 99),
    ChapterInfo(
        chapterTitle: "Thần cấp đại ma đầu",
        minuteUpdated: 3,
        chapterNumber: 102),
    ChapterInfo(
        chapterTitle: "Thần cấp hệ thống", minuteUpdated: 4, chapterNumber: 99),
    ChapterInfo(
        chapterTitle: "Thần cấp đại ma đầu",
        minuteUpdated: 3,
        chapterNumber: 102),
    ChapterInfo(
        chapterTitle: "Thần cấp hệ thống", minuteUpdated: 4, chapterNumber: 99),
  ];
  late List<StoryModel> storiesTopCommon = [
    StoryModel(
        name: "Vũ luyện đỉnh phong",
        image: 'assets/images/2x/image_1.png',
        category: "Huyền huyễn",
        totalView: 1250),
    StoryModel(
        name: "Đế tôn",
        image: 'assets/images/2x/image_4.png',
        category: "Huyền huyễn",
        totalView: 1345),
    StoryModel(
        name: "Tiên nghịch",
        image: 'assets/images/2x/image_5.png',
        category: "Huyền huyễn",
        totalView: 1467),
    StoryModel(
        name: "Cầu ma",
        image: 'assets/images/2x/image_3.png',
        category: "Huyền huyễn",
        totalView: 99)
  ];
  final List<StoryModel> storiesIncludeAuthor = [
    StoryModel(
        image:
            'https://www.nae.vn/ttv/ttv/public/images/story/085339edd8d1f181ea709879862bebddf69e1f426809e10b9015359fa887bbba.jpg',
        name: 'Bách luyện thành tiên',
        category: 'Tiên hiệp',
        totalView: 16,
        authorName: 'Lão trư',
        numberOfChapter: 2560,
        lastUpdated: 22,
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
  ];
  // #endregion

// #region Define controller
  late TextEditingController _textSearchController;
  late ScrollController _scrollLayoutController;
  late PageController _pageEditorChoiceController;
  late PageController _pageNewStoriesController;
  late PageController _pageStoriesCompleteController;
  late PageController _pageBannerController;
  // #endregion

// #region Define variables
  var _itemHeight = 0.0;
  var _currentIndex = 0;
  var _isShowClearText = false;
  final _homePageItem = HomePageItems();
  final _debouncer = Debouncer(const Duration(milliseconds: 100));
  final _throttle = Throttle(const Duration(milliseconds: 100));
  // #endregion

// #region Define methods
  void _onChangedSearch(String textInput) {
    setState(() {
      _isShowClearText = textInput.isNotEmpty;
    });
  }

  void _scrollListener() {
    _debouncer(() {
      int firstVisibleIndex = _scrollLayoutController.hasClients
          ? (_scrollLayoutController.offset / _itemHeight).floor()
          : 0;

      setState(() {
        _currentIndex = firstVisibleIndex;
      });
    });
  }

  // #endregion
// #endregion
  @override
  Widget build(BuildContext context) {
    // #region get components
    var itemsOfHome = _homePageItem.getHomePageItems(
        _pageEditorChoiceController,
        publicData,
        publicStoriesTwoRows,
        publicStoriesTwoRows,
        _pageNewStoriesController,
        publicData,
        _pageStoriesCompleteController,
        publicData,
        _textSearchController,
        _onChangedSearch,
        _isShowClearText,
        _pageBannerController,
        imageBanners,
        chapterList,
        storiesTopCommon,
        numberOfBanner: 3);
    // #endregion
    return DefaultTabController(
      length: 5,
      child: Scaffold(
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
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // #region HomePage
                LayoutBuilder(
                  builder: (context, constraints) {
                    _itemHeight = constraints.maxHeight / itemsOfHome.length;
                    return RenderHomePage(
                        scrollLayoutController: _scrollLayoutController,
                        componentOfHomePage: itemsOfHome);
                  },
                ),
                // #endregion

                BookCase(
                  storiesData: storiesIncludeAuthor,
                ),
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.green,
                ),
                Container(
                  color: Colors.pink,
                ),
              ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: ColorDefaults.mainColor,
            child: Icon(
              Icons.arrow_right,
              size: MainSetting.getPercentageOfDevice(context, expectWidth: 50)
                  .width,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: TabBarCustom(context: context)),
    );
  }
}
