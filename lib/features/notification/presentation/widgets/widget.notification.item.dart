import 'package:flutter/material.dart';
import 'package:muonroi/features/notification/data/repository/notification.repository.dart';
import 'package:muonroi/features/notification/provider/notification.provider.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:provider/provider.dart';

class NotificationItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String content;
  final bool state;
  final int notificationId;
  final int currentNotificationSent;
  const NotificationItem(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.content,
      required this.state,
      required this.notificationId,
      required this.currentNotificationSent});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  void initState() {
    _notificationRepository = NotificationRepository();
    _currentView = widget.currentNotificationSent;
    super.initState();
    _notificationSeen = [];
    if (widget.state) {
      _notificationSeen.add(widget.notificationId);
    }
  }

  double widgetScale = 1.0;
  void _toggleItemState() {
    setState(() {
      widgetScale = 0.9;
    });
  }

  late NotificationRepository _notificationRepository;
  late List<int> _notificationSeen;
  late int _currentView;
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder:
          (BuildContext context, NotificationProvider value, Widget? child) {
        return GestureDetector(
          onTapDown: (_) => _toggleItemState(),
          onTapUp: (_) {
            value.setTotalView = _currentView - 1;
            setState(() {
              widgetScale = 1.0;
              if (_notificationSeen.contains(widget.notificationId)) {
                _notificationSeen.remove(widget.notificationId);
                _notificationRepository
                    .viewSingleNotificationUser(widget.notificationId);
              }
            });
          },
          onTapCancel: () {
            value.setTotalView = _currentView - 1;
            setState(() {
              widgetScale = 1.0;
              if (_notificationSeen.contains(widget.notificationId)) {
                _notificationSeen.remove(widget.notificationId);
                _notificationRepository
                    .viewSingleNotificationUser(widget.notificationId);
              }
            });
          },
          child: Stack(children: [
            Consumer<NotificationProvider>(
              builder: (_, value, __) {
                bool isViewAll = value.isViewAll;
                return AnimatedContainer(
                  decoration: BoxDecoration(
                      border: isViewAll
                          ? null
                          : _notificationSeen.contains(widget.notificationId)
                              ? Border.all(
                                  color: themeMode(
                                      context, ColorCode.mainColor.name))
                              : null,
                      borderRadius: BorderRadius.circular(12.0),
                      color: themeMode(context, ColorCode.disableColor.name),
                      boxShadow: [
                        BoxShadow(
                            color:
                                themeMode(context, ColorCode.disableColor.name),
                            offset: const Offset(-3, 3),
                            blurRadius: 0.5)
                      ]),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutSine,
                  transform: Matrix4.diagonal3Values(
                    widgetScale,
                    widgetScale,
                    1.0,
                  ),
                  margin: const EdgeInsets.all(12.0),
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: MainSetting.getPercentageOfDevice(context,
                                expectWidth: 100)
                            .width,
                        height: MainSetting.getPercentageOfDevice(context,
                                expectHeight: 150)
                            .height,
                        child: netWorkImage(context, widget.imageUrl, true),
                      ),
                    ),
                    title: Text(
                      widget.title,
                      style: CustomFonts.h5(context)
                          .copyWith(fontSize: 19, fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      widget.content,
                      style: CustomFonts.h5(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
            showToolTip(widget.content)
          ]),
        );
      },
    );
  }
}
