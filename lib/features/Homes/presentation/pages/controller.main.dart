import 'package:flutter/material.dart';
import 'package:muonroi/features/Homes/settings/settings.dart';
import 'package:muonroi/shared/static/buttons/widget.static.menu.bottom.shared.dart';
import 'package:muonroi/features/Homes/presentation/widgets/routes.items.home.dart';
import 'package:muonroi/shared/Settings/settings.colors.dart';
import 'package:muonroi/shared/Settings/settings.fonts.dart';
import 'package:muonroi/shared/Settings/settings.images.dart';
import 'package:muonroi/shared/Settings/settings.main.dart';
import 'package:muonroi/features/Accounts/data/models/models.account.signup.dart';
import 'package:muonroi/features/Chapters/data/models/models.chapters.list.chapter.dart';
import 'package:muonroi/features/Homes/presentation/pages/pages.book.case.dart';
import 'package:muonroi/features/Homes/presentation/pages/pages.home.dart';
import 'package:muonroi/features/Homes/presentation/pages/pages.stories.free.dart';
import 'package:muonroi/features/Homes/presentation/pages/pages.user.info.dart';
import 'package:muonroi/features/Stories/data/models/models.stories.story.dart';
import 'package:muonroi/features/Stories/presentation/pages/widget.static.model.stories.search.dart';

class MainPage extends StatefulWidget {
  const MainPage(
      {super.key,
      required this.storiesInit,
      required this.storiesEditorChoice,
      required this.storiesCommon});
  final List<StoryItems> storiesInit;
  final List<Widget> storiesEditorChoice;
  final List<Widget> storiesCommon;
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
      home: HomePage(
        storiesInit: widget.storiesInit,
        storiesCommon: widget.storiesCommon,
        storiesEditorChoice: widget.storiesEditorChoice,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<StoryItems> storiesInit;
  final List<Widget> storiesEditorChoice;
  final List<Widget> storiesCommon;
  const HomePage(
      {super.key,
      required this.storiesInit,
      required this.storiesEditorChoice,
      required this.storiesCommon});

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

  final List<Widget> imageBanners = [
    Image.asset('assets/images/2x/Banner_1.1.png'),
    Image.asset('assets/images/2x/Banner_2.png'),
    Image.asset('assets/images/2x/Banner_3.png')
  ];
  final List<ChapterInfo> chapterList = [];
  final AccountInfo accountInfo = AccountInfo(
      fullName: "John Wick",
      username: "muonroi",
      password: "12345678Az*",
      email: "contact.admin@muonroi.com",
      phoneNumber: "093.310.5367",
      gender: false,
      birthDate: DateTime(2002, 17, 06),
      imageLink: null,
      totalStoriesBought: 12,
      coin: 99);
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
        widget.storiesEditorChoice,
        widget.storiesCommon,
        widget.storiesCommon,
        _pageNewStoriesController,
        widget.storiesEditorChoice,
        _pageStoriesCompleteController,
        widget.storiesEditorChoice,
        _textSearchController,
        _onChangedSearch,
        _isShowClearText,
        _pageBannerController,
        imageBanners,
        chapterList,
        widget.storiesInit,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(
                              searchController: _textSearchController,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.search,
                          color: ColorDefaults.thirdMainColor))
                  : const IconButton(
                      onPressed: null,
                      icon: Icon(Icons.search,
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
                  storiesData: widget.storiesInit,
                ),
                Container(),
                const StoriesFree(
                  isShowLabel: false,
                  isShowBack: false,
                ),
                UserInfo(userInfo: accountInfo),
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
