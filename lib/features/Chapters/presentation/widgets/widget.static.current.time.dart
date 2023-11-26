import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';

class UpdateCurrentTime extends StatefulWidget {
  final Color tempColor;
  const UpdateCurrentTime({super.key, required this.tempColor});

  @override
  State<UpdateCurrentTime> createState() => _UpdateCurrentTimeState();
}

class _UpdateCurrentTimeState extends State<UpdateCurrentTime> {
  @override
  void initState() {
    _currentTime = '';
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
    getCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          setState(() {
            getCurrentTime();
          });
        }
      });
    });
  }

  Future<void> getCurrentTime() async {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hm().format(now);
    setState(() {
      _currentTime = formattedTime;
    });
  }

  late Timer _timer;
  late String _currentTime;
  @override
  Widget build(BuildContext context) {
    return Text(
      _currentTime,
      style: CustomFonts.h6(context)
          .copyWith(color: widget.tempColor, fontSize: 13),
      textAlign: TextAlign.center,
    );
  }
}
