import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/provider/models.chapter.template.settings.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.language_code.vi..dart';
import 'package:muonroi/shared/settings/settings.main.dart';
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
    super.initState();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  late SharedPreferences _sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorDefaults.lightAppColor,
      appBar: AppBar(
        title: Title(
            color: ColorDefaults.thirdMainColor,
            child: Text(
              L(ViCode.fontConfigDashboardTextInfo.toString()),
              style: FontsDefault.h5,
            )),
        backgroundColor: ColorDefaults.lightAppColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context), icon: backButtonCommon()),
      ),
      body: Consumer<TemplateSetting>(
        builder: (context, templateValue, child) {
          return GridView.count(
              scrollDirection: Axis.vertical,
              childAspectRatio: (1 / .4),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(
                  FontsDefault.getFontsNameAvailable().length, (index) {
                var fontName = FontsDefault.getFontsNameAvailable()[index];
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Stack(children: [
                      Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: ColorDefaults.secondMainColor,
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
                                    style: FontsDefault.h5,
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
                                getCurrentTemplate(_sharedPreferences);
                            currentTemplate.fontFamily = fontName;
                            setCurrentTemplate(
                                _sharedPreferences, currentTemplate);
                            templateValue.valueSetting = currentTemplate;
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
