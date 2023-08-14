import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.main.dart';

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
                    style: FontsDefault.h4,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Html(
                    data: widget.value.replaceAll("\n", "").trim(),
                    style: {
                      '#': Style(
                        fontSize: FontSize(15),
                        maxLines: 5,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              child: RotationTransition(
                  turns: Tween(
                    begin: 0.0,
                    end: 0.5,
                  ).animate(animationReadMoreController),
                  child: null //isReadMore == false
                  // ? IconButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         if (animationReadMoreController.value == 1) {
                  //           animationReadMoreController.reverse(from: 0.0);
                  //         } else {
                  //           isReadMore = true;
                  //           animationReadMoreController.forward(from: 0.5);
                  //         }
                  //       });
                  //     },
                  //     icon: const Icon(Icons.keyboard_arrow_down))
                  //: null,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  double _calcIntroHeight(BuildContext context, String content) {
    final document = parse(content);
    final String? parsedString =
        parse(document.body?.text).documentElement?.text;
    final textSpan =
        TextSpan(text: parsedString, style: const TextStyle(fontSize: 13));
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);
    return textPainter.size.height + 100;
  }
}
