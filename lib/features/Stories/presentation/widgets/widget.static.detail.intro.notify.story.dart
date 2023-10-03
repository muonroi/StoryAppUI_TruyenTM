import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.main.dart';

class IntroAndNotificationStory extends StatefulWidget {
  final String name;
  final String value;
  const IntroAndNotificationStory(
      {super.key, required this.name, required this.value});

  @override
  State<IntroAndNotificationStory> createState() =>
      _IntroAndNotificationStoryState();
}

class _IntroAndNotificationStoryState extends State<IntroAndNotificationStory>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    animationReadMoreController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        upperBound: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    animationReadMoreController.dispose();
    super.dispose();
  }

  bool isReadMore = false;
  late AnimationController animationReadMoreController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    widget.name,
                    style: CustomFonts.h4(context),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Html(
                    data: widget.value.replaceAll("\n", "").trim(),
                    style: {
                      '#': Style(
                        fontSize: FontSize(15),
                        maxLines: 50,
                        textOverflow: TextOverflow.ellipsis,
                        color: themMode(context, ColorCode.textColor.name),
                      ),
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
