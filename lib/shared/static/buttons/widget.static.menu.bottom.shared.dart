import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.images.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class TabBarCustom extends StatefulWidget {
  final BuildContext context;
  const TabBarCustom({super.key, required this.context});

  @override
  State<TabBarCustom> createState() => _TabBarCustomState();
}

class _TabBarCustomState extends State<TabBarCustom> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height:
          MainSetting.getPercentageOfDevice(context, expectHeight: 62).height,
      color: themeMode(context, ColorCode.modeColor.name),
      shape: const CircularNotchedRectangle(),
      child: TabBar(
        isScrollable: false,
        unselectedLabelColor: themeMode(context, ColorCode.disableColor.name),
        indicatorColor: themeMode(context, ColorCode.mainColor.name),
        labelColor: themeMode(context, ColorCode.mainColor.name),
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        tabs: [
          Tab(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0
                  ? themeMode(context, ColorCode.mainColor.name)
                  : themeMode(context, ColorCode.textColor.name),
              size: MainSetting.getPercentageOfDevice(context, expectWidth: 26)
                  .width,
            ),
          ),
          Tab(
            icon: SizedBox(
              width: MainSetting.getPercentageOfDevice(context, expectWidth: 26)
                  .width,
              height:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 26)
                      .width,
              child: Image.asset(CustomImages.bookBookmark2x,
                  color: _currentIndex == 1
                      ? themeMode(context, ColorCode.mainColor.name)
                      : themeMode(context, ColorCode.textColor.name),
                  fit: BoxFit.cover),
            ),
          ),
          const Row(
            children: [
              Spacer(),
            ],
          ),
          Tab(
            icon: SizedBox(
              width: MainSetting.getPercentageOfDevice(context, expectWidth: 26)
                  .width,
              height:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 26)
                      .width,
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      _currentIndex == 3
                          ? themeMode(context, ColorCode.mainColor.name)
                          : themeMode(context, ColorCode.textColor.name),
                      BlendMode.srcIn),
                  child: Image.asset(
                    CustomImages.freeBook2x,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Tab(
              icon: SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 26)
                .width,
            height: MainSetting.getPercentageOfDevice(context, expectWidth: 26)
                .width,
            child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    _currentIndex == 4
                        ? themeMode(context, ColorCode.mainColor.name)
                        : themeMode(context, ColorCode.textColor.name),
                    BlendMode.srcIn),
                child: Image.asset(
                  CustomImages.userInfo2x,
                  fit: BoxFit.cover,
                )),
          )),
        ],
      ),
    );
  }
}
