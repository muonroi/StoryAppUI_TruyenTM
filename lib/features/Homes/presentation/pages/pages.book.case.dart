import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/core/localization/settings.language_code.vi..dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.book.case.stories.items.dart';
import 'package:muonroi/features/stories/data/models/models.stories.story.dart';

class BookCase extends StatefulWidget {
  const BookCase({super.key, required this.storiesData});
  final List<StoryItems> storiesData;
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
      unselectedLabelColor: themMode(context, ColorCode.modeColor.name),
      indicatorColor: themMode(context, ColorCode.textColor.name),
      tabs: [
        SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 70)
                .width,
            child: Tab(text: L(context, ViCode.bookCaseTextInfo.toString()))),
        SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 120)
                .width,
            child:
                Tab(text: L(context, ViCode.storiesBoughtTextInfo.toString()))),
        SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 110)
                .width,
            child:
                Tab(text: L(context, ViCode.storiesSavedTextInfo.toString())))
      ],
    );
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: themMode(context, ColorCode.modeColor.name),
        appBar: AppBar(
          backgroundColor: themMode(context, ColorCode.mainColor.name),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Material(
                color: themMode(context, ColorCode.mainColor.name),
                child: tabBar,
              )),
        ),
        body: TabBarView(children: [
          StoriesItems(
            storiesData: widget.storiesData,
            reload: _animationReloadController,
            sort: _animationSortController,
            textSearchController: _textSearchController,
          ),
          StoriesItems(
            storiesData: widget.storiesData,
            reload: _animationReloadController,
            sort: _animationSortController,
            textSearchController: _textSearchController,
          ),
          StoriesItems(
            storiesData: widget.storiesData,
            reload: _animationReloadController,
            sort: _animationSortController,
            textSearchController: _textSearchController,
          ),
        ]),
      ),
    );
  }
}
