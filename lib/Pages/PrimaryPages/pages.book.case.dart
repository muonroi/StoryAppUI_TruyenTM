// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import '../../Items/Static/RenderData/PrimaryPages/Book_Case/widget.static.book.case.stories.items.dart';
import '../../Items/Static/RenderData/PrimaryPages/Book_Case/widget.static.model.book.case.stories.dart';
import '../../Settings/settings.language_code.vi..dart';
import '../../Settings/settings.main.dart';

class BookCase extends StatefulWidget {
  const BookCase({super.key, required this.storiesData});
  final List<StoryModel> storiesData;
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
  var _isShowClearText = false;
  void _onChangedSearch(String textInput) {
    setState(() {
      _isShowClearText = textInput.isNotEmpty;
    });
  }

  late TextEditingController _textSearchController;

  @override
  Widget build(BuildContext context) {
    List<Widget> dataEachRow = widget.storiesData
        .map((e) => StoriesBookCaseModelWidget(
              nameStory: e.name,
              categoryName: e.category!,
              authorName: e.authorName!,
              imageLink: e.image,
              tagsName: e.tagsName!,
              lastUpdated: e.lastUpdated!,
              totalViews: e.totalView!,
              numberOfChapter: e.numberOfChapter!,
            ))
        .toList();
    return DefaultTabController(
      length: 3,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Scaffold(
          backgroundColor: ColorDefaults.secondMainColor,
          appBar: AppBar(
            backgroundColor: ColorDefaults.lightAppColor,
            title: TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorDefaults.mainColor),
                tabs: [
                  Tab(text: L(ViCode.bookCaseTextInfo.toString())),
                  Tab(text: L(ViCode.storiesBoughtTextInfo.toString())),
                  Tab(text: L(ViCode.storiesSavedTextInfo.toString()))
                ]),
          ),
          body: TabBarView(children: [
            StoriesItems(
              storiesData: widget.storiesData,
              dataEachRow: dataEachRow,
              reload: _animationReloadController,
              sort: _animationSortController,
              isShowClearText: _isShowClearText,
              onChanged: _onChangedSearch,
              textSearchController: _textSearchController,
            ),
            StoriesItems(
              storiesData: widget.storiesData,
              dataEachRow: dataEachRow,
              reload: _animationReloadController,
              sort: _animationSortController,
              isShowClearText: _isShowClearText,
              onChanged: _onChangedSearch,
              textSearchController: _textSearchController,
            ),
            StoriesItems(
              storiesData: widget.storiesData,
              dataEachRow: dataEachRow,
              reload: _animationReloadController,
              sort: _animationSortController,
              isShowClearText: _isShowClearText,
              onChanged: _onChangedSearch,
              textSearchController: _textSearchController,
            ),
          ]),
        ),
      ),
    );
  }
}
