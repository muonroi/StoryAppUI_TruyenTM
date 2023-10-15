import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  bool _isViewAll = false;
  int _totalNotification = 0;
  NotificationProvider() {
    _loadTotalNotification();
  }
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
    notifyListeners();
  }

  Future<void> _loadTotalNotification() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (_totalNotification == 0) {
      _totalNotification = sharedPreferences.getInt('totalNotification') ?? 0;
    }
    notifyListeners();
  }
}
