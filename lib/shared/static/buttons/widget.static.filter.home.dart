import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language_code.vi..dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.main.dart';

class FilterByDateButton extends StatelessWidget {
  const FilterByDateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height:
            MainSetting.getPercentageOfDevice(context, expectHeight: 40).height,
        child: PageView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: themMode(context, ColorCode.mainColor.name),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        L(context, ViCode.allCommonStoriesTextInfo.toString()),
                        style: FontsDefault.h5(context).copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: FontsDefault.inter),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: themMode(context, ColorCode.modeColor.name),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        L(context,
                            ViCode.commonStoriesOfDayTextInfo.toString()),
                        style: FontsDefault.h5(context).copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: FontsDefault.inter),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: themMode(context, ColorCode.modeColor.name),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        L(context,
                            ViCode.commonStoriesOfWeekTextInfo.toString()),
                        style: FontsDefault.h5(context).copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: FontsDefault.inter),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: themMode(context, ColorCode.modeColor.name),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        L(context,
                            ViCode.commonStoriesOfMonthTextInfo.toString()),
                        style: FontsDefault.h5(context).copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: FontsDefault.inter),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
