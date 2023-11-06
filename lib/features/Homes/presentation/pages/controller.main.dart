import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:muonroi/core/Notification/widget.notification.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signin.dart';
import 'package:muonroi/features/notification/presentation/pages/notification.dart';
import 'package:muonroi/features/notification/provider/notification.provider.dart';
import 'package:muonroi/shared/models/signalR/signalr.hub.dart';
import 'package:muonroi/shared/models/signalR/signalr.hub.stream.name.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/models/signalR/widget.notification.dart';
import 'package:muonroi/features/chapters/presentation/pages/widget.static.model.chapter.dart';
import 'package:muonroi/features/homes/settings/settings.dart';
import 'package:muonroi/features/story/data/models/models.single.story.dart';
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
import 'package:muonroi/features/story/data/models/models.stories.story.dart';
import 'package:muonroi/features/story/presentation/pages/widget.static.model.stories.search.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class MainPage extends StatefulWidget {
  const MainPage(
      {super.key,
      required this.storiesInit,
      required this.storiesEditorChoice,
      required this.storiesCommon,
      required this.accountResult});
  final List<StoryItems> storiesInit;
  final List<Widget> storiesEditorChoice;
  final List<Widget> storiesCommon;
  final AccountResult accountResult;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: themeMode(context, ColorCode.mainColor.name),
          fontFamily: CustomFonts.inter),
      home: HomePage(
        storiesInit: widget.storiesInit,
        storiesCommon: widget.storiesCommon,
        storiesEditorChoice: widget.storiesEditorChoice,
        accountResult: widget.accountResult,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<StoryItems> storiesInit;
  final List<Widget> storiesEditorChoice;
  final List<Widget> storiesCommon;
  final AccountResult accountResult;

  const HomePage(
      {super.key,
      required this.storiesInit,
      required this.storiesEditorChoice,
      required this.storiesCommon,
      required this.accountResult});

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
    initHubAndListenGlobalNotification();
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

  Future<void> startHub() async {
    await _hubConnection.start();
  }

  Future<void> initHubAndListenGlobalNotification() async {
    _hubConnection = HubConnectionBuilder()
        .withUrl(SignalrCentral.notificationListen,
            options: SignalrCentral.httpConnectionOptions)
        .withAutomaticReconnect(retryDelays: [30000]).build();
    _hubConnection.onclose(({error}) async {
      debugPrint("Connection ${SignalrCentral.notificationListen} Closed!");
      await _hubConnection.onreconnecting(({error}) {
        debugPrint("Re-Connecting ${SignalrCentral.notificationListen}!");
      });
      await _hubConnection.onreconnected(({connectionId}) {});
    });
    await startHub();
    if (_hubConnection.state == HubConnectionState.Connected) {
      _hubConnection.on(HubStream.receiveGlobalNotification.name, (arguments) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _totalNotification =
                _sharedPreferences.getInt('totalNotification') ?? 0;
            _totalNotification++;
            context.read<NotificationProvider>().setTotalView =
                _totalNotification;
            _sharedPreferences.setInt('totalNotification', _totalNotification);
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
        });
      });
      _hubConnection.on(HubStream.receiveNotificationByUser.name, (arguments) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _totalNotification =
                _sharedPreferences.getInt('totalNotification') ?? 0;
            _totalNotification++;

            context.read<NotificationProvider>().setTotalView =
                _totalNotification;
            _sharedPreferences.setInt('totalNotification', _totalNotification);
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
        });
      });
    } else if (_hubConnection.state == HubConnectionState.Disconnected) {
      startHub();
    }
  }
// #region Define data test

  final List<Widget> imageBanners = [
    Image.asset('assets/images/2x/Banner_1.1.png'),
    Image.asset('assets/images/2x/Banner_2.png'),
    Image.asset('assets/images/2x/Banner_3.png')
  ];
  final List<ChapterInfo> chapterList = [];
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
  late int _totalNotification = 0;
  late SharedPreferences _sharedPreferences;
  late HubConnection _hubConnection;
  // #endregion

// #region Define methods

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _totalNotification = _sharedPreferences.getInt('totalNotification') ?? 0;
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
          backgroundColor: themeMode(context, ColorCode.modeColor.name),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: Image.asset(CustomImages.mainLogo),
            backgroundColor: themeMode(context, ColorCode.modeColor.name),
            elevation: 0,
            actions: [
              _currentIndex > 0
                  ? IconButton(
                      splashRadius: 25.0,
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
                          color: themeMode(context, ColorCode.textColor.name)))
                  : IconButton(
                      onPressed: null,
                      icon: Icon(Icons.search,
                          color: themeMode(context, ColorCode.modeColor.name))),
              Stack(children: [
                IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const NotificationPage())),
                  icon: Icon(Icons.notifications_none,
                      color: themeMode(context, ColorCode.textColor.name)),
                  splashRadius: 22.0,
                ),
                Consumer<NotificationProvider>(
                  builder: (_, value, __) {
                    _totalNotification = value.totalNotification;

                    return Positioned(
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
                            color: themeMode(context, ColorCode.mainColor.name),
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(
                            _totalNotification <= 9
                                ? '$_totalNotification'
                                : '$_totalNotification+',
                            style: CustomFonts.h6(context),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                )
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
                const BookCase(),
                Container(),
                const StoriesFree(
                  isShowLabel: false,
                  isShowBack: false,
                ),
                UserInfo(
                    userInfo: AccountInfo(
                        userGuid: widget.accountResult.id,
                        fullName:
                            '${widget.accountResult.surname}${widget.accountResult.name}',
                        username: widget.accountResult.username,
                        email: widget.accountResult.email,
                        phoneNumber: widget.accountResult.phoneNumber,
                        birthDate: widget.accountResult.birthDate,
                        avatar: widget.accountResult.avatar,
                        totalStoriesBought: 12,
                        coin: 99)),
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
                    pageIndex: 1,
                    loadSingleChapter: false,
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
            backgroundColor: themeMode(context, ColorCode.mainColor.name),
            child: Icon(
              color: themeMode(context, ColorCode.textColor.name),
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
        duration: const Duration(seconds: 2),
        backgroundColor: themeMode(context, ColorCode.disableColor.name),
      ),
    );
  }
}
