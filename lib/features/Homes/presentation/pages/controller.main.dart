import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:muonroi/core/Notification/widget.notification.dart';
import 'package:muonroi/shared/models/signalR/signalr.hub.dart';
import 'package:muonroi/shared/models/signalR/signalr.hub.stream.name.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/models/signalR/widget.notification.dart';
import 'package:muonroi/features/chapters/presentation/pages/widget.static.model.chapter.dart';
import 'package:muonroi/features/homes/settings/settings.dart';
import 'package:muonroi/features/stories/data/models/models.single.story.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/static/buttons/widget.static.menu.bottom.shared.dart';
import 'package:muonroi/features/homes/presentation/widgets/routes.items.home.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.images.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signup.dart';
import 'package:muonroi/features/chapters/data/models/models.chapters.list.chapter.dart';
import 'package:muonroi/features/homes/presentation/pages/pages.book.case.dart';
import 'package:muonroi/features/homes/presentation/pages/pages.home.dart';
import 'package:muonroi/features/homes/presentation/pages/pages.stories.free.dart';
import 'package:muonroi/features/homes/presentation/pages/pages.user.info.dart';
import 'package:muonroi/features/stories/data/models/models.stories.story.dart';
import 'package:muonroi/features/stories/presentation/pages/widget.static.model.stories.search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

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
  void initState() {
    initHubAndListenGlobalNotification();
    super.initState();
  }

  Future<void> initHubAndListenGlobalNotification() async {
    final hubConnection = HubConnectionBuilder()
        .withUrl(SignalrCentral.notificationListen,
            options: SignalrCentral.httpConnectionOptions)
        .build();
    hubConnection.onclose(({error}) async {
      print("Connection ${SignalrCentral.notificationListen} Closed!");
      await hubConnection.onreconnecting(({error}) {
        print("Re-Connecting ${SignalrCentral.notificationListen}!");
      });
    });
    await hubConnection.start();
    if (hubConnection.state == HubConnectionState.Connected) {
      hubConnection.on(HubStream.ReceiveGlobalNotification.name, (arguments) {
        print(arguments);
        var notifyInfo = (json.decode(arguments.toString()) as List)
            .map((data) => NotificationSignalr.fromJson(data))
            .toList()
            .first;
        NotificationPush.showNotification(
            title: L(context,
                LanguageCodes.notificationTextConfigTextInfo.toString()),
            body: N(context, notifyInfo.type,
                args: notifyInfo.notificationContent.split('-')),
            fln: flutterLocalNotificationsPlugin);
      });
      hubConnection.on(HubStream.ReceiveNotificationByUser.name, (arguments) {
        print(arguments);
        var notifyInfo = (json.decode(arguments.toString()) as List)
            .map((data) => NotificationSignalr.fromJson(data))
            .toList()
            .first;
        NotificationPush.showNotification(
            title: L(context,
                LanguageCodes.notificationTextConfigTextInfo.toString()),
            body: N(context, notifyInfo.type,
                args: notifyInfo.notificationContent.split('-')),
            fln: flutterLocalNotificationsPlugin);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: themMode(context, ColorCode.mainColor.name),
          fontFamily: CustomFonts.inter),
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
    _initSharedPreferences();
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
  late BuildContext context;
  // #endregion

// #region Define variables
  var _itemHeight = 0.0;
  var _currentIndex = 0;
  var _isShowClearText = false;
  final _homePageItem = HomePageItems();
  final _debouncer = Debouncer(const Duration(milliseconds: 100));
  final _throttle = Throttle(const Duration(milliseconds: 100));
  var _totalNotification = 0;
  late SharedPreferences _sharedPreferences;
  // #endregion

// #region Define methods

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

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
        context,
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
          backgroundColor: themMode(context, ColorCode.modeColor.name),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: Image.asset(CustomImages.mainLogo),
            backgroundColor: themMode(context, ColorCode.modeColor.name),
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
                      icon: Icon(Icons.search,
                          color: themMode(context, ColorCode.textColor.name)))
                  : IconButton(
                      onPressed: null,
                      icon: Icon(Icons.search,
                          color: themMode(context, ColorCode.modeColor.name))),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.chat_outlined,
                      color: themMode(context, ColorCode.textColor.name))),
              Stack(children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_none,
                      color: themMode(context, ColorCode.textColor.name)),
                  splashRadius: 25,
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: MainSetting.getPercentageOfDevice(context,
                              expectWidth: 20)
                          .width,
                      height: MainSetting.getPercentageOfDevice(context,
                              expectHeight: 20)
                          .height,
                      decoration: BoxDecoration(
                          color: themMode(context, ColorCode.mainColor.name),
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Text(
                          '$_totalNotification+',
                          style: CustomFonts.h6(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ))
              ]),
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
            onPressed: () {
              var storyInfoRecently =
                  _sharedPreferences.getString("recently-story");
              var chapterIdRecently =
                  _sharedPreferences.getInt("recently-chapterId") ?? 0;
              if (storyInfoRecently != null) {
                var storyResult = singleStoryModelFromJson(storyInfoRecently);
                var storyInfo = storyResult.result;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Chapter(
                    isLoadHistory: true,
                    storyId: storyInfo.id,
                    storyName: storyInfo.storyTitle,
                    chapterId: chapterIdRecently == 0
                        ? storyInfo.firstChapterId
                        : chapterIdRecently,
                    lastChapterId: storyInfo.lastChapterId,
                    firstChapterId: storyInfo.firstChapterId,
                  );
                }));
              } else {
                _showTooltipNotification(context);
              }
            },
            backgroundColor: themMode(context, ColorCode.mainColor.name),
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

  void _showTooltipNotification(BuildContext context) {
    final tooltip = Tooltip(
        message: L(context, LanguageCodes.recentlyStoryTextInfo.toString()),
        child: Text(
          L(context, LanguageCodes.recentlyStoryTextInfo.toString()),
          style: CustomFonts.h5(context),
          textAlign: TextAlign.center,
        ));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: tooltip,
        duration: Duration(seconds: 2),
        backgroundColor: themMode(context, ColorCode.disableColor.name),
      ),
    );
  }
}
