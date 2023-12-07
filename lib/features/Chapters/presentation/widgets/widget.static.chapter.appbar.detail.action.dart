import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';

class ChapterIconAction extends StatefulWidget {
  final IconData iconOne;
  final Function() oneIcon;
  final Color? oneIconColor;
  final String oneIconText;
  final IconData iconTwo;
  final Function() twoIcon;
  final Color? twoIconColor;
  final String twoIconText;
  final IconData iconThree;
  final Function() threeIcon;
  final Color? threeIconColor;
  final String threeIconText;

  const ChapterIconAction({
    Key? key,
    required this.oneIcon,
    required this.oneIconColor,
    required this.twoIcon,
    required this.twoIconColor,
    required this.threeIcon,
    required this.threeIconColor,
    required this.iconOne,
    required this.iconTwo,
    required this.iconThree,
    required this.oneIconText,
    required this.twoIconText,
    required this.threeIconText,
  }) : super(key: key);

  @override
  State<ChapterIconAction> createState() => _ChapterIconActionState();
}

class _ChapterIconActionState extends State<ChapterIconAction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: widget.oneIcon,
            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 4.0, right: 4.0, top: 4.0),
                  child: Icon(
                    widget.iconOne,
                    color: widget.oneIconColor,
                  ),
                ),
                Text(
                  widget.oneIconText,
                  style: CustomFonts.h6(context)
                      .copyWith(color: widget.twoIconColor),
                )
              ],
            ),
          ),
          InkWell(
            onTap: widget.twoIcon,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    widget.iconTwo,
                    color: widget.twoIconColor,
                  ),
                ),
                Text(
                  widget.twoIconText,
                  style: CustomFonts.h6(context)
                      .copyWith(color: widget.twoIconColor),
                )
              ],
            ),
          ),
          InkWell(
            onTap: widget.threeIcon,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    widget.iconThree,
                    color: widget.threeIconColor,
                  ),
                ),
                Text(
                  widget.threeIconText,
                  style: CustomFonts.h6(context)
                      .copyWith(color: widget.threeIconColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
