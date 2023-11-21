import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class DeviceInfo extends StatefulWidget {
  final Color fontColor;
  final Color backgroundColor;
  const DeviceInfo(
      {super.key, required this.fontColor, required this.backgroundColor});

  @override
  State<DeviceInfo> createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  @override
  void initState() {
    _batteryLevel = 0;
    super.initState();
    getBatteryLevel();
    getCurrentTime();
  }

  Future<void> getBatteryLevel() async {
    try {
      var level = (await BatteryInfoPlugin().iosBatteryInfo)!.batteryLevel;
      setState(() {
        _batteryLevel = level ?? 0;
      });
    } catch (e) {
      debugPrint("Error getting battery level: $e");
    }
  }

  IconData _getBatteryIcon() {
    if (_batteryLevel == 0) {
      return Icons.battery_0_bar_sharp;
    } else if (_batteryLevel == 100) {
      return Icons.battery_full;
    } else if (_batteryLevel >= 90) {
      return Icons.battery_6_bar_sharp;
    } else if (_batteryLevel >= 60) {
      return Icons.battery_5_bar_sharp;
    } else if (_batteryLevel >= 30) {
      return Icons.battery_4_bar_sharp;
    } else if (_batteryLevel >= 15) {
      return Icons.battery_3_bar_sharp;
    } else {
      return Icons.battery_alert_sharp;
    }
  }

  Future<void> getCurrentTime() async {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hm().format(now);
    setState(() {
      _currentTime = formattedTime;
    });
  }

  late String _currentTime = '';
  late int _batteryLevel;
  @override
  Widget build(BuildContext context) {
    var batteryIcon = _getBatteryIcon();
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _currentTime,
              style: CustomFonts.h6(context).copyWith(
                  fontSize: 13,
                  color: themeMode(context, ColorCode.textColor.name)),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              batteryIcon,
              size: 13,
              color: themeMode(context, ColorCode.textColor.name),
            ),
          ),
        ],
      ),
    );
  }
}
