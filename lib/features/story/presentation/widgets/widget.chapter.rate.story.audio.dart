import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class RateSlider extends StatefulWidget {
  final double initValue;
  final int min;
  final int max;
  final Function(double)? onChange;
  const RateSlider(
      {super.key,
      required this.min,
      required this.max,
      required this.onChange,
      required this.initValue});

  @override
  State<RateSlider> createState() => _RateSliderState();
}

class _RateSliderState extends State<RateSlider> {
  @override
  void initState() {
    _localValue = widget.initValue * 1.0;
    super.initState();
  }

  late double _localValue;
  @override
  Widget build(BuildContext context) {
    return Slider(
        allowedInteraction: SliderInteraction.slideOnly,
        inactiveColor: themeMode(context, ColorCode.disableColor.name),
        activeColor: themeMode(context, ColorCode.mainColor.name),
        min: widget.min * 1.0,
        max: widget.max * 1.0,
        value: _localValue,
        onChanged: (value) async {
          setState(() {
            _localValue = value;
          });
          if (widget.onChange != null) {
            widget.onChange!(_localValue);
          }
        });
  }
}
