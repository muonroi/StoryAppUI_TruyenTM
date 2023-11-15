import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/provider/provider.chapter.template.settings.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseFontPage extends StatefulWidget {
  const ChooseFontPage({super.key});

  @override
  State<ChooseFontPage> createState() => _ChooseFontPageState();
}

class _ChooseFontPageState extends State<ChooseFontPage> {
  @override
  void initState() {
    _initSharedPreferences();
    _templateSettingData = TemplateSetting();
    _chosseFontName = "";
    super.initState();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _templateSettingData = getCurrentTemplate(_sharedPreferences, context);
      _chosseFontName = _templateSettingData.fontFamily ?? '';
    });
  }

  late SharedPreferences _sharedPreferences;
  late String _chosseFontName;
  late TemplateSetting _templateSettingData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeMode(context, ColorCode.modeColor.name),
      appBar: AppBar(
        title: Title(
            color: themeMode(context, ColorCode.textColor.name),
            child: Text(
              L(context, LanguageCodes.fontConfigDashboardTextInfo.toString()),
              style: CustomFonts.h5(context),
            )),
        backgroundColor: themeMode(context, ColorCode.modeColor.name),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: backButtonCommon(context)),
      ),
      body: Consumer<TemplateSetting>(
        builder: (context, templateValue, child) {
          return GridView.count(
              scrollDirection: Axis.vertical,
              childAspectRatio: (1 / .4),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(
                  CustomFonts.getFontsNameAvailable().length, (index) {
                var fontName = CustomFonts.getFontsNameAvailable()[index];
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Stack(children: [
                      Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color:
                                  themeMode(context, ColorCode.modeColor.name),
                              boxShadow: [
                                _chosseFontName.toLowerCase() ==
                                        fontName.toLowerCase()
                                    ? BoxShadow(
                                        color: themeMode(
                                            context, ColorCode.mainColor.name),
                                        spreadRadius: 2)
                                    : const BoxShadow(),
                              ],
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Text(
                                    fontName,
                                    style: CustomFonts.h5(context),
                                  )),
                            ],
                          )),
                      Positioned.fill(
                          child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20.0),
                          onTap: () {
                            var currentTemplate =
                                getCurrentTemplate(_sharedPreferences, context);
                            currentTemplate.fontFamily = fontName;
                            setCurrentTemplate(
                                _sharedPreferences, currentTemplate, context);
                            templateValue.valueSetting = currentTemplate;
                            setState(() {
                              _chosseFontName = fontName;
                            });
                          },
                        ),
                      )),
                    ]),
                  ),
                );
              }));
        },
      ),
    );
  }
}
