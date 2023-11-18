import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.languages.dart';
import 'package:muonroi/features/system/provider/provider.theme.mode.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.images.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectBox extends StatefulWidget {
  final Function(String) callBack;
  const SelectBox({super.key, required this.callBack});

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  @override
  void initState() {
    _selectedLanguage = Languages.none;
    _languageImages = {
      Languages.vi: CustomImages.vi2x,
      Languages.en: CustomImages.en2x,
    };
    _initSharedPreferences().then((value) {
      setState(() {
        _selectedLanguage =
            _sharedPreferences.getString("currentLanguage") ?? Languages.vi;
      });
    });
    super.initState();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  late SharedPreferences _sharedPreferences;
  late String _selectedLanguage;
  late Map<String, String> _languageImages;
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomThemeModeProvider>(
      builder: (BuildContext context, value, Widget? child) {
        _selectedLanguage =
            _selectedLanguage == "" ? Languages.vi : _selectedLanguage;
        return DropdownSearch<String>(
          items: _languageImages.keys.toList(),
          selectedItem: _selectedLanguage,
          onChanged: (String? newValue) {
            setState(() {
              _selectedLanguage = newValue!;
              value.changeLanguage = _selectedLanguage;
              widget.callBack(_selectedLanguage);
              _sharedPreferences.setString(
                  "currentLanguage", _selectedLanguage);
            });
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(
                    color: themeMode(context, ColorCode.mainColor.name),
                    width: 1),
              ),
            ),
          ),
          dropdownBuilder: (context, itemString) {
            return Row(
              children: [
                Image.asset(
                  _languageImages[itemString]!,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 30)
                      .height,
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 30)
                      .width,
                ),
                SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 10)
                        .width),
              ],
            );
          },
        );
      },
    );
  }
}
