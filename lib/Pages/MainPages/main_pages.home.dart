import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muonroi/Models/Chapters/models.chapters.chapter.dart';
import 'package:muonroi/Pages/MainPages/book_page.user.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.images.dart';
import '../../Models/Stories/TopCommon/models.stories.topcommon.story.dart';
import '../../Settings/settings.main.dart';
import '../../Widget/Static/Buttons/widget.static.menu.bottom.shared.dart';
import '../../Widget/Static/RenderData/widget.static.items.home.dart';
import 'home_page.dart';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer(this.delay);

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }
}

class Throttle {
  final Duration delay;
  Timer? _timer;
  bool _canCall = true;

  Throttle(this.delay);

  void call(VoidCallback action) {
    if (_canCall) {
      _canCall = false;
      action();
      _timer = Timer(delay, () => _canCall = true);
    }
  }

  void cancel() {
    _timer?.cancel();
    _canCall = true;
  }
}

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
  late List<StoryTopCommon> storiesTopCommon = [
    StoryTopCommon(
        name: "Vũ luyện đỉnh phong",
        image: publicData[0],
        category: "Huyền huyễn",
        totalView: 1250),
    StoryTopCommon(
        name: "Đế tôn",
        image: publicData[1],
        category: "Huyền huyễn",
        totalView: 1345),
    StoryTopCommon(
        name: "Tiên nghịch",
        image: publicData[2],
        category: "Huyền huyễn",
        totalView: 1467),
    StoryTopCommon(
        name: "Cầu ma",
        image: publicData[3],
        category: "Huyền huyễn",
        totalView: 99)
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
  var components = HomePageItems();
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
    var componentOfHome = components.getHomePageItems(
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
          body: TabBarView(children: [
            // #region HomePage
            LayoutBuilder(
              builder: (context, constraints) {
                _itemHeight = constraints.maxHeight / componentOfHome.length;
                return RenderHomePage(
                    scrollLayoutController: _scrollLayoutController,
                    componentOfHomePage: componentOfHome);
              },
            ),
            // #endregion

            const RenderBookOfUser(),
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
