import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/chapters/presentation/pages/page.model.list.chapter.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.chapter.appbar.detail.action.dart';
import 'package:muonroi/features/story/presentation/pages/page.stories.detail.dart';
import 'package:muonroi/features/story/presentation/pages/page.stories.download.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.template.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class MenuDetailAppbar extends StatefulWidget {
  final String author;
  final int storyId;
  final String storyName;
  final int chapterId;
  final int lastChapterId;
  final int firstChapterId;
  final bool isLoadHistory;
  final int pageIndex;
  final int totalChapter;
  final int chapterNumber;
  final String imageUrl;
  final ChapterTemplate settingConfig;
  const MenuDetailAppbar(
      {super.key,
      required this.author,
      required this.storyId,
      required this.storyName,
      required this.chapterId,
      required this.lastChapterId,
      required this.firstChapterId,
      required this.isLoadHistory,
      required this.pageIndex,
      required this.totalChapter,
      required this.chapterNumber,
      required this.imageUrl,
      required this.settingConfig});

  @override
  State<MenuDetailAppbar> createState() => _MenuDetailAppbarState();
}

class _MenuDetailAppbarState extends State<MenuDetailAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ChapterIconAction(
            oneIconText:
                L(context, LanguageCodes.chapterListConfigTextInfo.toString()),
            twoIconText:
                L(context, LanguageCodes.storyDetailConfigTextInfo.toString()),
            threeIconText: L(
                context, LanguageCodes.storyDownloadConfigTextInfo.toString()),
            iconTwo: Icons.book,
            iconThree: Icons.download,
            iconOne: Icons.list,
            oneIcon: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ChapterListPage(
                          author: widget.author,
                          chapterCallback: null,
                          isAudio: false,
                          storyImageUrl: widget.imageUrl,
                          totalChapter: widget.totalChapter,
                          storyId: widget.storyId,
                          lastChapterId: widget.lastChapterId,
                          firstChapterId: widget.firstChapterId,
                          storyTitle: widget.storyName,
                        ))),
            oneIconColor: widget.settingConfig.font,
            twoIcon: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoryDetail(
                          storyId: widget.storyId,
                          storyTitle: widget.storyName,
                        ))),
            twoIconColor: widget.settingConfig.font,
            threeIcon: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoriesDownloadPage(
                          storyId: widget.storyId,
                          storyName: widget.storyName,
                          totalChapter: widget.totalChapter,
                          firstChapterId: widget.firstChapterId,
                        ))),
            threeIconColor: widget.settingConfig.font,
          ),
          ChapterIconAction(
            oneIconText: L(
                context, LanguageCodes.storyPushCoinConfigTextInfo.toString()),
            twoIconText:
                L(context, LanguageCodes.storyShareConfigTextInfo.toString()),
            threeIconText:
                L(context, LanguageCodes.storyReportConfigTextInfo.toString()),
            iconOne: Icons.upload,
            oneIcon: () {},
            oneIconColor: widget.settingConfig.font,
            iconTwo: Icons.share,
            twoIcon: () {},
            twoIconColor: widget.settingConfig.font,
            iconThree: Icons.error,
            threeIcon: () {},
            threeIconColor: widget.settingConfig.font,
          ),
        ],
      ),
    );
  }
}
