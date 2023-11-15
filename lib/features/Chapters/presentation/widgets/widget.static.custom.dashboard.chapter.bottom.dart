import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muonroi/features/chapters/provider/provider.chapter.template.settings.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/static/buttons/widget.static.button.dart';
import 'package:muonroi/features/chapters/settings/settings.dashboard.available.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widget.static.choose.font.color.chapter.bottom.dart';
import 'widget.static.chosse.font.family.chapter.bottom.dart';

class CustomDashboard extends StatefulWidget {
  const CustomDashboard({super.key});
  @override
  State<CustomDashboard> createState() => _CustomDashboardState();
}

class _CustomDashboardState extends State<CustomDashboard> {
  @override
  void initState() {
    _selectedRadio = KeyChapterButtonScroll.none;
    _fontSetting = CustomFonts.inter;
    _isSelected = [false, false];
    _templateSettingData = TemplateSetting();
    _fontSize = 15;
    _isChosseTemplate = -1;
    super.initState();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      var currentTemplate = _sharedPreferences
          .getString(KeyChapterTemplate.chapterConfig.toString());
      if (currentTemplate == null) {
        setCurrentTemplate(
            _sharedPreferences,
            DashboardSettings.getDashboardAvailableSettings(context)[0],
            context);
        _sharedPreferences.setInt('font_chosse_index', 0);
      }
      _templateSettingData = getCurrentTemplate(_sharedPreferences, context);
      _selectedRadio =
          _templateSettingData.locationButton ?? KeyChapterButtonScroll.none;
      _fontSetting = _templateSettingData.fontFamily ?? CustomFonts.inter;
      _isSelected[_sharedPreferences.getInt('align_index') ?? 0] = true;
      _fontColor = _templateSettingData.fontColor ??
          themeMode(context, ColorCode.textColor.name);
      _backgroundColor = _templateSettingData.backgroundColor ??
          themeMode(context, ColorCode.modeColor.name);
      _fontSize = _templateSettingData.fontSize ?? 15;
      _isChosseTemplate = _sharedPreferences.getInt('font_chosse_index') ?? -1;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initSharedPreferences();
    _fontColor = themeMode(context, ColorCode.textColor.name);
    _backgroundColor = themeMode(context, ColorCode.modeColor.name);
    _templateAvailable =
        DashboardSettings.getDashboardAvailableSettings(context);
  }

  late TemplateSetting _templateSettingData;
  late SharedPreferences _sharedPreferences;
  late String _fontSetting;
  late List<bool> _isSelected;
  late List<TemplateSetting> _templateAvailable;
  late KeyChapterButtonScroll _selectedRadio;
  late double _fontSize;
  late Color? _fontColor;
  late Color? _backgroundColor;
  late int _isChosseTemplate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeMode(context, ColorCode.disableColor.name),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: themeMode(context, ColorCode.disableColor.name),
        title: Title(
          color: themeMode(context, ColorCode.textColor.name),
          child: Text(
            L(context, LanguageCodes.customDashboardReadingTextInfo.toString()),
            style:
                CustomFonts.h5(context).copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        leading: IconButton(
            splashRadius: 25,
            color: themeMode(context, ColorCode.textColor.name),
            onPressed: () {
              Navigator.maybePop(context, true);
            },
            icon: backButtonCommon(context)),
        elevation: 0,
      ),
      body: Consumer<TemplateSetting>(
        builder: (context, templateValue, child) {
          var tempHorizontal = templateValue.isHorizontal ?? false;
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Text(
                      L(context,
                          LanguageCodes.defaultDashboardTextInfo.toString()),
                      style: CustomFonts.h5(context)
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  // #region Chosse template
                  SizedBox(
                    height: MainSetting.getPercentageOfDevice(context,
                            expectHeight: 50)
                        .height,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _templateAvailable.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: CircleAvatar(
                              backgroundColor: _isChosseTemplate == index
                                  ? themeMode(context, ColorCode.mainColor.name)
                                  : _templateAvailable[index].backgroundColor,
                              radius: 60.0,
                              child: InkWell(
                                highlightColor: themeMode(
                                    context, ColorCode.modeColor.name),
                                onTap: () {
                                  templateValue.valueSetting =
                                      _templateAvailable[index];
                                  setCurrentTemplate(_sharedPreferences,
                                      _templateAvailable[index], context);
                                  _isChosseTemplate = index;
                                  _sharedPreferences.setInt(
                                      'font_chosse_index', index);
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      _templateAvailable[index].backgroundColor,
                                  child: Text(
                                    'AB',
                                    style: TextStyle(
                                        color: _templateAvailable[index]
                                            .fontColor),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                  // #endregion
                  Container(
                    margin: const EdgeInsets.all(12.0),
                    child: Text(
                      L(
                          context,
                          LanguageCodes.customAnotherDashboardTextInfo
                              .toString()),
                      style: CustomFonts.h5(context)
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // #region Chosse type reading (horizontal or vertical)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 4.0),
                                    child: Icon(Icons.swipe_outlined,
                                        color: themeMode(
                                            context, ColorCode.textColor.name)),
                                  ),
                                  Text(
                                    L(
                                        context,
                                        LanguageCodes
                                            .scrollConfigDashboardTextInfo
                                            .toString()),
                                    style: CustomFonts.h5(context),
                                  )
                                ],
                              ),
                            ),
                            ToggleButton(
                              width: MainSetting.getPercentageOfDevice(context,
                                      expectWidth: 280)
                                  .width,
                              height: MainSetting.getPercentageOfDevice(context,
                                      expectHeight: 40)
                                  .height,
                              selectedColor:
                                  themeMode(context, ColorCode.modeColor.name),
                              normalColor:
                                  themeMode(context, ColorCode.textColor.name),
                              textLeft: L(
                                  context,
                                  LanguageCodes
                                      .scrollConfigVerticalDashboardTextInfo
                                      .toString()),
                              textRight: L(
                                  context,
                                  LanguageCodes
                                      .scrollConfigHorizontalDashboardTextInfo
                                      .toString()),
                              selectedBackgroundColor:
                                  themeMode(context, ColorCode.mainColor.name),
                              noneSelectedBackgroundColor:
                                  themeMode(context, ColorCode.modeColor.name),
                            ),
                          ],
                        ),
                        // #endregion
                        // #region Chosse Button scroll (hide or show)

                        !tempHorizontal
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 4.0),
                                            child: Icon(
                                                Icons
                                                    .keyboard_double_arrow_down_outlined,
                                                color: themeMode(context,
                                                    ColorCode.textColor.name)),
                                          ),
                                          Text(
                                            L(
                                                context,
                                                LanguageCodes
                                                    .buttonScrollConfigDashboardTextInfo
                                                    .toString()),
                                            style: CustomFonts.h5(context),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MainSetting.getPercentageOfDevice(
                                                    context,
                                                    expectWidth: 280)
                                                .width,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value:
                                                        KeyChapterButtonScroll
                                                            .none,
                                                    groupValue: _selectedRadio,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        var currentTemplate =
                                                            getCurrentTemplate(
                                                                _sharedPreferences,
                                                                context);

                                                        currentTemplate
                                                                .locationButton =
                                                            value;

                                                        templateValue
                                                                .valueSetting =
                                                            currentTemplate;

                                                        _selectedRadio = value ??
                                                            KeyChapterButtonScroll
                                                                .none;
                                                        setCurrentTemplate(
                                                            _sharedPreferences,
                                                            currentTemplate,
                                                            context);
                                                        templateValue
                                                                .valueSetting =
                                                            currentTemplate;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                      L(
                                                          context,
                                                          LanguageCodes
                                                              .buttonScrollConfigNoneDashboardTextInfo
                                                              .toString()),
                                                      style: CustomFonts.h5(
                                                          context)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value:
                                                        KeyChapterButtonScroll
                                                            .show,
                                                    groupValue: _selectedRadio,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        var currentTempLate =
                                                            getCurrentTemplate(
                                                                _sharedPreferences,
                                                                context);

                                                        currentTempLate
                                                                .locationButton =
                                                            value ??
                                                                KeyChapterButtonScroll
                                                                    .none;

                                                        _selectedRadio = value ??
                                                            KeyChapterButtonScroll
                                                                .none;
                                                        setCurrentTemplate(
                                                            _sharedPreferences,
                                                            currentTempLate,
                                                            context);

                                                        templateValue
                                                                .valueSetting =
                                                            currentTempLate;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                      L(
                                                          context,
                                                          LanguageCodes
                                                              .buttonScrollConfigDisplayDashboardTextInfo
                                                              .toString()),
                                                      style: CustomFonts.h5(
                                                          context)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                              ),
                        // #endregion
                        // #region Chosse align
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(right: 4.0),
                                      child: Icon(Icons.format_align_justify,
                                          color: themeMode(context,
                                              ColorCode.textColor.name))),
                                  Text(
                                    L(
                                        context,
                                        LanguageCodes
                                            .alignConfigDashboardTextInfo
                                            .toString()),
                                    style: CustomFonts.h5(context),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MainSetting.getPercentageOfDevice(context,
                                      expectWidth: 280)
                                  .width,
                              height: MainSetting.getPercentageOfDevice(context,
                                      expectHeight: 40)
                                  .height,
                              child: ToggleButtons(
                                isSelected: _isSelected,
                                selectedColor: themeMode(
                                    context, ColorCode.modeColor.name),
                                color: themeMode(
                                    context, ColorCode.textColor.name),
                                fillColor: themeMode(
                                    context, ColorCode.mainColor.name),
                                splashColor: themeMode(
                                    context, ColorCode.mainColor.name),
                                highlightColor: Colors.orange,
                                borderRadius: BorderRadius.circular(30),
                                children: [
                                  SizedBox(
                                    width: MainSetting.getPercentageOfDevice(
                                            context,
                                            expectWidth: 135)
                                        .width,
                                    height: MainSetting.getPercentageOfDevice(
                                            context,
                                            expectHeight: 20)
                                        .height,
                                    child: Text(
                                      L(
                                          context,
                                          LanguageCodes
                                              .alignConfigLeftDashboardTextInfo
                                              .toString()),
                                      style: const TextStyle(
                                          fontFamily: CustomFonts.inter,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MainSetting.getPercentageOfDevice(
                                            context,
                                            expectWidth: 135)
                                        .width,
                                    height: MainSetting.getPercentageOfDevice(
                                            context,
                                            expectHeight: 20)
                                        .height,
                                    child: Text(
                                        L(
                                            context,
                                            LanguageCodes
                                                .alignConfigRegularDashboardTextInfo
                                                .toString()),
                                        style: const TextStyle(
                                            fontFamily: CustomFonts.inter,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                                onPressed: (int newIndex) {
                                  setState(() {
                                    for (int index = 0;
                                        index < _isSelected.length;
                                        index++) {
                                      if (index == newIndex) {
                                        var currentTempLate =
                                            getCurrentTemplate(
                                                _sharedPreferences, context);
                                        currentTempLate.isLeftAlign = true;
                                        _isSelected[index] = true;
                                        setCurrentTemplate(_sharedPreferences,
                                            currentTempLate, context);
                                        templateValue.valueSetting =
                                            currentTempLate;
                                        _sharedPreferences.setInt(
                                            'align_index', newIndex);
                                      } else {
                                        var currentTempLate =
                                            getCurrentTemplate(
                                                _sharedPreferences, context);
                                        currentTempLate.isLeftAlign = false;
                                        _isSelected[index] = false;
                                        setCurrentTemplate(_sharedPreferences,
                                            currentTempLate, context);
                                        templateValue.valueSetting =
                                            currentTempLate;
                                        _sharedPreferences.setInt(
                                            'align_index', newIndex);
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        // #endregion
                        // #region Chosse font
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Icon(Icons.text_format,
                                            color: themeMode(context,
                                                ColorCode.textColor.name))),
                                    Text(
                                      L(
                                          context,
                                          LanguageCodes
                                              .fontConfigDashboardTextInfo
                                              .toString()),
                                      style: CustomFonts.h5(context),
                                    )
                                  ],
                                ),
                              ),
                              Stack(children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: themeMode(
                                          context, ColorCode.disableColor.name),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                181, 156, 154, 154),
                                            spreadRadius: 0.5)
                                      ]),
                                  width: MainSetting.getPercentageOfDevice(
                                          context,
                                          expectWidth: 280)
                                      .width,
                                  height: MainSetting.getPercentageOfDevice(
                                          context,
                                          expectHeight: 40)
                                      .height,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      templateValue.fontFamily ?? _fontSetting,
                                      style: CustomFonts.h5(context),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20.0),
                                      onTap: () => showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        context: context,
                                        builder: (context) {
                                          return const ChooseFontPage();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                        // #endregion
                        // #region Chosse font size
                        Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 4.0),
                                  child: Icon(Icons.text_fields_outlined,
                                      color: themeMode(
                                          context, ColorCode.textColor.name)),
                                ),
                                Text(
                                  L(
                                      context,
                                      LanguageCodes
                                          .fontSizeConfigDashboardTextInfo
                                          .toString()),
                                  style: CustomFonts.h5(context),
                                ),
                              ],
                            ),
                            Expanded(
                                child: Slider(
                                    min: 10,
                                    max: 50,
                                    value: _fontSize,
                                    onChanged: (newValue) {
                                      var currentTemplate = getCurrentTemplate(
                                          _sharedPreferences, context);
                                      currentTemplate.fontSize = newValue;
                                      templateValue.valueSetting =
                                          currentTemplate;
                                      setCurrentTemplate(_sharedPreferences,
                                          currentTemplate, context);
                                      _fontSize = newValue;
                                    })),
                            GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (builder) {
                                        return AlertDialog(
                                            backgroundColor: themeMode(context,
                                                ColorCode.modeColor.name),
                                            title: Text(
                                              L(
                                                  context,
                                                  LanguageCodes
                                                      .limitFontSizeConfigTextInfo
                                                      .toString()),
                                              style: CustomFonts.h5(context),
                                            ),
                                            content: TextField(
                                              style: CustomFonts.h5(context),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value.isNotEmpty) {
                                                    if (double.parse(value) >=
                                                            10 &&
                                                        double.parse(value) <=
                                                            50) {
                                                      var currentTemplate =
                                                          getCurrentTemplate(
                                                              _sharedPreferences,
                                                              context);
                                                      currentTemplate.fontSize =
                                                          double.parse(value);
                                                      templateValue
                                                              .valueSetting =
                                                          currentTemplate;
                                                      setCurrentTemplate(
                                                          _sharedPreferences,
                                                          currentTemplate,
                                                          context);
                                                      _fontSize =
                                                          double.parse(value);
                                                    } else {
                                                      var currentTemplate =
                                                          getCurrentTemplate(
                                                              _sharedPreferences,
                                                              context);
                                                      currentTemplate.fontSize =
                                                          15;
                                                      templateValue
                                                              .valueSetting =
                                                          currentTemplate;
                                                      setCurrentTemplate(
                                                          _sharedPreferences,
                                                          currentTemplate,
                                                          context);
                                                      _fontSize = 15;
                                                    }
                                                  }
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  hintStyle:
                                                      CustomFonts.h5(context),
                                                  hintText:
                                                      '${_fontSize.ceil()}'),
                                            ));
                                      });
                                },
                                child: Text(
                                  '${_fontSize.ceil()}',
                                  style: CustomFonts.h5(context),
                                ))
                          ],
                        ),
                        // #endregion
                        // #region Chosse color (background or font)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Icon(Icons.color_lens_outlined,
                                              color: themeMode(context,
                                                  ColorCode.textColor.name)),
                                        ),
                                        Text(
                                          L(
                                              context,
                                              LanguageCodes
                                                  .fontColorConfigDashboardTextInfo
                                                  .toString()),
                                          style: CustomFonts.h5(context),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () => showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        context: context,
                                        builder: (context) {
                                          return const ChooseFontColor(
                                            colorType: KeyChapterColor.font,
                                          );
                                        },
                                      ),
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              templateValue.fontColor ??
                                                  _fontColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Icon(Icons.colorize,
                                              color: themeMode(context,
                                                  ColorCode.textColor.name)),
                                        ),
                                        Text(
                                          L(
                                              context,
                                              LanguageCodes
                                                  .backgroundConfigDashboardTextInfo
                                                  .toString()),
                                          style: CustomFonts.h5(context),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () => showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        context: context,
                                        builder: (context) {
                                          return const ChooseFontColor(
                                            colorType:
                                                KeyChapterColor.background,
                                          );
                                        },
                                      ),
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              templateValue.backgroundColor ??
                                                  _backgroundColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // #endregion
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
