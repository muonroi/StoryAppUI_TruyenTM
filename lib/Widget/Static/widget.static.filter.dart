import 'package:flutter/material.dart';
import '../../Settings/settings.colors.dart';
import '../../Settings/settings.fonts.dart';
import '../../Settings/settings.language_code.vi..dart';
import '../../Settings/settings.main.dart';

class FilterStoriesByCommon extends StatelessWidget {
  const FilterStoriesByCommon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height:
            MainSetting.getPercentageOfDevice(context, expectHeight: 60).height,
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
                      color: ColorDefaults.mainColor,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        L(ViCode.allCommonStoriesTextInfo.toString()),
                        style: FontsDefault.h5.copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: FontsDefault.abeeZees),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: ColorDefaults.secondMainColor,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        L(ViCode.commonStoriesOfDayTextInfo.toString()),
                        style: FontsDefault.h5.copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: FontsDefault.abeeZees),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: ColorDefaults.secondMainColor,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        L(ViCode.commonStoriesOfWeekTextInfo.toString()),
                        style: FontsDefault.h5.copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: FontsDefault.abeeZees),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: ColorDefaults.secondMainColor,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        L(ViCode.commonStoriesOfMonthTextInfo.toString()),
                        style: FontsDefault.h5.copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: FontsDefault.abeeZees),
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
