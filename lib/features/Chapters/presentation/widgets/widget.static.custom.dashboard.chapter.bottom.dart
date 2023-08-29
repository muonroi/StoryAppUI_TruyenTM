import 'package:flutter/material.dart';
import 'package:muonroi/features/Chapters/provider/models.chapter.scroll.button.setting.dart';
import 'package:muonroi/features/Chapters/provider/models.chapter.ui.available.settings.dart';
import 'package:muonroi/shared/static/buttons/widget.static.button.dart';
import 'package:muonroi/shared/Settings/Enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/Settings/settings.colors.dart';
import 'package:muonroi/shared/Settings/settings.dashboard.available.dart';
import 'package:muonroi/shared/Settings/settings.fonts.dart';
import 'package:muonroi/shared/Settings/settings.language_code.vi..dart';
import 'package:muonroi/shared/Settings/settings.main.dart';
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
    buttonSettingName = KeyButtonScroll.none.name;
    selectedRadio = KeyButtonScroll.none;
    _initSharedPreferences();
    super.initState();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    buttonSettingName =
        _sharedPreferences.getString(KeyButtonScroll.buttonScroll.toString()) ??
            KeyButtonScroll.none.name;
    setState(() {
      selectedRadio =
          enumFromString(KeyButtonScroll.values, buttonSettingName) ??
              KeyButtonScroll.none;
    });
  }

  Future<void> _saveKeyScrollButton() async {
    _sharedPreferences.setString(
        KeyButtonScroll.buttonScroll.toString(), selectedRadio.name);
  }

  late String buttonSettingName;
  late SharedPreferences _sharedPreferences;
  List<bool> isSelected = [true, false];
  var uiAvailable = DashboardSettings.getDashboardAvailableSettings();
  late KeyButtonScroll selectedRadio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorDefaults.lightAppColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorDefaults.lightAppColor,
        title: Title(
          color: ColorDefaults.thirdMainColor,
          child: Text(
            L(ViCode.customDashboardReadingTextInfo.toString()),
            style: FontsDefault.h5,
          ),
        ),
        leading: IconButton(
            splashRadius: 25,
            color: ColorDefaults.thirdMainColor,
            onPressed: () {
              Navigator.maybePop(context, true);
            },
            icon: backButtonCommon()),
        elevation: 0,
      ),
      body: Consumer<SettingObject>(
        builder: (context, value, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(12.0),
                  child: Text(
                    L(ViCode.defaultDashboardTextInfo.toString()),
                    style:
                        FontsDefault.h5.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 50)
                      .height,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: uiAvailable.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            _sharedPreferences.setString(
                                KeyChapter.chapterConfig.toString(),
                                settingObjectToJson(uiAvailable[index]));
                            value.valueSetting = uiAvailable[index];
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: CircleAvatar(
                              backgroundColor:
                                  uiAvailable[index].backgroundColor,
                              child: Text(
                                'AB',
                                style: TextStyle(
                                    color: uiAvailable[index].fontColor),
                              ),
                            ),
                          ),
                        );
                      })),
                ),
                Container(
                  margin: const EdgeInsets.all(12.0),
                  child: Text(
                    L(ViCode.customAnotherDashboardTextInfo.toString()),
                    style:
                        FontsDefault.h5.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 8.0),
                                    child: const Icon(Icons.swipe_outlined)),
                                Text(
                                  L(ViCode.scrollConfigDashboardTextInfo
                                      .toString()),
                                  style: FontsDefault.h5,
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
                            selectedColor: ColorDefaults.lightAppColor,
                            normalColor: ColorDefaults.thirdMainColor,
                            textLeft: L(ViCode
                                .scrollConfigVerticalDashboardTextInfo
                                .toString()),
                            textRight: L(ViCode
                                .scrollConfigHorizontalDashboardTextInfo
                                .toString()),
                            selectedBackgroundColor: ColorDefaults.mainColor,
                            noneSelectedBackgroundColor:
                                ColorDefaults.colorGrey200,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 8.0),
                                    child: const Icon(Icons
                                        .keyboard_double_arrow_down_outlined),
                                  ),
                                  Text(
                                    L(ViCode.buttonScrollConfigDashboardTextInfo
                                        .toString()),
                                    style: FontsDefault.h5,
                                  )
                                ],
                              ),
                            ),
                            Consumer<ButtonScrollSettings>(
                              builder: (context, object, child) {
                                return SizedBox(
                                    width: MainSetting.getPercentageOfDevice(
                                            context,
                                            expectWidth: 280)
                                        .width,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: KeyButtonScroll.none,
                                                groupValue: selectedRadio,
                                                onChanged: (value) {
                                                  setState(() {
                                                    object.valueSetting =
                                                        value ??
                                                            KeyButtonScroll
                                                                .none;
                                                    selectedRadio = value ??
                                                        KeyButtonScroll.none;
                                                    _saveKeyScrollButton();
                                                  });
                                                },
                                              ),
                                              Text(
                                                  L(ViCode
                                                      .buttonScrollConfigNoneDashboardTextInfo
                                                      .toString()),
                                                  style: FontsDefault.h5),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: KeyButtonScroll.left,
                                                groupValue: selectedRadio,
                                                onChanged: (value) {
                                                  setState(() {
                                                    object.valueSetting =
                                                        value ??
                                                            KeyButtonScroll
                                                                .none;
                                                    selectedRadio = value ??
                                                        KeyButtonScroll.none;
                                                    _saveKeyScrollButton();
                                                  });
                                                },
                                              ),
                                              Text(
                                                  L(ViCode
                                                      .buttonScrollConfigLeftDashboardTextInfo
                                                      .toString()),
                                                  style: FontsDefault.h5),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: KeyButtonScroll.right,
                                                groupValue: selectedRadio,
                                                onChanged: (value) {
                                                  setState(() {
                                                    object.valueSetting =
                                                        value ??
                                                            KeyButtonScroll
                                                                .none;
                                                    selectedRadio = value ??
                                                        KeyButtonScroll.none;
                                                    _saveKeyScrollButton();
                                                  });
                                                },
                                              ),
                                              Text(
                                                L(ViCode
                                                    .buttonScrollConfigRightDashboardTextInfo
                                                    .toString()),
                                                style: FontsDefault.h5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 8.0),
                                    child:
                                        const Icon(Icons.format_align_justify)),
                                Text(
                                  L(ViCode.alignConfigDashboardTextInfo
                                      .toString()),
                                  style: FontsDefault.h5,
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
                              isSelected: isSelected,
                              selectedColor: Colors.white,
                              color: ColorDefaults.thirdMainColor,
                              fillColor: ColorDefaults.mainColor,
                              splashColor: ColorDefaults.mainColor,
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
                                    L(ViCode.alignConfigLeftDashboardTextInfo
                                        .toString()),
                                    style: const TextStyle(
                                        fontFamily: FontsDefault.inter,
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
                                      L(ViCode
                                          .alignConfigRegularDashboardTextInfo
                                          .toString()),
                                      style: const TextStyle(
                                          fontFamily: FontsDefault.inter,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center),
                                ),
                              ],
                              onPressed: (int newIndex) {
                                setState(() {
                                  for (int index = 0;
                                      index < isSelected.length;
                                      index++) {
                                    if (index == newIndex) {
                                      isSelected[index] = true;
                                    } else {
                                      isSelected[index] = false;
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(right: 8.0),
                                      child: const Icon(Icons.text_format)),
                                  Text(
                                    L(ViCode.fontConfigDashboardTextInfo
                                        .toString()),
                                    style: FontsDefault.h5,
                                  )
                                ],
                              ),
                            ),
                            Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: ColorDefaults.colorGrey200),
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
                                    FontsDefault.inter,
                                    style: FontsDefault.h5,
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
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
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
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 8.0),
                                      child: const Icon(
                                        Icons.color_lens_outlined,
                                      ),
                                    ),
                                    Text(
                                      L(ViCode.fontColorConfigDashboardTextInfo
                                          .toString()),
                                      style: FontsDefault.h5,
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
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    context: context,
                                    builder: (context) {
                                      return const ChooseFontColor();
                                    },
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10.0),
                                    child: const CircleAvatar(
                                      backgroundColor: ColorDefaults.mainColor,
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
                                      margin: const EdgeInsets.only(right: 8.0),
                                      child: const Icon(
                                        Icons.colorize,
                                      ),
                                    ),
                                    Text(
                                      L(ViCode.backgroundConfigDashboardTextInfo
                                          .toString()),
                                      style: FontsDefault.h5,
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
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    context: context,
                                    builder: (context) {
                                      return const ChooseFontColor();
                                    },
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10.0),
                                    child: const CircleAvatar(
                                      backgroundColor: ColorDefaults.mainColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
