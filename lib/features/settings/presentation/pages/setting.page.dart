import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language_code.vi..dart';
import 'package:muonroi/features/settings/provider/theme.mode.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.mode.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themMode(context, ColorCode.modeColor.name),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
            color: themMode(context, ColorCode.modeColor.name),
          ),
          backgroundColor: themMode(context, ColorCode.mainColor.name),
          elevation: 0,
          title: Text(L(context, ViCode.myAccountSettingTextInfo.toString())),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 4.0),
                            child: Icon(
                              Icons.dark_mode_outlined,
                              color:
                                  themMode(context, ColorCode.mainColor.name),
                            )),
                        Text(
                          L(context, ViCode.themeModeTextInfo.toString()),
                          style: FontsDefault.h5(context),
                        )
                      ],
                    ),
                  ),
                  ToggleButtonDarkMode(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 200)
                        .width,
                    height: MainSetting.getPercentageOfDevice(context,
                            expectHeight: 40)
                        .height,
                    selectedColor: themMode(context, ColorCode.modeColor.name),
                    normalColor: themMode(context, ColorCode.textColor.name),
                    textLeft: L(context, ViCode.lightModeTextInfo.toString()),
                    textRight: L(context, ViCode.darkModeTextInfo.toString()),
                    selectedBackgroundColor:
                        themMode(context, ColorCode.mainColor.name),
                    noneSelectedBackgroundColor:
                        themMode(context, ColorCode.modeColor.name),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class ToggleButtonDarkMode extends StatefulWidget {
  final double? width;
  final double? height;
  final Color? selectedColor;
  final Color? selectedBackgroundColor;
  final Color? noneSelectedBackgroundColor;
  final Color? normalColor;
  final String textLeft;
  final String textRight;
  const ToggleButtonDarkMode(
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
        widget.selectedColor ?? themMode(context, ColorCode.modeColor.name);
    rightColor =
        widget.normalColor ?? themMode(context, ColorCode.textColor.name);
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      var _templateSettingData =
          _sharedPreferences.getString("currentTemplate");
      if (_templateSettingData != null && _templateSettingData == Modes.light) {
        xAlign = leftAlign;
        leftColor = widget.selectedColor!;
        rightColor = widget.normalColor!;
      } else if (_templateSettingData != null &&
          _templateSettingData == Modes.dark) {
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
                    value.changeMode = Modes.light;
                  });
                  _sharedPreferences.setString("currentTemplate", Modes.light);
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
                    value.changeMode = Modes.dark;
                  });
                  _sharedPreferences.setString("currentTemplate", Modes.dark);
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
