import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.images.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/shared/static/buttons/widget.static.circle.button.icon.dart';
import 'package:muonroi/shared/static/items/widget.divider.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

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
        title: Text(L(context, LanguageCodes.userInfoTextInfo.toString())),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: MainSetting.getPercentageOfDevice(context,
                                      expectWidth: 70)
                                  .width,
                              height: MainSetting.getPercentageOfDevice(context,
                                      expectHeight: 70)
                                  .height,
                              child: netWorkImage(
                                  CustomImages.imageAvatarDefault, true),
                            ),
                          ),
                          Container(
                            child: Text(
                              'John jerry',
                              style: CustomFonts.h5(context),
                            ),
                          ),
                          Text(
                            'Viewer',
                            style: CustomFonts.h6(context),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 4.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32.0),
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(32.0)),
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              size: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleButtonIcon(
                    icon: Icon(
                      Icons.notification_add_outlined,
                      color: themMode(context, ColorCode.textColor.name),
                    ),
                    borderSize: 16.0,
                    action: () {},
                    tooltip:
                        L(context, LanguageCodes.followUserTextInfo.toString()),
                  ),
                  CircleButtonIcon(
                    icon: Icon(
                      Icons.person_add_alt_1_outlined,
                      color: themMode(context, ColorCode.textColor.name),
                    ),
                    borderSize: 16.0,
                    action: () {},
                    tooltip:
                        L(context, LanguageCodes.followUserTextInfo.toString()),
                  ),
                  CircleButtonIcon(
                    icon: Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: themMode(context, ColorCode.textColor.name),
                    ),
                    borderSize: 16.0,
                    action: () {},
                    tooltip: L(context, LanguageCodes.inboxTextInfo.toString()),
                  )
                ],
              ),
            ),
            CustomDivider(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              width: 0.1),
                          bottom: BorderSide(
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              width: 0.1),
                          top: BorderSide(
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              width: 0.1),
                        ),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.email_outlined,
                            color: themMode(context, ColorCode.textColor.name),
                          ),
                          labelText: L(context,
                              LanguageCodes.gmailUserTextInfo.toString()),
                          labelStyle: CustomFonts.h5(context),
                        ),
                        style: CustomFonts.h5(context),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              width: 0.1),
                          bottom: BorderSide(
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              width: 0.1),
                          top: BorderSide(
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              width: 0.1),
                        ),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.phone_outlined,
                            color: themMode(context, ColorCode.textColor.name),
                          ),
                          labelText: L(context,
                              LanguageCodes.phoneNumberTextInfo.toString()),
                          labelStyle: CustomFonts.h5(context),
                        ),
                        style: CustomFonts.h5(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              width: 0.1),
                          bottom: BorderSide(
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              width: 0.1),
                          top: BorderSide(
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              width: 0.1),
                        ),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.calendar_month,
                            color: themMode(context, ColorCode.textColor.name),
                          ),
                          labelText: L(context,
                              LanguageCodes.birthdayUserTextInfo.toString()),
                          labelStyle: CustomFonts.h5(context),
                        ),
                        style: CustomFonts.h5(context),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              width: 0.1),
                          bottom: BorderSide(
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              width: 0.1),
                          top: BorderSide(
                              color:
                                  themMode(context, ColorCode.textColor.name),
                              width: 0.1),
                        ),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.info_outline,
                            color: themMode(context, ColorCode.textColor.name),
                          ),
                          labelText: L(context,
                              LanguageCodes.addressUserTextInfo.toString()),
                          labelStyle: CustomFonts.h5(context),
                        ),
                        style: CustomFonts.h5(context),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 280.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            backgroundColor: themMode(context, ColorCode.mainColor.name),
            onPressed: () {},
            child: Icon(
              Icons.save_as_outlined,
            ),
          ),
        ),
      ),
    );
  }
}
