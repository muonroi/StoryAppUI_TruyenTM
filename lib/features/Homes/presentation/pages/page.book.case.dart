import 'package:flutter/material.dart';
import 'package:muonroi/features/story/settings/enums/enum.story.user.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.book.case.stories.items.dart';

class BookCase extends StatefulWidget {
  const BookCase({super.key});
  @override
  State<BookCase> createState() => _BookCaseState();
}

class _BookCaseState extends State<BookCase> with TickerProviderStateMixin {
  @override
  void initState() {
    _textSearchController = TextEditingController();
    _animationReloadController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        upperBound: 1.0);
    _animationSortController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        upperBound: 0.5);
    super.initState();
  }

  @override
  void dispose() {
    _textSearchController.dispose();
    _animationReloadController.dispose();
    _animationSortController.dispose();
    super.dispose();
  }

  late AnimationController _animationReloadController;
  late AnimationController _animationSortController;
  late TextEditingController _textSearchController;

  @override
  Widget build(BuildContext context) {
    TabBar tabBar = TabBar(
      unselectedLabelColor: themeMode(context, ColorCode.modeColor.name),
      indicatorColor: themeMode(context, ColorCode.textColor.name),
      tabs: [
        SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 70)
                .width,
            child: Tab(
                text: L(
                    context, LanguageCodes.recentStoriesTextInfo.toString()))),
        SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 120)
                .width,
            child: Tab(
                text:
                    L(context, LanguageCodes.savedStoriesTextInfo.toString()))),
        SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 110)
                .width,
            child: Tab(
                text: L(
                    context, LanguageCodes.bookmarkStoriesTextInfo.toString())))
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
        body: TabBarView(children: [
          StoriesItems(
            reload: _animationReloadController,
            sort: _animationSortController,
            textSearchController: _textSearchController,
            storiesTypes: StoryForUserType.recent,
          ),
          StoriesItems(
            reload: _animationReloadController,
            sort: _animationSortController,
            textSearchController: _textSearchController,
            storiesTypes: StoryForUserType.download,
          ),
          StoriesItems(
            reload: _animationReloadController,
            sort: _animationSortController,
            textSearchController: _textSearchController,
            storiesTypes: StoryForUserType.bookmark,
          ),
        ]),
      ),
    );
  }
}
