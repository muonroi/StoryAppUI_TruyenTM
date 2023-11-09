import 'package:muonroi/shared/models/signalR/enum/enum.signalr.type.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/core/localization/settings.languages.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:sprintf/sprintf.dart';

class LocalizationLib {
  static final Map<String, Map<String, String>> _localizedValues = {
    Languages.en: {},
    Languages.vi: {
      LanguageCodes.searchTextInfo.toString():
          'Nhập tên truyện, tên tác giả,...',
      LanguageCodes.emptyChapterTextInfo.toString(): 'Đang cập nhật',
      LanguageCodes.notfoundTextInfo.toString(): 'Không xác định',
      LanguageCodes.genreOfStrTextInfo.toString(): 'Thể loại',
      LanguageCodes.hotStoriesTextInfo.toString(): 'Truyện hot',
      LanguageCodes.completeStoriesHomeTextInfo.toString(): 'Hoàn thành',
      LanguageCodes.newStoriesHomeTextInfo.toString(): 'Truyện mới',
      LanguageCodes.trendStoriesTextInfo.toString(): 'Truyện tiêu biểu',
      LanguageCodes.viewAllTextInfo.toString(): 'Xem tất cả >',
      LanguageCodes.newUpdatedStoriesTextInfo.toString(): 'Truyện mới cập nhật',
      LanguageCodes.commonOfStoriesTextInfo.toString(): 'Top truyện phổ biến',
      LanguageCodes.allCommonStoriesTextInfo.toString(): 'Tất cả',
      LanguageCodes.commonStoriesOfDayTextInfo.toString(): 'Top ngày',
      LanguageCodes.commonStoriesOfWeekTextInfo.toString(): 'Top tuần',
      LanguageCodes.commonStoriesOfMonthTextInfo.toString(): 'Top tháng',
      LanguageCodes.newStoriesTextInfo.toString(): 'Truyện mới ra mắt',
      LanguageCodes.completeStoriesTextInfo.toString(): 'Truyện đã hoàn thành',
      LanguageCodes.newChapterUpdatedTextInfo.toString(): 'Chương mới cập nhật',
      LanguageCodes.homePageTextInfo.toString(): 'Trang chủ',
      LanguageCodes.recentStoriesTextInfo.toString(): 'Gần đây',
      LanguageCodes.freeStoriesTextInfo.toString(): 'Truyện miễn phí',
      LanguageCodes.userInfoTextInfo.toString(): 'Cá nhân',
      LanguageCodes.passedNumberMinuteTextInfo.toString(): 'phút trước',
      LanguageCodes.chapterNumberTextInfo.toString(): 'Chương',
      LanguageCodes.rankTextInfo.toString(): 'Top',
      LanguageCodes.savedStoriesTextInfo.toString(): 'Đã tải',
      LanguageCodes.bookmarkStoriesTextInfo.toString(): 'Tủ sách',
      LanguageCodes.storiesContinueChapterTextInfo.toString(): 'Đọc tiếp',
      LanguageCodes.myAccountTextInfo.toString(): 'Tài khoản của tôi',
      LanguageCodes.myAccountCoinTextInfo.toString(): 'Ngân lượng',
      LanguageCodes.myAccountPremiumTextInfo.toString(): 'Nâng cấp tài khoản',
      LanguageCodes.myAccountGiftCodeTextInfo.toString(): 'Mã khuyến mãi',
      LanguageCodes.myAccountRechargeTextInfo.toString(): 'Nạp ngân lượng',
      LanguageCodes.myAccountContactAdminTextInfo.toString():
          'Liên hệ & hỗ trợ',
      LanguageCodes.myAccountDetailTextInfo.toString(): 'Tài khoản',
      LanguageCodes.myAccountSettingTextInfo.toString(): 'Cài đặt',
      LanguageCodes.voteStoryTextInfo.toString(): 'Đánh giá',
      LanguageCodes.voteStoryTotalTextInfo.toString(): 'từ',
      LanguageCodes.totalViewStoryTextInfo.toString(): 'Lượt xem',
      LanguageCodes.totalFavoriteStoryTextInfo.toString(): 'Lượt thích',
      LanguageCodes.introStoryTextInfo.toString(): 'Giới thiệu truyện',
      LanguageCodes.notifyStoryTextInfo.toString(): 'Thông báo',
      LanguageCodes.newChapterStoryTextInfo.toString(): 'Chương mới',
      LanguageCodes.listChapterStoryTextInfo.toString(): 'Danh sách chương',
      LanguageCodes.writeCommentStoryTextInfo.toString(): 'Viết đánh giá  ',
      LanguageCodes.coinStoryTextInfo.toString(): 'Ngân lượng',
      LanguageCodes.pushRechargeStoryTextInfo.toString(): 'Đẩy ngân lượng',
      LanguageCodes.similarStoriesTextInfo.toString(): 'Truyện tương tự',
      LanguageCodes.chapterEndTextInfo.toString(): "Hết!",
      LanguageCodes.tagCompleteTextInfo.toString(): "hoàn thành",
      LanguageCodes.nextChapterTextInfo.toString(): "Chương kế",
      LanguageCodes.previousChapterTextInfo.toString(): "Chương trước",
      LanguageCodes.loadingTextInfo.toString(): "Đang tải",
      LanguageCodes.loadingMoreTextInfo.toString(): "Vuốt xuống để tải tiếp",
      LanguageCodes.loadingPreviousTextInfo.toString(): "Vuốt lên để tải tiếp",
      LanguageCodes.customDashboardReadingTextInfo.toString():
          "Tuỳ chỉnh giao diện",
      LanguageCodes.defaultDashboardTextInfo.toString(): "Giao diện mẫu",
      LanguageCodes.customAnotherDashboardTextInfo.toString(): "Tuỳ chỉnh",
      LanguageCodes.scrollConfigDashboardTextInfo.toString(): "Cuộn",
      LanguageCodes.scrollConfigVerticalDashboardTextInfo.toString():
          "Cuộn dọc",
      LanguageCodes.scrollConfigHorizontalDashboardTextInfo.toString():
          "Cuộn ngang",
      LanguageCodes.buttonScrollConfigDashboardTextInfo.toString(): "Nút cuộn",
      LanguageCodes.buttonScrollConfigNoneDashboardTextInfo.toString(): "Ẩn",
      LanguageCodes.buttonScrollConfigDisplayDashboardTextInfo.toString():
          "Hiện",
      LanguageCodes.alignConfigDashboardTextInfo.toString(): "Căn Lề",
      LanguageCodes.alignConfigLeftDashboardTextInfo.toString(): "Căn trái",
      LanguageCodes.alignConfigRegularDashboardTextInfo.toString(): "Căn đều",
      LanguageCodes.fontConfigDashboardTextInfo.toString(): "Kiểu chữ",
      LanguageCodes.fontSizeConfigDashboardTextInfo.toString(): "Cỡ chữ",
      LanguageCodes.fontColorConfigDashboardTextInfo.toString(): "Màu chữ",
      LanguageCodes.backgroundConfigDashboardTextInfo.toString(): "Màu nền",
      LanguageCodes.limitFontSizeConfigTextInfo.toString():
          "Cỡ chữ nằm trong khoảng (10-50)",
      LanguageCodes.listChapterDetailConfigTextInfo.toString(): "Ds Chương",
      LanguageCodes.storyDetailConfigTextInfo.toString(): "TT Truyện",
      LanguageCodes.storyDownloadConfigTextInfo.toString(): "Tải về",
      LanguageCodes.storyPushCoinConfigTextInfo.toString(): "Ném tiền",
      LanguageCodes.storyShareConfigTextInfo.toString(): "Chia sẻ",
      LanguageCodes.storyReportConfigTextInfo.toString(): "Báo lỗi",
      LanguageCodes.signinConfigTextInfo.toString(): "Đăng nhập",
      LanguageCodes.signupConfigTextInfo.toString(): "Đăng kí",
      LanguageCodes.inputUsernameTextConfigTextInfo.toString(): "Tài khoản",
      LanguageCodes.inputPasswordTextConfigTextInfo.toString(): "Mật khẩu",
      LanguageCodes.noHaveAccountTextConfigTextInfo.toString():
          "Chưa có tài khoản?",
      LanguageCodes.inValidAccountTextConfigTextInfo.toString():
          "Tài khoản hoặc mật khẩu không hợp lệ!",
      LanguageCodes.publishStoryTextConfigTextInfo.toString():
          "Truyện %s - %s Vừa được công bố!",
      LanguageCodes.notificationTextConfigTextInfo.toString(): "Thông báo",
      LanguageCodes.notificationByUserTextConfigTextInfo.toString():
          "Người dùng %s vừa theo dõi truyện %s của bạn",
      LanguageCodes.downloadedTextInfo.toString(): "Đã tải",
      LanguageCodes.chaptersDownloadDeletedTextInfo.toString():
          "Đã xoá chương %s khỏi bộ nhớ",
      LanguageCodes.chaptersDownloadAddedTextInfo.toString():
          "Tải xuống %s chương thành công",
      LanguageCodes.recentlyStoryTextInfo.toString():
          "Không tìm thấy truyện gần đây",
      LanguageCodes.upgradeAccountTextInfo.toString(): "Nâng cấp tài khoản",
      LanguageCodes.buyNowTextInfo.toString(): "Mua ngay",
      LanguageCodes.monthTextInfo.toString(): "Tháng",
      LanguageCodes.customerBenefitsTextInfo.toString(): "Quyền lợi khách hàng",
      LanguageCodes.oneLawsUpgradeAccountTextInfo.toString():
          "Sử dụng ứng dụng không có quảng cáo",
      LanguageCodes.logoutAccountTextInfo.toString(): "Đăng xuất",
      LanguageCodes.contactTextInfo.toString(): "Liên hệ & Hỗ trợ",
      LanguageCodes.contactToEmailTextInfo.toString(): "Liên hệ qua email",
      LanguageCodes.askCommonTextInfo.toString(): "Câu hỏi thường gặp",
      LanguageCodes.privacyTextInfo.toString(): "Quy định quyền riêng tư",
      LanguageCodes.privacyTermsTextInfo.toString(): "Điều khoản bảo mật",
      LanguageCodes.followUserTextInfo.toString(): "Theo dõi",
      LanguageCodes.inboxTextInfo.toString(): "Nhắn tin",
      LanguageCodes.gmailUserTextInfo.toString(): "Gmail",
      LanguageCodes.phoneNumberTextInfo.toString(): "Số điện thoại",
      LanguageCodes.birthdayUserTextInfo.toString(): "Ngày sinh",
      LanguageCodes.addressUserTextInfo.toString(): "Địa chỉ",
      LanguageCodes.themeModeTextInfo.toString(): "Giao diện",
      LanguageCodes.lightModeTextInfo.toString(): "Sáng",
      LanguageCodes.darkModeTextInfo.toString(): "Tối",
      LanguageCodes.forgotPasswordTextInfo.toString(): 'Quên mật khẩu',
      LanguageCodes.invalidAccountTextInfo.toString():
          'Tên tài khoản hoặc mật khẩu không chính xác',
      LanguageCodes.rememberTextInfo.toString(): 'Ghi nhớ',
      LanguageCodes.forgotPasswordMoreInfoTextInfo.toString():
          'Một liên kết đặt lại mật khẩu sẽ được gửi đến email của bạn để đặt lại mật khẩu. Nếu bạn không nhận được email trong vòng vài phút, vui lòng thử lại.',
      LanguageCodes.notificationTextInfo.toString(): 'Thông báo',
      LanguageCodes.sendTextInfo.toString(): 'Đã gửi',
      LanguageCodes.ignoreTextInfo.toString(): 'Đã hiểu',
      LanguageCodes.sendPasswordSuccessTextInfo.toString():
          'Một liên kết đặt lại mật khẩu được gửi đến địa chỉ email của bạn. Vui lòng kiểm tra email của bạn.',
      LanguageCodes.backInfoTextInfo.toString(): 'Quay lại',
      LanguageCodes.submitTextInfo.toString(): 'Gửi',
      LanguageCodes.isSureTextInfo.toString(): 'Đồng ý',
      LanguageCodes.isNotSureTextInfo.toString(): 'Không',
      LanguageCodes.youSureLogoutTextInfo.toString():
          'Bạn có muốn đăng xuất không?',
      LanguageCodes.invalidEmailTextInfo.toString(): 'Email không hợp lệ',
      LanguageCodes.invalidPhoneNumberTextInfo.toString():
          'Không đúng định dạng',
      LanguageCodes.changeNameTextInfo.toString(): 'Thay đổi tên của bạn',
      LanguageCodes.changeUserInfoTextInfo.toString():
          'Thay đổi thông tin thành công',
      LanguageCodes.viewNotificationAllTextInfo.toString(): 'Xem tất cả',
      LanguageCodes.successTextInfo.toString(): 'Thành công',
      LanguageCodes.unSuccessTextInfo.toString(): 'Thất bại',
      LanguageCodes.noDataTextInfo.toString(): 'Không có dữ liệu',
      LanguageCodes.viewNextNotificationTextInfo.toString(): 'Xem tiếp',
      LanguageCodes.viewPreviousNotificationTextInfo.toString(): 'Lùi về',
    }
  };
  static String L(String key, {String locale = 'vi'}) {
    return _localizedValues[locale]![key] ??
        _localizedValues[locale]![LanguageCodes.notfoundTextInfo.toString()]!;
  }

  static String N(int type, {String locale = 'vi', List<String>? args}) {
    String key = LanguageCodes.notfoundTextInfo.toString();
    String textResult = '';
    switch (intToEnum(type)) {
      case TypeSignalr.global:
        key = LanguageCodes.notfoundTextInfo.toString();
        break;
      case TypeSignalr.storyFavorite:
        key = LanguageCodes.publishStoryTextConfigTextInfo.toString();
        var textInfo = L(key);
        textResult = sprintf(textInfo, args);
        break;
      case TypeSignalr.voteStory:
        key = LanguageCodes.notfoundTextInfo.toString();
        break;
      case TypeSignalr.bookmarkStory:
        key = LanguageCodes.notificationByUserTextConfigTextInfo.toString();
        var textInfo = L(key);
        textResult = sprintf(textInfo, args);
        break;
      default:
        key = LanguageCodes.notfoundTextInfo.toString();
    }
    return textResult;
  }
}
