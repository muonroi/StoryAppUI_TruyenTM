import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'widget.static.custom.dashboard.chapter.bottom.dart';

class BottomChapterDetail extends StatefulWidget {
  final int chapterId;
  final void Function(int chapterId, bool isCheckShow) onLoading;
  final void Function(int chapterId) onRefresh;
  final Color backgroundColor;
  final Color fontColor;
  final bool isDisableNextButton;
  final bool isDisablePreviousButton;
  const BottomChapterDetail(
      {super.key,
      required this.chapterId,
      required this.onLoading,
      required this.onRefresh,
      required this.backgroundColor,
      required this.fontColor,
      required this.isDisableNextButton,
      required this.isDisablePreviousButton});

  @override
  State<BottomChapterDetail> createState() => _BottomChapterDetailState();
}

class _BottomChapterDetailState extends State<BottomChapterDetail> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: widget.backgroundColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: !widget.isDisablePreviousButton
                  ? () => widget.onRefresh(widget.chapterId)
                  : null,
              icon: Icon(
                Icons.arrow_circle_left_outlined,
                size:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 30)
                        .width,
                color: !widget.isDisablePreviousButton
                    ? widget.fontColor
                    : themeMode(context, ColorCode.disableColor.name),
              ),
            ),
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: !widget.isDisableNextButton
                  ? () => widget.onLoading(widget.chapterId, false)
                  : null,
              icon: Icon(
                Icons.arrow_circle_right_outlined,
                size:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 30)
                        .width,
                color: !widget.isDisableNextButton
                    ? themeMode(context, ColorCode.mainColor.name)
                    : themeMode(context, ColorCode.disableColor.name),
              ),
            ),
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: () {},
              icon: Icon(Icons.favorite_outline,
                  size: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 30)
                      .width,
                  color: widget.fontColor),
            ),
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: () {},
              icon: Icon(Icons.headphones_outlined,
                  size: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 30)
                      .width,
                  color: widget.fontColor),
            ),
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              color: widget.fontColor,
              onPressed: () => showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                context: context,
                builder: (BuildContext context) {
                  return const CustomDashboard();
                },
              ),
              icon: Icon(
                Icons.dashboard_customize_outlined,
                size:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 30)
                        .width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
