import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/presentation/pages/page.model.list.chapter.dart';

class ChapterListAudio extends StatefulWidget {
  final String author;
  final int storyId;
  final String storyTitle;
  final int firstChapterId;
  final int lastChapterId;
  final int totalChapter;
  final String storyImageUrl;
  final Function(int index, int pageIndex)? chapterCallback;
  const ChapterListAudio(
      {super.key,
      required this.storyId,
      required this.storyTitle,
      required this.firstChapterId,
      required this.lastChapterId,
      required this.totalChapter,
      required this.storyImageUrl,
      required this.chapterCallback,
      required this.author});

  @override
  State<ChapterListAudio> createState() => _ChapterListAudioState();
}

class _ChapterListAudioState extends State<ChapterListAudio> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ChapterListPage(
      author: widget.author,
      chapterCallback: widget.chapterCallback,
      isAudio: true,
      storyId: widget.storyId,
      storyTitle: widget.storyTitle,
      lastChapterId: widget.lastChapterId,
      firstChapterId: widget.firstChapterId,
      totalChapter: widget.totalChapter,
      storyImageUrl: widget.storyImageUrl,
    ));
  }
}
