import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/provider/models.chapter.template.settings.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      var templateSettingData = getCurrentTemplate(_sharedPreferences, context);
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
    _initSharedPreferences();
    leftColor =
        widget.selectedColor ?? themeMode(context, ColorCode.modeColor.name);
    rightColor =
        widget.normalColor ?? themeMode(context, ColorCode.textColor.name);
  }

  late double xAlign;
  late Color leftColor;
  late Color rightColor;
  late SharedPreferences _sharedPreferences;

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
                    var currentTemplate =
                        getCurrentTemplate(_sharedPreferences, context);
                    currentTemplate.isHorizontal = false;
                    currentTemplate.fontSize = 16;
                    setCurrentTemplate(
                        _sharedPreferences, currentTemplate, context);
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
                    var currentTemplate =
                        getCurrentTemplate(_sharedPreferences, context);
                    currentTemplate.isHorizontal = true;
                    currentTemplate.fontSize = 25;
                    setCurrentTemplate(
                        _sharedPreferences, currentTemplate, context);
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
