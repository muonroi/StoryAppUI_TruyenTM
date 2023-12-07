import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/chapters/provider/provider.chapter.template.settings.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:provider/provider.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onYes;
  final VoidCallback onNo;

  const ConfirmDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onYes,
      required this.onNo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: CustomFonts.h5(context).copyWith(fontWeight: FontWeight.w600),
      ),
      content: Text(
        content,
        style: CustomFonts.h5(context),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onNo,
          child: Text(
            L(context, LanguageCodes.unAcceptTextInfo.toString()),
            style: CustomFonts.h6(context).copyWith(
                fontWeight: FontWeight.w700,
                color: themeMode(context, ColorCode.textColor.name)),
          ),
        ),
        TextButton(
          onPressed: onYes,
          child: Text(
            L(context, LanguageCodes.acceptTextInfo.toString()),
            style: CustomFonts.h6(context).copyWith(
                fontWeight: FontWeight.w700,
                color: themeMode(context, ColorCode.mainColor.name)),
          ),
        ),
      ],
    );
  }
}

Future<void> showConfirmationDialog(
    BuildContext context, String confirmAction, String content) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(
          confirmAction,
          style: CustomFonts.h5(context).copyWith(fontWeight: FontWeight.w700),
        ),
        content: Text(
          content,
          style: CustomFonts.h5(context),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              L(context, LanguageCodes.unAcceptTextInfo.toString()),
              style: CustomFonts.h6(context).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              L(context, LanguageCodes.acceptTextInfo.toString()),
              style: CustomFonts.h6(context).copyWith(
                  fontWeight: FontWeight.w700,
                  color: themeMode(context, ColorCode.mainColor.name)),
            ),
          ),
        ],
      );
    },
  );
}

class ButtonWidget {
  static Widget buttonNavigatorNextPreviewLanding(
      BuildContext context, Widget nextRoute,
      {String textDisplay = 'Next',
      TextStyle textStyle = const TextStyle(
          fontFamily: "Inter", fontSize: 16, color: Color(0xFF2D2D2D)),
      Color color = const Color(0xFFFFB800),
      Color borderColor = const Color(0xFFFFB800),
      double widthBorder = 2,
      bool isDisable = false}) {
    return ElevatedButton(
      onPressed: !isDisable
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextRoute),
              );
            }
          : null,
      style: ElevatedButton.styleFrom(
          backgroundColor: !isDisable
              ? color
              : themeMode(context, ColorCode.disableColor.name),
          shape: const StadiumBorder(),
          side: !isDisable
              ? BorderSide(color: borderColor, width: widthBorder)
              : null),
      child: Text(
        textDisplay,
        style: textStyle,
      ),
    );
  }

  static Widget buttonDisplayCurrentPage(
      Size value, bool isActive, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? value.height * 1 / 59 : value.height * 1 / 59,
      width: isActive ? value.width * 1 / 7 : value.height * 1 / 59,
      decoration: BoxDecoration(
          shape: !isActive ? BoxShape.circle : BoxShape.rectangle,
          border: Border.all(
              color: themeMode(context, ColorCode.disableColor.name)),
          borderRadius: isActive
              ? const BorderRadius.vertical(
                  top: Radius.circular(20), bottom: Radius.circular(20))
              : null,
          color: isActive
              ? themeMode(context, ColorCode.disableColor.name)
              : themeMode(context, ColorCode.mainColor.name)),
    );
  }
}

class ButtonGlobal extends StatefulWidget {
  const ButtonGlobal(
      {super.key,
      required this.style,
      required this.text,
      required this.onPressed,
      required this.textStyle});
  final ButtonStyle style;
  final TextStyle textStyle;
  final String text;
  final void Function() onPressed;
  @override
  State<ButtonGlobal> createState() => _ButtonGlobalState();
}

class _ButtonGlobalState extends State<ButtonGlobal> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: widget.style,
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        style: widget.textStyle,
      ),
    );
  }
}

class ToggleButton extends StatefulWidget {
  final double? width;
  final double? height;
  final Color? selectedColor;
  final Color? selectedBackgroundColor;
  final Color? noneSelectedBackgroundColor;
  final Color? normalColor;
  final String textLeft;
  final String textRight;
  const ToggleButton(
      {super.key,
      required this.width,
      required this.height,
      this.selectedColor,
      this.normalColor,
      required this.textLeft,
      required this.textRight,
      this.selectedBackgroundColor,
      this.noneSelectedBackgroundColor});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

const double leftAlign = -1;
const double rightAlign = 1;

class _ToggleButtonState extends State<ToggleButton> {
  @override
  void initState() {
    super.initState();
    xAlign = leftAlign;
  }

  void _initData() {
    setState(() {
      var templateSettingData = getCurrentTemplate(context);
      if (templateSettingData.isHorizontal != null &&
          !templateSettingData.isHorizontal!) {
        xAlign = leftAlign;
        leftColor = widget.selectedColor!;
        rightColor = widget.normalColor!;
      } else if (templateSettingData.isHorizontal != null &&
          templateSettingData.isHorizontal!) {
        xAlign = rightAlign;
        rightColor = widget.selectedColor!;
        leftColor = widget.normalColor!;
      } else {
        xAlign = leftAlign;
        leftColor = widget.selectedColor!;
        rightColor = widget.normalColor!;
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initData();
    leftColor =
        widget.selectedColor ?? themeMode(context, ColorCode.modeColor.name);
    rightColor =
        widget.normalColor ?? themeMode(context, ColorCode.textColor.name);
  }

  late double xAlign;
  late Color leftColor;
  late Color rightColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<TemplateSetting>(builder:
          (BuildContext context, TemplateSetting value, Widget? child) {
        if (value.isHorizontal != null && !value.isHorizontal!) {
          xAlign = leftAlign;
          leftColor = widget.selectedColor!;
          rightColor = widget.normalColor!;
        } else if (value.isHorizontal != null && value.isHorizontal!) {
          xAlign = rightAlign;
          rightColor = widget.selectedColor!;
          leftColor = widget.normalColor!;
        } else {
          xAlign = leftAlign;
          leftColor = widget.selectedColor!;
          rightColor = widget.normalColor!;
        }
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              color: widget.noneSelectedBackgroundColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(50.0),
              ),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(181, 156, 154, 154),
                    spreadRadius: 0.5)
              ]),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: Alignment(xAlign, 0),
                duration: const Duration(milliseconds: 200),
                child: Container(
                  width: widget.width! * 0.5,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: widget.selectedBackgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    xAlign = leftAlign;
                    leftColor = widget.selectedColor!;
                    rightColor = widget.normalColor!;
                    var currentTemplate = getCurrentTemplate(context);
                    currentTemplate.isHorizontal = false;
                    currentTemplate.fontSize = 16;
                    setCurrentTemplate(currentTemplate, context);
                    value.valueSetting = currentTemplate;
                  });
                },
                child: Align(
                  alignment: const Alignment(-1, 0),
                  child: Container(
                    width: widget.width! * 0.5,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      widget.textLeft,
                      style: TextStyle(
                          color: leftColor,
                          fontFamily: CustomFonts.inter,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    xAlign = rightAlign;
                    rightColor = widget.selectedColor!;
                    leftColor = widget.normalColor!;
                    var currentTemplate = getCurrentTemplate(context);
                    currentTemplate.isHorizontal = true;
                    currentTemplate.fontSize = 25;
                    setCurrentTemplate(currentTemplate, context);
                    value.valueSetting = currentTemplate;
                  });
                },
                child: Align(
                  alignment: const Alignment(1, 0),
                  child: Container(
                    width: widget.width! * 0.5,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      widget.textRight,
                      style: TextStyle(
                          color: rightColor,
                          fontFamily: CustomFonts.inter,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
