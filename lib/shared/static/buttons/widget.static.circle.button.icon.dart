import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.main.dart';

class CircleButtonIcon extends StatelessWidget {
  final Icon icon;
  final Color? color;
  final double borderSize;
  final VoidCallback action;
  final EdgeInsetsGeometry? margin;
  final String? tooltip;
  const CircleButtonIcon({
    Key? key,
    required this.icon,
    this.color,
    required this.borderSize,
    required this.action,
    this.margin,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 12.0),
        padding: EdgeInsets.all(borderSize),
        decoration: BoxDecoration(
            color: color ?? themMode(context, ColorCode.disableColor.name),
            borderRadius: BorderRadius.circular(borderSize)),
        child: icon,
      ),
      Positioned.fill(
          child: InkWell(
              borderRadius: BorderRadius.circular(borderSize),
              onTap: action,
              child: TooltipTheme(
                data: TooltipThemeData(
                  decoration: BoxDecoration(
                    color: themMode(context, ColorCode.mainColor.name),
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Tooltip(
                  message: tooltip,
                  child: Container(
                    margin:
                        margin ?? const EdgeInsets.symmetric(horizontal: 12.0),
                    padding: EdgeInsets.all(borderSize),
                    decoration: BoxDecoration(
                        color: color ??
                            themMode(context, ColorCode.disableColor.name),
                        borderRadius: BorderRadius.circular(borderSize)),
                    child: icon,
                  ),
                ),
              )))
    ]);
  }
}
