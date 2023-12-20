import 'package:flutter/widgets.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.template.dart';

class ChapterTitleWidget extends StatefulWidget {
  final String chapterName;
  final int chapterNumber;
  final ChapterTemplate templateSetting;
  const ChapterTitleWidget({
    super.key,
    required this.chapterName,
    required this.templateSetting,
    required this.chapterNumber,
  });

  @override
  State<ChapterTitleWidget> createState() => _ChapterTitleWidgetState();
}

class _ChapterTitleWidgetState extends State<ChapterTitleWidget> {
  @override
  void initState() {
    _chapterName =
        '${L(context, LanguageCodes.chapterNumberTextInfo.toString())}: ${widget.chapterNumber} - ${widget.chapterName} ';
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChapterTitleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.chapterName != oldWidget.chapterName) {
      setState(() {
        _chapterName =
            '${L(context, LanguageCodes.chapterNumberTextInfo.toString())}: ${widget.chapterNumber} - ${widget.chapterName} ';
      });
    }
  }

  late String _chapterName;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width:
            MainSetting.getPercentageOfDevice(context, expectWidth: 300).width,
        padding: const EdgeInsets.all(4.0),
        child: Text(
          _chapterName
              .replaceAll(RegExp(r'Chương \d+:'), '')
              .replaceAll("\n", "")
              .replaceAll('.', "")
              .trim(),
          style: CustomFonts.h6(context)
              .copyWith(color: widget.templateSetting.font, fontSize: 13),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      showToolTip(_chapterName
          .replaceAll(RegExp(r'Chương \d+:'), '')
          .replaceAll("\n", "")
          .replaceAll('.', "")
          .trim())
    ]);
  }
}
