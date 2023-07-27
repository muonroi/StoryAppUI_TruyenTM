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
      ViCode.newUpdatedStoriesTextInfo.toString(): 'Truyện mới cập nhật',
      ViCode.commonOfStoriesTextInfo.toString(): 'Top truyện phổ biến',
      ViCode.allCommonStoriesTextInfo.toString(): 'Tất cả',
      ViCode.commonStoriesOfDayTextInfo.toString(): 'Top ngày',
      ViCode.commonStoriesOfWeekTextInfo.toString(): 'Top tuần',
      ViCode.commonStoriesOfMonthTextInfo.toString(): 'Top tháng',
      ViCode.newStoriesTextInfo.toString(): 'Truyện mới ra mắt',
      ViCode.completeStoriesTextInfo.toString(): 'Truyện đã hoàn thành',
      ViCode.newChapterUpdatedTextInfo.toString(): 'Chương mới cập nhật',
      ViCode.homePageTextInfo.toString(): 'Trang chủ',
      ViCode.bookCaseTextInfo.toString(): 'Tủ sách',
      ViCode.freeStoriesTextInfo.toString(): 'Truyện miễn phí',
      ViCode.userInfoTextInfo.toString(): 'Cá nhân',
    }
  };
  static String L(String key, {String locale = 'vi'}) {
    return _localizedValues[locale]![key] ??
        _localizedValues[locale]![ViCode.notfoundTextInfo.toString()]!;
  }
}
