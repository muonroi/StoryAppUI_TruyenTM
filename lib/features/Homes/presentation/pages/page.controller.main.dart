import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:muonroi/core/Notification/widget.notification.dart';
import 'package:muonroi/core/authorization/enums/key.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signin.dart';
import 'package:muonroi/features/notification/presentation/pages/page.notification.dart';
import 'package:muonroi/features/notification/provider/provider.notification.dart';
import 'package:muonroi/features/story/data/models/model.recent.story.dart';
import 'package:muonroi/shared/models/signalR/signalr.hub.stream.name.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/models/signalR/widget.notification.dart';
import 'package:muonroi/features/chapters/presentation/pages/page.model.chapter.dart';
import 'package:muonroi/features/homes/settings/settings.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/static/buttons/widget.static.menu.bottom.shared.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.routes.items.home.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.images.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signup.dart';
import 'package:muonroi/features/homes/presentation/pages/page.book.case.dart';
import 'package:muonroi/features/homes/presentation/pages/page.home.dart';
import 'package:muonroi/features/homes/presentation/pages/page.stories.free.dart';
import 'package:muonroi/features/homes/presentation/pages/page.user.info.dart';
import 'package:muonroi/features/story/presentation/pages/page.model.stories.search.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:sprintf/sprintf.dart';

class HomePage extends StatefulWidget {
  final AccountResult accountResult;
  final List<String> bannerUrl;
  const HomePage(
      {super.key, required this.accountResult, required this.bannerUrl});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _totalNotification = widget.accountResult.notificationNumber;
    _isFirstLoad = true;
    _isHubInitialized = false;
    _textSearchController = TextEditingController();
    _scrollLayoutController = ScrollController();
    _scrollLayoutController.addListener(_scrollListener);
    _pageEditorChoiceController = PageController(viewportFraction: 0.9);
    _pageStoriesCompleteController = PageController(viewportFraction: 0.9);
    _pageNewStoriesController = PageController(viewportFraction: 0.9);
    _pageBannerController = PageController(initialPage: 0);
    _itemHeight = 0.0;
    _currentIndex = 0;
    _isShowClearText = false;
    _homePageItem = HomePageItems();
    _throttle = Throttle(const Duration(milliseconds: 100));
    _debouncer = Debouncer(const Duration(milliseconds: 100));
    _initSharedPreferences()
        .then((value) => initHubAndListenGlobalNotification());
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
    debugPrint("Connected");
  }

  Future<void> initHubAndListenGlobalNotification() async {
    _hubConnection = HubConnectionBuilder()
        .withUrl(sprintf(ApiNetwork.baseUrl + ApiNetwork.notification,
            [_sharedPreferences.getString(KeyToken.accessToken.name)]))
        .withAutomaticReconnect(retryDelays: [30000]).build();

    _hubConnection.onclose(({error}) async {
      debugPrint("Connection Closed!");
      await _hubConnection.onreconnecting(({error}) async {
        await reNewAccessToken();
      });
      await _hubConnection.onreconnected(({connectionId}) {});
    });
    await startHub();
    setState(() {
      _isHubInitialized = true;
    });
  }

// #region Define controller
  late TextEditingController _textSearchController;
  late ScrollController _scrollLayoutController;
  late PageController _pageEditorChoiceController;
  late PageController _pageNewStoriesController;
  late PageController _pageStoriesCompleteController;
  late PageController _pageBannerController;
  // #endregion

// #region Define variables
  late bool _isHubInitialized;
  late bool _isFirstLoad;
  late double _itemHeight;
  late double _currentIndex;
  late bool _isShowClearText;
  late HomePageItems _homePageItem;
  late Debouncer _debouncer;
  late Throttle _throttle;
  late int _totalNotification;
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
        _currentIndex = double.parse(firstVisibleIndex.toString());
      });
    });
  }

  // #endregion
  @override
  Widget build(BuildContext context) {
    // #region get components
    var itemsOfHome = _homePageItem.getHomePageItems(
        context,
        _pageEditorChoiceController,
        _pageNewStoriesController,
        _pageStoriesCompleteController,
        _textSearchController,
        _onChangedSearch,
        _isShowClearText,
        _pageBannerController,
        widget.bannerUrl,
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
                    if (_isFirstLoad && _isHubInitialized) {
                      _isFirstLoad = false;
                      if (_hubConnection.state ==
                          HubConnectionState.Connected) {
                        _hubConnection
                            .on(HubStream.receiveGlobalNotification.name,
                                (arguments) {
                          _totalNotification++;
                          value.setTotalView = _totalNotification;
                          var notifyInfo = (json.decode(arguments.toString())
                                  as List)
                              .map((data) => NotificationSignalr.fromJson(data))
                              .toList()
                              .first;
                          NotificationPush.showNotification(
                              title: L(
                                  context,
                                  LanguageCodes.notificationTextConfigTextInfo
                                      .toString()),
                              body: N(context, notifyInfo.type,
                                  args: notifyInfo.notificationContent
                                      .split('-')),
                              fln: flutterLocalNotificationsPlugin);
                        });
                        _hubConnection
                            .on(HubStream.receiveNotificationByUser.name,
                                (arguments) {
                          _totalNotification++;
                          value.setTotalView = _totalNotification;
                          var notifyInfo = (json.decode(arguments.toString())
                                  as List)
                              .map((data) => NotificationSignalr.fromJson(data))
                              .toList()
                              .first;
                          NotificationPush.showNotification(
                              title: L(
                                  context,
                                  LanguageCodes.notificationTextConfigTextInfo
                                      .toString()),
                              body: N(context, notifyInfo.type,
                                  args: notifyInfo.notificationContent
                                      .split('-')),
                              fln: flutterLocalNotificationsPlugin);
                        });
                      } else if (_hubConnection.state ==
                          HubConnectionState.Disconnected) {
                        startHub();
                      }
                    }
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
                var storyResult = recentStoryModelFromJson(storyInfoRecently);
                var storyInfo = storyResult;
                var chapterNumber = _sharedPreferences
                        .getInt("story-${storyInfo.storyId}-current-chapter") ??
                    1;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Chapter(
                    chapterNumber: chapterNumber,
                    totalChapter: storyInfo.totalChapter,
                    pageIndex: 1,
                    loadSingleChapter: false,
                    isLoadHistory: true,
                    storyId: storyInfo.storyId,
                    storyName: storyInfo.storyName,
                    chapterId: chapterIdRecently == 0
                        ? storyInfo.firstChapterId
                        : chapterIdRecently,
                    lastChapterId: storyInfo.lastChapterId,
                    firstChapterId: storyInfo.firstChapterId,
                  );
                }));
              } else {
                showTooltipNotification(context);
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
}
