import 'package:flutter/material.dart';
import 'package:muonroi/features/system/provider/provider.theme.mode.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.mode.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToggleButtonDarkMode extends StatefulWidget {
  final double? width;
  final double? height;
  final Color? selectedColor;
  final Color? selectedBackgroundColor;
  final Color? noneSelectedBackgroundColor;
  final Color? normalColor;
  final String textLeft;
  final String textRight;
  final Function(String) callback;
  const ToggleButtonDarkMode(
      {super.key,
      required this.width,
      required this.height,
      this.selectedColor,
      this.normalColor,
      required this.textLeft,
      required this.textRight,
      this.selectedBackgroundColor,
      this.noneSelectedBackgroundColor,
      required this.callback});

  @override
  State<ToggleButtonDarkMode> createState() => _ToggleButtonDarkModeState();
}

const double leftAlign = -1;
const double rightAlign = 1;

class _ToggleButtonDarkModeState extends State<ToggleButtonDarkMode> {
  @override
  void initState() {
    _initSharedPreferences();
    super.initState();
    xAlign = leftAlign;
    leftColor =
        widget.selectedColor ?? themeMode(context, ColorCode.modeColor.name);
    rightColor =
        widget.normalColor ?? themeMode(context, ColorCode.textColor.name);
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      var templateSettingData = _sharedPreferences.getString("currentTemplate");
      if (templateSettingData != null && templateSettingData == Modes.light) {
        xAlign = leftAlign;
        leftColor = widget.selectedColor!;
        rightColor = widget.normalColor!;
      } else if (templateSettingData != null &&
          templateSettingData == Modes.dark) {
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
      child: Consumer<CustomThemeModeProvider>(builder:
          (BuildContext context, CustomThemeModeProvider value, Widget? child) {
        if (value.mode == Modes.light) {
          xAlign = leftAlign;
          leftColor = widget.selectedColor!;
          rightColor = widget.normalColor!;
        } else if (value.mode == Modes.dark) {
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
                    value.changeMode = Modes.light;
                  });
                  _sharedPreferences.setString("currentTemplate", Modes.light);
                  widget.callback(Modes.light);
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
                    value.changeMode = Modes.dark;
                  });
                  _sharedPreferences.setString("currentTemplate", Modes.dark);
                  widget.callback(Modes.dark);
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
