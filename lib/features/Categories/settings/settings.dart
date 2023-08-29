import 'package:flutter/material.dart';
import 'package:muonroi/shared/Settings/Enums/enum.search.story.dart';
import 'package:muonroi/features/Stories/data/models/models.stories.story.dart';
import 'package:muonroi/features/Stories/data/repositories/story_repository.dart';
import 'package:muonroi/features/Stories/presentation/pages/widget.static.stories.vertical.dart';

Widget showToolTipHaveAnimationStories(String message,
    {BuildContext? context, String? data}) {
  return Positioned.fill(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: context == null
            ? () {}
            : () async {
                List<StoryItems> storiesData =
                    await _handleSearchByCategory(data!, SearchType.category);
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoriesVerticalData(
                        isShowBack: true,
                        isShowLabel: false,
                        categoryId: int.parse(data),
                        stories: storiesData,
                      ),
                    ),
                  );
                }
              },
        child: Tooltip(
          onTriggered: () => TooltipTriggerMode.longPress,
          message: message,
          showDuration: const Duration(milliseconds: 1000),
        ),
      ),
    ),
  );
}

Future<List<StoryItems>> _handleSearchByCategory(
    String data, SearchType type) async {
  StoryRepository storyRepository = StoryRepository();
  var resultData = await storyRepository.searchStory([data], [type], 1, 15);
  return resultData.result.items;
}
