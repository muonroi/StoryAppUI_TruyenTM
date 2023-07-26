import 'package:taxi/Settings/settings.language_code.vi..dart';
import 'package:taxi/Settings/settings.languages.dart';

class LocalizationLib {
  static final Map<String, Map<String, String>> _localizedValues = {
    Languages.en: {},
    Languages.vi: {
      ViCode.searchTextInfo.toString(): 'Tìm kiếm truyện',
      ViCode.notfoundTextInfo.toString(): 'Không tìm thấy tài nguyên',
      ViCode.genreOfStrTextInfo.toString(): 'Thể loại',
      ViCode.translateStrTextInfo.toString(): 'Truyện dịch',
      ViCode.creationStrTextInfo.toString(): 'Sáng tác',
      ViCode.fullStrTextInfo.toString(): 'Truyện full',
      ViCode.editorChoiceTextInfo.toString(): 'Lựa chọn biên tập viên',
      ViCode.viewAllTextInfo.toString(): 'Xem tất cả >',
      ViCode.newStoriesTextInfo.toString(): 'Truyện mới cập nhật',
    }
  };
  static String L(String key, {String locale = 'vi'}) {
    return _localizedValues[locale]![key] ??
        _localizedValues[locale]![ViCode.notfoundTextInfo.toString()]!;
  }
}
