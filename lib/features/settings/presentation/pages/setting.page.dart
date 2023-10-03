import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/settings/presentation/widgets/toggle.button.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.main.dart';

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
          title: Text(
              L(context, LanguageCodes.myAccountSettingTextInfo.toString())),
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
                          L(context,
                              LanguageCodes.themeModeTextInfo.toString()),
                          style: CustomFonts.h5(context),
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
                    textLeft:
                        L(context, LanguageCodes.lightModeTextInfo.toString()),
                    textRight:
                        L(context, LanguageCodes.darkModeTextInfo.toString()),
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
