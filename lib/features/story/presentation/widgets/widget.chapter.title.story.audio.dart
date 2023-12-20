import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class ChapterTitleWidget extends StatefulWidget {
  final Function(String) callback;
  const ChapterTitleWidget({
    super.key,
    required List<String> chapterSplit,
    required this.callback,
  }) : _chapterSplit = chapterSplit;

  final List<String> _chapterSplit;

  @override
  State<ChapterTitleWidget> createState() => _ChapterTitleWidgetState();
}

class _ChapterTitleWidgetState extends State<ChapterTitleWidget> {
  @override
  void didUpdateWidget(covariant ChapterTitleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._chapterSplit.first != oldWidget._chapterSplit.first) {
      widget.callback(widget._chapterSplit.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(children: [
        Text(
          widget._chapterSplit.isEmpty ? '' : widget._chapterSplit.first,
          style: CustomFonts.h6(context).copyWith(fontSize: 14),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        showToolTip(widget._chapterSplit.first)
      ]),
    );
  }
}
