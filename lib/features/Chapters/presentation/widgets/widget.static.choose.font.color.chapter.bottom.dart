import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:muonroi/shared/Settings/settings.colors.dart';
import 'package:muonroi/shared/Settings/settings.fonts.dart';
import 'package:muonroi/shared/Settings/settings.language_code.vi..dart';
import 'package:muonroi/shared/Settings/settings.main.dart';

class ChooseFontColor extends StatefulWidget {
  const ChooseFontColor({super.key});

  @override
  State<ChooseFontColor> createState() => _ChooseFontColorState();
}

class _ChooseFontColorState extends State<ChooseFontColor> {
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorDefaults.secondMainColor,
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
      body: HueRingPicker(
        onColorChanged: (Color value) => changeColor,
        pickerColor: pickerColor,
        enableAlpha: true,
        displayThumbColor: false,
      ),
    );
  }
}
