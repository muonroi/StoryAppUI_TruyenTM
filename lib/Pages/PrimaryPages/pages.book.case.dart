// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/BookCase/widget.static.book.case.stories.items.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';

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
      unselectedLabelColor: ColorDefaults.secondMainColor,
      indicatorColor: ColorDefaults.thirdMainColor,
      tabs: [
        SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 70)
                .width,
            child: Tab(text: L(ViCode.bookCaseTextInfo.toString()))),
        SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 120)
                .width,
            child: Tab(text: L(ViCode.storiesBoughtTextInfo.toString()))),
        SizedBox(
            width: MainSetting.getPercentageOfDevice(context, expectWidth: 110)
                .width,
            child: Tab(text: L(ViCode.storiesSavedTextInfo.toString())))
      ],
    );
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorDefaults.lightAppColor,
        appBar: AppBar(
          backgroundColor: ColorDefaults.mainColor,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Material(
                color: ColorDefaults.mainColor,
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
