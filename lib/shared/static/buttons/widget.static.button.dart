import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/provider/models.chapter.template.settings.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../settings/settings.colors.dart';

class ButtonWidget {
  static Widget buttonNavigatorNextPreviewLanding(
      BuildContext context, Widget nextRoute,
      {String textDisplay = 'Next',
      TextStyle textStyle = const TextStyle(
          fontFamily: "Inter",
          fontSize: 16,
          color: ColorDefaults.defaultTextColor),
      Color color = ColorDefaults.mainColor,
      Color borderColor = ColorDefaults.mainColor,
      double widthBorder = 2}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextRoute),
        );
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const StadiumBorder(),
          side: BorderSide(color: borderColor, width: widthBorder)),
      child: Text(
        textDisplay,
        style: textStyle,
      ),
    );
  }

  static Widget buttonDisplayCurrentPage(Size value, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? value.height * 1 / 59 : value.height * 1 / 59,
      width: isActive ? value.width * 1 / 7 : value.height * 1 / 59,
      decoration: BoxDecoration(
          shape: !isActive ? BoxShape.circle : BoxShape.rectangle,
          border: Border.all(color: ColorDefaults.colorGrey200),
          borderRadius: isActive
              ? const BorderRadius.vertical(
                  top: Radius.circular(20), bottom: Radius.circular(20))
              : null,
          color:
              isActive ? ColorDefaults.colorGrey200 : ColorDefaults.mainColor),
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
    _initSharedPreferences();
    super.initState();
    xAlign = leftAlign;
    leftColor = widget.selectedColor ?? ColorDefaults.lightAppColor;
    rightColor = widget.normalColor ?? ColorDefaults.thirdMainColor;
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      var _templateSettingData = getCurrentTemplate(_sharedPreferences);
      if (_templateSettingData.isHorizontal != null &&
          !_templateSettingData.isHorizontal!) {
        xAlign = leftAlign;
        leftColor = widget.selectedColor!;
        rightColor = widget.normalColor!;
      } else if (_templateSettingData.isHorizontal != null &&
          _templateSettingData.isHorizontal!) {
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
              boxShadow: [
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
                        getCurrentTemplate(_sharedPreferences);
                    currentTemplate.isHorizontal = false;
                    currentTemplate.fontSize = 16;
                    setCurrentTemplate(_sharedPreferences, currentTemplate);
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
                          fontFamily: FontsDefault.inter,
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
                        getCurrentTemplate(_sharedPreferences);
                    currentTemplate.isHorizontal = true;
                    currentTemplate.fontSize = 25;
                    setCurrentTemplate(_sharedPreferences, currentTemplate);
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
                          fontFamily: FontsDefault.inter,
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
