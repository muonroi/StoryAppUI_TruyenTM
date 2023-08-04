import 'package:flutter/material.dart';
import '../../../Settings/settings.colors.dart';

class ButtonWidget {
  static Widget buttonNavigatorNextPreviewLanding(
      BuildContext context, Widget nextRoute,
      {String textDisplay = 'Next',
      TextStyle textStyle = const TextStyle(
          fontFamily: "Inter",
          fontSize: 16,
          color: ColorDefaults.defaultTextColor),
      Color color = ColorDefaults.mainColor,
      Color borderColor = ColorDefaults.mainColor,
      double widthBorder = 2}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextRoute),
        );
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const StadiumBorder(),
          side: BorderSide(color: borderColor, width: widthBorder)),
      child: Text(
        textDisplay,
        style: textStyle,
      ),
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
