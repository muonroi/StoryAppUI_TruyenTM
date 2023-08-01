import 'package:flutter/material.dart';
import '../../../Settings/settings.buttons.dart';
import '../../../Settings/settings.colors.dart';

class ButtonWidget {
  static Widget buttonNavigatorNextPreviewLanding(
      BuildContext context, Widget nextRoute,
      {String textDisplay = 'Next'}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextRoute),
        );
      },
      style: ButtonDefaults.buttonNextPagePreview,
      child: Text(textDisplay),
    );
  }

  static Widget buttonDisplayCurrentPage(Size value, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? value.height * 1 / 59 : value.height * 1 / 59,
      width: isActive ? value.width * 1 / 7 : value.height * 1 / 59,
      decoration: BoxDecoration(
          shape: !isActive ? BoxShape.circle : BoxShape.rectangle,
          border: Border.all(color: ColorDefaults.borderButtonPreviewPage),
          borderRadius: isActive
              ? const BorderRadius.vertical(
                  top: Radius.circular(20), bottom: Radius.circular(20))
              : null,
          color: isActive
              ? ColorDefaults.borderButtonPreviewPage
              : ColorDefaults.mainColor),
    );
  }
}
