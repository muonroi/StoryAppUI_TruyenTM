import 'package:flutter/foundation.dart';
import 'package:muonroi/shared/Settings/Enums/emum.key.local.storage.dart';

class ButtonScrollSettings with ChangeNotifier {
  late KeyButtonScroll? locationButton;
  ButtonScrollSettings({this.locationButton});

  set valueSetting(KeyButtonScroll newValue) {
    locationButton = newValue;
    notifyListeners();
  }

  KeyButtonScroll? get value => locationButton;
}
