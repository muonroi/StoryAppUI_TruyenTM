import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.common.stories.home.dart';
import 'package:muonroi/features/story/settings/enums/enum.stories.common.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.main.dart';

class FilterByDateButton extends StatelessWidget {
  const FilterByDateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabBar tabBar = TabBar(
      unselectedLabelColor: themeMode(context, ColorCode.modeColor.name),
      indicatorColor: themeMode(context, ColorCode.textColor.name),
      tabs: [
        SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 120)
                .width,
            child: Tab(
                text: L(context,
                    LanguageCodes.commonStoriesOfDayTextInfo.toString()))),
        SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 110)
                .width,
            child: Tab(
                text: L(context,
                    LanguageCodes.commonStoriesOfWeekTextInfo.toString()))),
        SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 110)
                .width,
            child: Tab(
                text: L(context,
                    LanguageCodes.commonStoriesOfMonthTextInfo.toString())))
      ],
    );
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: themeMode(context, ColorCode.modeColor.name),
        appBar: AppBar(
          backgroundColor: themeMode(context, ColorCode.mainColor.name),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Material(
                color: themeMode(context, ColorCode.mainColor.name),
                child: tabBar,
              )),
        ),
        body: const TabBarView(children: [
          CommonTopStoriesData(type: EnumStoriesCommon.day),
          CommonTopStoriesData(type: EnumStoriesCommon.week),
          CommonTopStoriesData(type: EnumStoriesCommon.month),
        ]),
      ),
    );
  }
}
