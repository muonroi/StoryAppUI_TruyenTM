import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:muonroi/Items/Static/Buttons/widget.static.button.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';

class BottomChapterDetail extends StatefulWidget {
  final int chapterId;
  final void Function(int chapterId, bool isCheckShow) onLoading;
  final void Function(int chapterId) onRefresh;
  const BottomChapterDetail(
      {super.key,
      required this.chapterId,
      required this.onLoading,
      required this.onRefresh});

  @override
  State<BottomChapterDetail> createState() => _BottomChapterDetailState();
}

class _BottomChapterDetailState extends State<BottomChapterDetail> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ColorDefaults.secondMainColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: () => widget.onRefresh(widget.chapterId),
              icon: Icon(
                Icons.arrow_circle_left_outlined,
                size:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 30)
                        .width,
              ),
            ),
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: () => widget.onLoading(widget.chapterId, false),
              icon: Icon(
                Icons.arrow_circle_right_outlined,
                size:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 30)
                        .width,
                color: ColorDefaults.mainColor,
              ),
            ),
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline,
                size:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 30)
                        .width,
              ),
            ),
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: () {},
              icon: Icon(
                Icons.headphones_outlined,
                size:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 30)
                        .width,
              ),
            ),
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: () => showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                context: context,
                builder: (BuildContext context) {
                  return const CustomDashboard();
                },
              ),
              icon: Icon(
                Icons.dashboard_customize_outlined,
                size:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 30)
                        .width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDashboard extends StatefulWidget {
  const CustomDashboard({super.key});

  @override
  State<CustomDashboard> createState() => _CustomDashboardState();
}

class _CustomDashboardState extends State<CustomDashboard> {
  List<bool> isSelected = [true, false];
  String _scrollButtonGroupValue =
      L(ViCode.buttonScrollConfigNoneDashboardTextInfo.toString());

  final _scrollButtonGroupStatus = [
    L(ViCode.buttonScrollConfigNoneDashboardTextInfo.toString()),
    L(ViCode.buttonScrollConfigLeftDashboardTextInfo.toString()),
    L(ViCode.buttonScrollConfigRightDashboardTextInfo.toString())
  ];
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(12.0),
              child: Text(
                L(ViCode.defaultDashboardTextInfo.toString()),
                style: FontsDefault.h5.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height:
                  MainSetting.getPercentageOfDevice(context, expectHeight: 50)
                      .height,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 9,
                  itemBuilder: ((context, index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: const CircleAvatar(
                          backgroundColor: ColorDefaults.mainColor,
                        ),
                      ))),
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              child: Text(
                L(ViCode.customAnotherDashboardTextInfo.toString()),
                style: FontsDefault.h5.copyWith(fontWeight: FontWeight.w700),
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
                        textLeft: L(ViCode.scrollConfigVerticalDashboardTextInfo
                            .toString()),
                        textRight: L(ViCode
                            .scrollConfigHorizontalDashboardTextInfo
                            .toString()),
                        selectedBackgroundColor: ColorDefaults.mainColor,
                        noneSelectedBackgroundColor: ColorDefaults.colorGrey200,
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
                                child: const Icon(
                                    Icons.keyboard_double_arrow_down_outlined),
                              ),
                              Text(
                                L(ViCode.buttonScrollConfigDashboardTextInfo
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
                          child: RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _scrollButtonGroupValue,
                            onChanged: (value) => setState(() {
                              _scrollButtonGroupValue = value ?? '';
                            }),
                            items: _scrollButtonGroupStatus,
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                            fillColor: ColorDefaults.mainColor,
                          ),
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
                                child: const Icon(Icons.format_align_justify)),
                            Text(
                              L(ViCode.alignConfigDashboardTextInfo.toString()),
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
                              width: MainSetting.getPercentageOfDevice(context,
                                      expectWidth: 135)
                                  .width,
                              height: MainSetting.getPercentageOfDevice(context,
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
                              width: MainSetting.getPercentageOfDevice(context,
                                      expectWidth: 135)
                                  .width,
                              height: MainSetting.getPercentageOfDevice(context,
                                      expectHeight: 20)
                                  .height,
                              child: Text(
                                  L(ViCode.alignConfigRegularDashboardTextInfo
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
                            width: MainSetting.getPercentageOfDevice(context,
                                    expectWidth: 280)
                                .width,
                            height: MainSetting.getPercentageOfDevice(context,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}

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

class ChooseFontPage extends StatelessWidget {
  const ChooseFontPage({super.key});

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
      body: GridView.count(
          scrollDirection: Axis.vertical,
          childAspectRatio: (1 / .4),
          shrinkWrap: true,
          crossAxisCount: 2,
          children: List.generate(FontsDefault.getFontsNameAvailable().length,
              (index) {
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
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
                      onTap: () {},
                    ),
                  )),
                ]),
              ),
            );
          })),
    );
  }
}
