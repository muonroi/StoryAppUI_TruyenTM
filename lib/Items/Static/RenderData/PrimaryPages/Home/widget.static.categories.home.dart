import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../Settings/settings.colors.dart';
import '../../../../../Settings/settings.fonts.dart';
import '../../../../../Settings/settings.images.dart';
import '../../../../../Settings/settings.language_code.vi..dart';
import '../../../../../Settings/settings.main.dart';

// #region Main categories
class MainCategories extends StatelessWidget {
  const MainCategories({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: ColorDefaults.secondMainColor,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  ImageDefault.gridFour2x,
                ),
              ),
            ),
            Text(
              L(ViCode.genreOfStrTextInfo.toString()),
              style: FontsDefault.h5,
            )
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: ColorDefaults.secondMainColor,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  ImageDefault.translate2x,
                ),
              ),
            ),
            Text(
              L(ViCode.translateStrTextInfo.toString()),
              style: FontsDefault.h5,
            )
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: ColorDefaults.secondMainColor,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  ImageDefault.bookOpenText2x,
                ),
              ),
            ),
            Text(
              L(ViCode.fullStrTextInfo.toString()),
              style: FontsDefault.h5,
            )
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: ColorDefaults.secondMainColor,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  ImageDefault.vector2x,
                ),
              ),
            ),
            Text(
              L(ViCode.creationStrTextInfo.toString()),
              style: FontsDefault.h5,
            )
          ],
        )
      ],
    );
  }
}

// #endregion

// #region Category name included view all
class GroupCategoryTextInfo extends StatelessWidget {
  final String titleText;
  final Widget nextRoute;
  const GroupCategoryTextInfo(
      {super.key, required this.titleText, required this.nextRoute});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            titleText,
            style: FontsDefault.h5.copyWith(fontWeight: FontWeight.w700),
          ),
          RichText(
              text: TextSpan(
                  text: L(
                    ViCode.viewAllTextInfo.toString(),
                  ),
                  style:
                      FontsDefault.h5.copyWith(color: ColorDefaults.mainColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => nextRoute));
                    }))
        ]),
      ),
    );
  }
}

// #endregion

// #region Category name not included view all
class OnlyTitleTextInfo extends StatelessWidget {
  final String textInfo;
  const OnlyTitleTextInfo({super.key, required this.textInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: MainSetting.getPercentageOfDevice(context, expectHeight: 30)
              .height,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              textInfo,
              style: FontsDefault.h5.copyWith(fontWeight: FontWeight.w700),
            )
          ])),
    );
  }
}

// #endregion
