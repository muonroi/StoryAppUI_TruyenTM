import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/static/buttons/widget.static.floating.action.button.dart';

class ButtonChapterScroll extends StatelessWidget {
  const ButtonChapterScroll({
    super.key,
    required this.tempLocationScrollButton,
    required this.tempFontColor,
    required this.tempBackground,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final KeyChapterButtonScroll? tempLocationScrollButton;
  final Color tempFontColor;
  final Color tempBackground;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return ExpandableDraggableFab(
        isVisibleButtonScroll:
            tempLocationScrollButton ?? KeyChapterButtonScroll.none,
        fontColor: tempFontColor,
        backgroundColor: tempBackground,
        distance: 10,
        controller: _scrollController,
        childrenCount: 1,
        children: [
          FloatingActionButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2,
                  color: tempFontColor,
                ),
                borderRadius: BorderRadius.circular(100)),
            onPressed: () {
              _scrollController.jumpTo(_scrollController.offset + 200);
            },
            backgroundColor: tempBackground,
            child: Icon(
              Icons.keyboard_double_arrow_down,
              color: tempFontColor,
            ),
          ),
        ]);
  }
}
