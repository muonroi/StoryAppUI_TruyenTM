import 'package:flutter/material.dart';
import 'package:muonroi/shared/Settings/settings.colors.dart';
import 'package:muonroi/shared/Settings/settings.fonts.dart';
import 'package:muonroi/shared/Settings/settings.main.dart';

class SettingItems extends StatelessWidget {
  final String text;
  final String image;
  const SettingItems({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextButton(
          onPressed: () {},
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: ColorDefaults.secondMainColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 20)
                        .width,
                    height: MainSetting.getPercentageOfDevice(context,
                            expectHeight: 20)
                        .height,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 200)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 25)
                      .height,
                  child: Text(
                    text,
                    style: FontsDefault.h5,
                  ),
                ),
                SizedBox(
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 25)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 25)
                      .height,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_arrow_right),
                      color: ColorDefaults.thirdMainColor),
                )
              ],
            ),
          )),
    );
  }
}
