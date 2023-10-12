import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.images.dart';
import 'package:muonroi/shared/settings/settings.main.dart';

class NotificationItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String content;
  const NotificationItem(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.content});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  double widgetScale = 1.0;
  void _toggleItemState() {
    setState(() {
      widgetScale = 0.9;
    });
  }

  void _setDefaultItemState() {
    setState(() {
      widgetScale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _toggleItemState(),
      onTapUp: (_) => _setDefaultItemState(),
      onTapCancel: () => _setDefaultItemState(),
      child: Stack(children: [
        AnimatedContainer(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: themeMode(context, ColorCode.disableColor.name),
              boxShadow: [
                BoxShadow(
                    color: themeMode(context, ColorCode.disableColor.name),
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
                width:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 60)
                        .width,
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 100)
                    .height,
                child: netWorkImage(CustomImages.imageAvatarDefault, true),
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
        ),
        showToolTip(widget.title)
      ]),
    );
  }
}
