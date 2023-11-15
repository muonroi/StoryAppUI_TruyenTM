import 'package:flutter/material.dart';
import 'package:muonroi/features/story/data/models/model.stories.story.dart';
import 'package:muonroi/features/story/data/repositories/story.repository.dart';
import 'package:muonroi/features/story/presentation/pages/page.stories.detail.dart';
import 'package:muonroi/shared/settings/enums/enum.search.story.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class SearchPage extends StatefulWidget {
  final TextEditingController searchController;
  const SearchPage({super.key, required this.searchController});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  bool isShowClearText = false;
  StoryRepository storyRepository = StoryRepository();
  List<StoryItems> storiesSearch = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            splashRadius: 25,
            color: themeMode(context, ColorCode.textColor.name),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: backButtonCommon(context)),
        backgroundColor: themeMode(context, ColorCode.modeColor.name),
        elevation: 0,
        iconTheme: IconThemeData(
          color: themeMode(context, ColorCode.textColor.name),
        ),
        centerTitle: true,
        title: TextField(
          controller: widget.searchController,
          onChanged: (value) => {
            if (context.mounted)
              {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  await _handleSearch(value);
                })
              }
          },
          maxLines: 1,
          minLines: 1,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8.0),
              hintMaxLines: 1,
              hintText: L(context, LanguageCodes.searchTextInfo.toString()),
              hintStyle: TextStyle(
                  color: themeMode(context, ColorCode.textColor.name)),
              focusColor: themeMode(context, ColorCode.textColor.name),
              suffixIcon: Visibility(
                visible: isShowClearText,
                child: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: themeMode(context, ColorCode.textColor.name),
                  ),
                  onPressed: () {
                    setState(() {
                      isShowClearText = false;
                    });
                    widget.searchController.clear();
                  },
                ),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: themeMode(context, ColorCode.textColor.name),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
          style: TextStyle(color: themeMode(context, ColorCode.textColor.name)),
        ),
      ),
      body: Container(
        color: themeMode(context, ColorCode.modeColor.name),
        child: Column(
          children: [
            Expanded(
              child: storiesSearch.isNotEmpty
                  ? ListView.builder(
                      itemCount: storiesSearch.length,
                      itemBuilder: (context, index) => Container(
                        color: themeMode(context, ColorCode.modeColor.name),
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoryDetail(
                                          storyId: storiesSearch[index].id,
                                          storyTitle:
                                              storiesSearch[index].storyTitle,
                                        )));
                          },
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                width: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectWidth: 60)
                                    .width,
                                height: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectHeight: 100)
                                    .height,
                                child: netWorkImage(
                                    context, storiesSearch[index].imgUrl, true,
                                    isSize: true, width: 60, height: 100),
                              ),
                            ),
                            title: Text(
                              storiesSearch[index].storyTitle,
                              style: TextStyle(
                                  color: themeMode(
                                      context, ColorCode.textColor.name)),
                            ),
                          ),
                        ),
                      ),
                    )
                  : getEmptyData(context),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _handleSearch(String value) async {
    final isInputNotEmpty = value.isNotEmpty;
    List<StoryItems> searchedStories = [];

    if (isInputNotEmpty) {
      var resultData =
          await storyRepository.searchStory([value], [SearchType.title], 1, 15);
      searchedStories = resultData.result.items;
    }

    setState(() {
      isShowClearText = isInputNotEmpty;
      storiesSearch = searchedStories;
    });
  }
}
