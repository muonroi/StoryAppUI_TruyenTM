import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.languages.dart';

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
      ViCode.passedNumberMinuteTextInfo.toString(): 'phút trước',
      ViCode.chapterNumberTextInfo.toString(): 'chương',
      ViCode.rankTextInfo.toString(): 'Top',
      ViCode.storiesBoughtTextInfo.toString(): 'Truyện đã mua',
      ViCode.storiesSavedTextInfo.toString(): 'Truyện đã tải',
      ViCode.storiesContinueChapterTextInfo.toString(): 'Đọc tiếp',
      ViCode.myAccountTextInfo.toString(): 'Tài khoản của tôi',
      ViCode.myAccountCoinTextInfo.toString(): 'Ngân lượng',
      ViCode.myAccountPremiumTextInfo.toString(): 'Nâng cấp tài khoản',
      ViCode.myAccountGiftCodeTextInfo.toString(): 'Mã khuyến mãi',
      ViCode.myAccountPopupTextInfo.toString(): 'Nạp ngân lượng',
      ViCode.myAccountContactAdminTextInfo.toString(): 'Liên hệ & hỗ trợ',
      ViCode.myAccountDetailTextInfo.toString(): 'Tài khoản',
      ViCode.myAccountSettingTextInfo.toString(): 'Cài đặt'
    }
  };
  static String L(String key, {String locale = 'vi'}) {
    return _localizedValues[locale]![key] ??
        _localizedValues[locale]![ViCode.notfoundTextInfo.toString()]!;
  }
}
