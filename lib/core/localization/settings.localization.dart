import 'package:muonroi/core/SignalR/enum/enum.signalr.type.dart';
import 'package:muonroi/core/localization/settings.language_code.vi..dart';
import 'package:muonroi/core/localization/settings.languages.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:sprintf/sprintf.dart';

class LocalizationLib {
  static final Map<String, Map<String, String>> _localizedValues = {
    Languages.en: {},
    Languages.vi: {
      ViCode.searchTextInfo.toString(): 'Tìm kiếm truyện',
      ViCode.notfoundTextInfo.toString(): 'Không xác định',
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
      ViCode.chapterNumberTextInfo.toString(): 'Chương',
      ViCode.rankTextInfo.toString(): 'Top',
      ViCode.storiesBoughtTextInfo.toString(): 'Đã mua',
      ViCode.storiesSavedTextInfo.toString(): 'Truyện đã tải',
      ViCode.storiesContinueChapterTextInfo.toString(): 'Đọc tiếp',
      ViCode.myAccountTextInfo.toString(): 'Tài khoản của tôi',
      ViCode.myAccountCoinTextInfo.toString(): 'Ngân lượng',
      ViCode.myAccountPremiumTextInfo.toString(): 'Nâng cấp tài khoản',
      ViCode.myAccountGiftCodeTextInfo.toString(): 'Mã khuyến mãi',
      ViCode.myAccountRechargeTextInfo.toString(): 'Nạp ngân lượng',
      ViCode.myAccountContactAdminTextInfo.toString(): 'Liên hệ & hỗ trợ',
      ViCode.myAccountDetailTextInfo.toString(): 'Tài khoản',
      ViCode.myAccountSettingTextInfo.toString(): 'Cài đặt',
      ViCode.voteStoryTextInfo.toString(): 'Đánh giá',
      ViCode.voteStoryTotalTextInfo.toString(): 'từ',
      ViCode.totalViewStoryTextInfo.toString(): 'Lượt xem',
      ViCode.totalFavoriteStoryTextInfo.toString(): 'Lượt thích',
      ViCode.introStoryTextInfo.toString(): 'Giới thiệu truyện',
      ViCode.notifyStoryTextInfo.toString(): 'Thông báo',
      ViCode.newChapterStoryTextInfo.toString(): 'Chương mới',
      ViCode.listChapterStoryTextInfo.toString(): 'Danh sách chương',
      ViCode.writeCommentStoryTextInfo.toString(): 'Viết đánh giá  ',
      ViCode.coinStoryTextInfo.toString(): 'Ngân lượng',
      ViCode.pushRechargeStoryTextInfo.toString(): 'Đẩy ngân lượng',
      ViCode.similarStoriesTextInfo.toString(): 'Truyện tương tự',
      ViCode.chapterEndTextInfo.toString(): "Hết!",
      ViCode.tagCompleteTextInfo.toString(): "hoàn thành",
      ViCode.nextChapterTextInfo.toString(): "Chương kế",
      ViCode.previousChapterTextInfo.toString(): "Chương trước",
      ViCode.loadingTextInfo.toString(): "Đang tải",
      ViCode.loadingMoreTextInfo.toString(): "Vuốt xuống để tải tiếp",
      ViCode.loadingPreviousTextInfo.toString(): "Vuốt lên để tải tiếp",
      ViCode.customDashboardReadingTextInfo.toString(): "Tuỳ chỉnh giao diện",
      ViCode.defaultDashboardTextInfo.toString(): "Giao diện mẫu",
      ViCode.customAnotherDashboardTextInfo.toString(): "Tuỳ chỉnh",
      ViCode.scrollConfigDashboardTextInfo.toString(): "Cuộn",
      ViCode.scrollConfigVerticalDashboardTextInfo.toString(): "Cuộn dọc",
      ViCode.scrollConfigHorizontalDashboardTextInfo.toString(): "Cuộn ngang",
      ViCode.buttonScrollConfigDashboardTextInfo.toString(): "Nút cuộn",
      ViCode.buttonScrollConfigNoneDashboardTextInfo.toString(): "Ẩn",
      ViCode.buttonScrollConfigDisplayDashboardTextInfo.toString(): "Hiện",
      ViCode.alignConfigDashboardTextInfo.toString(): "Căn Lề",
      ViCode.alignConfigLeftDashboardTextInfo.toString(): "Căn trái",
      ViCode.alignConfigRegularDashboardTextInfo.toString(): "Căn đều",
      ViCode.fontConfigDashboardTextInfo.toString(): "Kiểu chữ",
      ViCode.fontSizeConfigDashboardTextInfo.toString(): "Cỡ chữ",
      ViCode.fontColorConfigDashboardTextInfo.toString(): "Màu chữ",
      ViCode.backgroundConfigDashboardTextInfo.toString(): "Màu nền",
      ViCode.limitFontSizeConfigTextInfo.toString():
          "Cỡ chữ nằm trong khoảng (10-50)",
      ViCode.listChapterDetailConfigTextInfo.toString(): "Ds Chương",
      ViCode.storyDetailConfigTextInfo.toString(): "TT Truyện",
      ViCode.storyDownloadConfigTextInfo.toString(): "Tải về",
      ViCode.storyPushCoinConfigTextInfo.toString(): "Ném tiền",
      ViCode.storyShareConfigTextInfo.toString(): "Chia sẻ",
      ViCode.storyReportConfigTextInfo.toString(): "Báo lỗi",
      ViCode.signinConfigTextInfo.toString(): "Đăng nhập",
      ViCode.signupConfigTextInfo.toString(): "Đăng kí",
      ViCode.inputUsernameTextConfigTextInfo.toString(): "Tài khoản",
      ViCode.inputPasswordTextConfigTextInfo.toString(): "Mật khẩu",
      ViCode.noHaveAccountTextConfigTextInfo.toString(): "Chưa có tài khoản?",
      ViCode.inValidAccountTextConfigTextInfo.toString():
          "Tài khoản hoặc mật khẩu không hợp lệ!",
      ViCode.publishStoryTextConfigTextInfo.toString():
          "Truyện %s - %s Vừa được công bố!",
      ViCode.notificationTextConfigTextInfo.toString(): "Thông báo",
      ViCode.notificationByUserTextConfigTextInfo.toString():
          "Người dùng %s vừa theo dõi truyện %s của bạn",
      ViCode.downloadedTextInfo.toString(): "Đã tải",
      ViCode.ChaptersDownloadDeletedTextInfo.toString():
          "Đã xoá chương %s khỏi bộ nhớ",
      ViCode.ChaptersDownloadAddedTextInfo.toString():
          "Tải xuống %s chương thành công",
      ViCode.recentlyStoryTextInfo.toString(): "Không tìm thấy truyện gần đây",
      ViCode.upgradeAccountTextInfo.toString(): "Nâng cấp tài khoản",
      ViCode.buyNowTextInfo.toString(): "Mua ngay",
      ViCode.monthTextInfo.toString(): "Tháng",
      ViCode.customerBenefitsTextInfo.toString(): "Quyền lợi khách hàng",
      ViCode.oneLawsUpgradeAccountTextInfo.toString():
          "Sử dụng ứng dụng không có quảng cáo",
      ViCode.logoutAccountTextInfo.toString(): "Đăng xuất",
      ViCode.contactTextInfo.toString(): "Liên hệ & Hỗ trợ",
      ViCode.contactToEmailTextInfo.toString(): "Liên hệ qua email",
      ViCode.askCommonTextInfo.toString(): "Câu hỏi thường gặp",
      ViCode.privacyTextInfo.toString(): "Quy định quyền riêng tư",
      ViCode.privacyTermsTextInfo.toString(): "Điều khoản bảo mật",
      ViCode.followUserTextInfo.toString(): "Theo dõi",
      ViCode.inboxTextInfo.toString(): "Nhắn tin",
      ViCode.gmailUserTextInfo.toString(): "Gmail",
      ViCode.phoneNumberTextInfo.toString(): "Số điện thoại",
      ViCode.birthdayUserTextInfo.toString(): "Ngày sinh",
      ViCode.addressUserTextInfo.toString(): "Địa chỉ",
      ViCode.themeModeTextInfo.toString(): "Giao diện",
      ViCode.lightModeTextInfo.toString(): "Sáng",
      ViCode.darkModeTextInfo.toString(): "Tối",
      ViCode.forgotPasswordTextInfo.toString(): 'Quên mật khẩu',
      ViCode.invalidAccountTextInfo.toString():
          'Tên tài khoản hoặc mật khẩu không chính xác',
      ViCode.rememberTextInfo.toString(): 'Ghi nhớ',
      ViCode.forgotPasswordMoreInfoTextInfo.toString():
          'Một liên kết đặt lại mật khẩu sẽ được gửi đến email của bạn để đặt lại mật khẩu. Nếu bạn không nhận được email trong vòng vài phút, vui lòng thử lại.',
      ViCode.notificationTextInfo.toString(): 'Thông báo',
      ViCode.sendTextInfo.toString(): 'Đã gửi',
      ViCode.ignoreTextInfo.toString(): 'Đã hiểu',
      ViCode.sendPasswordSuccessTextInfo.toString():
          'Một liên kết đặt lại mật khẩu được gửi đến địa chỉ email của bạn. Vui lòng kiểm tra email của bạn.',
      ViCode.backInfoTextInfo.toString(): 'Quay lại',
      ViCode.submitTextInfo.toString(): 'Gửi',
      ViCode.isSureTextInfo.toString(): 'Đồng ý',
      ViCode.isNotSureTextInfo.toString(): 'Không',
      ViCode.youSureLogoutTextInfo.toString(): 'Bạn có muốn đăng xuất không?',
    }
  };
  static String L(String key, {String locale = 'vi'}) {
    return _localizedValues[locale]![key] ??
        _localizedValues[locale]![ViCode.notfoundTextInfo.toString()]!;
  }

  static String N(int type, {String locale = 'vi', List<String>? args}) {
    String key = ViCode.notfoundTextInfo.toString();
    String textResult = '';
    switch (intToEnum(type)) {
      case TypeSignalr.Global:
        key = ViCode.notfoundTextInfo.toString();
        break;
      case TypeSignalr.StoryFavorite:
        key = ViCode.publishStoryTextConfigTextInfo.toString();
        var textInfo = L(key);
        textResult = sprintf(textInfo, args);
        break;
      case TypeSignalr.VoteStory:
        key = ViCode.notfoundTextInfo.toString();
        break;
      case TypeSignalr.BookmarkStory:
        key = ViCode.notificationByUserTextConfigTextInfo.toString();
        var textInfo = L(key);
        textResult = sprintf(textInfo, args);
        break;
      default:
        key = ViCode.notfoundTextInfo.toString();
    }
    return textResult;
  }
}
