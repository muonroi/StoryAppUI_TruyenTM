import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';

class PageControlBloc extends Cubit<int> {
  PageControlBloc() : super(0);

  late DynamicSize _dynamicSize = DynamicSizeImpl();
  late SplittedText _splittedText = SplittedTextImpl();
  late Size _size;
  late String _content;
  late List<String> _splittedTextList = [];
  List<String> get splittedTextList => _splittedTextList;

  getSizeFromBloc(GlobalKey pagekey) {
    _size = _dynamicSize.getSize(pagekey);
  }

  setContentFromBloc(String content) {
    _content = content;
  }

  getSplittedTextFromBloc(TextStyle textStyle) {
    _splittedTextList =
        _splittedText.getSplittedText(_size, textStyle, _content);
  }

  void changeState(int currentIndex) {
    emit(currentIndex);
  }

  void emit(int currentIndex) {}
}
