import 'dart:async';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';

class GetBatteryStatus extends StatefulWidget {
  final Color tempColor;
  const GetBatteryStatus({super.key, required this.tempColor});

  @override
  State<GetBatteryStatus> createState() => _GetBatteryStatusState();
}

class _GetBatteryStatusState extends State<GetBatteryStatus> {
  @override
  void initState() {
    _batteryIcon = Icons.battery_0_bar_sharp;
    _batteryLevel = 0;
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getBatteryLevel();
    _timer = Timer.periodic(const Duration(minutes: 10), (timer) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          setState(() {
            getBatteryLevel();
          });
        }
      });
    });
  }

  Future<void> getBatteryLevel() async {
    try {
      var level = (await BatteryInfoPlugin().iosBatteryInfo)!.batteryLevel;
      setState(() {
        _batteryLevel = level ?? 0;
        _batteryIcon = _getBatteryIcon();
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

  late Timer _timer;
  late int _batteryLevel;
  late IconData _batteryIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Icon(
        _batteryIcon,
        size: 13,
        color: widget.tempColor,
      ),
    );
  }
}
