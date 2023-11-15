import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class HeaderInfo extends StatefulWidget {
  final void Function() pickImage;
  final String url;
  final double textWidth;
  final TextEditingController textController;
  final String groupName;
  const HeaderInfo(
      {super.key,
      required this.pickImage,
      required this.url,
      required this.textWidth,
      required this.textController,
      required this.groupName});

  @override
  State<HeaderInfo> createState() => _HeaderInfoState();
}

class _HeaderInfoState extends State<HeaderInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.center,
        child: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: widget.pickImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: MainSetting.getPercentageOfDevice(context,
                                expectWidth: 70)
                            .width,
                        height: MainSetting.getPercentageOfDevice(context,
                                expectHeight: 70)
                            .height,
                        child: netWorkImage(context, widget.url, true,
                            isSize: true, width: 70, height: 70),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: widget.textWidth + 30,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(0),
                      ),
                      readOnly: true,
                      controller: widget.textController,
                      style: CustomFonts.h5(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    widget.groupName,
                    style: CustomFonts.h6(context),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 4.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(32.0),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialog(
                              backgroundColor:
                                  themeMode(context, ColorCode.modeColor.name),
                              title: Text(
                                L(
                                    context,
                                    LanguageCodes.changeNameTextInfo
                                        .toString()),
                                style: CustomFonts.h5(context),
                              ),
                              content: TextField(
                                style: CustomFonts.h5(context),
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    setState(() {
                                      widget.textController.text = value;
                                    });
                                  });
                                },
                                decoration: InputDecoration(
                                    hintStyle: CustomFonts.h5(context),
                                    hintText: widget.textController.text),
                              ));
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(32.0)),
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      color: themeMode(context, ColorCode.textColor.name),
                      size: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
