import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  bool _isViewAll = false;
  int _totalNotification = 0;
  bool get isViewAll => _isViewAll;
  int get totalNotification => _totalNotification;
  set setViewAll(bool isViewAll) {
    _isViewAll = isViewAll;
    Future.delayed(const Duration(seconds: 2), () {
      notifyListeners();
    });
  }

  set setTotalView(int viewTotal) {
    _totalNotification = viewTotal;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        notifyListeners();
      });
    });
  }
}
