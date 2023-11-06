import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/notification/bloc/notification/notification_bloc.dart';
import 'package:muonroi/features/notification/data/repository/notification.repository.dart';
import 'package:muonroi/features/notification/presentation/widgets/widget.notification.item.dart';
import 'package:muonroi/features/notification/provider/notification.provider.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    _notificationBloc = NotificationBloc(pageIndex: 1, pageSize: 10);
    _isPrevious = false;
    _notificationBloc
        .add(GetNotificationEventList(false, isPrevious: _isPrevious));
    _refreshController = RefreshController(initialRefresh: false);
    countLoadMore = 0;
    _scrollController = ScrollController();
    _scrollController.addListener(loadMore);
    _notificationRepository = NotificationRepository();
    _initSharedPreferences();
    super.initState();
  }

  @override
  void dispose() {
    _notificationBloc.close();
    _refreshController.dispose();
    super.dispose();
  }

  void loadMore() {
    if (context.mounted) {
      if (_scrollController.hasClients &&
          _scrollController.position.atEdge &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          countLoadMore == 1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _notificationBloc
                .add(const GetNotificationEventList(false, isPrevious: false));
            countLoadMore = 0;
          });
        });
      } else if (_scrollController.position.atEdge &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          countLoadMore < 1) {
        countLoadMore++;
      }
    }
  }

  void _onRefresh() async {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _notificationBloc
              .add(const GetNotificationEventList(false, isPrevious: true));
        });
      });
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    }
    _refreshController.loadComplete();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  late SharedPreferences _sharedPreferences;
  late ScrollController _scrollController;
  late NotificationBloc _notificationBloc;
  late bool _isPrevious;
  late RefreshController _refreshController;
  late int countLoadMore;
  late NotificationRepository _notificationRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeMode(context, ColorCode.modeColor.name),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: themeMode(context, ColorCode.textColor.name),
        ),
        backgroundColor: themeMode(context, ColorCode.mainColor.name),
        elevation: 0,
        title: Text(
          L(context, LanguageCodes.notificationTextInfo.toString()),
          style: CustomFonts.h4(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: BlocProvider(
            create: (context) => _notificationBloc,
            child: BlocListener<NotificationBloc, NotificationState>(
              listener: (context, state) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              },
              child: BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is NotificationLoadedState) {
                    var notificationList =
                        state.notificationSingleUser.result.items;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (context.mounted) {
                        var totalViewSent = notificationList
                            .where((element) => element.notificationSate == 1)
                            .length;
                        context.read<NotificationProvider>().setTotalView =
                            totalViewSent;
                        _sharedPreferences.setInt(
                            'totalNotification', totalViewSent);
                      }
                    });

                    return SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      footer: ClassicFooter(
                        canLoadingIcon: const Icon(Icons.arrow_downward),
                        canLoadingText: L(
                            context,
                            LanguageCodes.viewNextNotificationTextInfo
                                .toString()),
                        idleText: L(
                            context,
                            LanguageCodes.viewNextNotificationTextInfo
                                .toString()),
                      ),
                      header: ClassicHeader(
                        idleIcon: const Icon(Icons.arrow_upward),
                        refreshingText: L(
                            context,
                            LanguageCodes.viewPreviousNotificationTextInfo
                                .toString()),
                        releaseText: L(
                            context,
                            LanguageCodes.viewPreviousNotificationTextInfo
                                .toString()),
                        idleText: L(
                            context,
                            LanguageCodes.viewPreviousNotificationTextInfo
                                .toString()),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                IconButton(
                                  splashRadius: 25,
                                  tooltip: L(
                                      context,
                                      LanguageCodes.viewNotificationAllTextInfo
                                          .toString()),
                                  onPressed: () async {
                                    await _notificationRepository
                                        .viewAllNotificationUser();
                                    if (context.mounted) {
                                      context
                                          .read<NotificationProvider>()
                                          .setViewAll = true;
                                      context
                                          .read<NotificationProvider>()
                                          .setTotalView = 0;
                                      _sharedPreferences.setInt(
                                          'totalNotification', 0);
                                    }
                                  },
                                  icon: const Icon(Icons.clear_all_outlined),
                                  color: themeMode(
                                      context, ColorCode.textColor.name),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: notificationList.isNotEmpty
                                ? ListView.builder(
                                    controller: _scrollController,
                                    itemCount: notificationList.length,
                                    itemBuilder: (context, index) {
                                      return NotificationItem(
                                          notificationId:
                                              notificationList[index].id,
                                          state: notificationList[index]
                                                  .notificationSate ==
                                              1,
                                          imageUrl:
                                              notificationList[index].imgUrl,
                                          title: notificationList[index].title,
                                          content: N(
                                              context,
                                              notificationList[index]
                                                  .notificationType,
                                              args: notificationList[index]
                                                  .message
                                                  .split('-')));
                                    })
                                : getEmptyData(context),
                          )
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ))
        ],
      ),
    );
  }
}
