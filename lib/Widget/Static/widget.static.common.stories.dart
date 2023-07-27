import 'package:flutter/material.dart';
import 'package:taxi/Settings/settings.colors.dart';
import '../../Settings/settings.fonts.dart';
import '../../Settings/settings.main.dart';

class CommonStories extends StatelessWidget {
  final Widget imageWidget;
  final String nameOfStory;
  final String categoryOfStory;
  final String totalViewOfStory;
  const CommonStories({
    super.key,
    required this.imageWidget,
    required this.nameOfStory,
    required this.categoryOfStory,
    required this.totalViewOfStory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MainSetting.getPercentageOfDevice(context, expectHeight: 480).height,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text((index + 1).toString(),
                  style:
                      FontsDefault.h3.copyWith(color: ColorDefaults.mainColor)),
              imageWidget,
              Column(
                children: [
                  Text(nameOfStory, style: FontsDefault.h5),
                  Text(categoryOfStory, style: FontsDefault.h6),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.remove_red_eye_rounded,
                    color: ColorDefaults.mainColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(totalViewOfStory, style: FontsDefault.h6),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
