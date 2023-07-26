import 'package:flutter/material.dart';
import '../../Settings/settings.colors.dart';
import '../../Settings/settings.fonts.dart';
import '../../Settings/settings.images.dart';
import '../../Settings/settings.language_code.vi..dart';
import '../../Settings/settings.main.dart';

class CategoriesStr extends StatefulWidget {
  const CategoriesStr({super.key});
  @override
  State<CategoriesStr> createState() => _CategoriesStrState();
}

class _CategoriesStrState extends State<CategoriesStr> {
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
