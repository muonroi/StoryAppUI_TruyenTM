import 'package:muonroi/shared/models/signalR/enum/enum.signalr.type.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/core/localization/settings.languages.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:sprintf/sprintf.dart';

class LocalizationLib {
  static final Map<String, Map<String, String>> _localizedValues = {
    Languages.en: {
      LanguageCodes.searchTextInfo.toString():
          'Enter story name, author name,...',
      LanguageCodes.emptyChapterTextInfo.toString(): 'Updating',
      LanguageCodes.notfoundTextInfo.toString(): 'Not found',
      LanguageCodes.genreOfStrTextInfo.toString(): 'Genre',
      LanguageCodes.hotStoriesTextInfo.toString(): 'Hot stories',
      LanguageCodes.completeStoriesHomeTextInfo.toString(): 'Completed',
      LanguageCodes.newStoriesHomeTextInfo.toString(): 'New stories',
      LanguageCodes.trendStoriesTextInfo.toString(): 'Trending stories',
      LanguageCodes.viewAllTextInfo.toString(): 'View all >',
      LanguageCodes.newUpdatedStoriesTextInfo.toString():
          'Newly updated stories',
      LanguageCodes.commonOfStoriesTextInfo.toString(): 'Top popular stories',
      LanguageCodes.allCommonStoriesTextInfo.toString(): 'All',
      LanguageCodes.commonStoriesOfDayTextInfo.toString(): 'Top of the day',
      LanguageCodes.commonStoriesOfWeekTextInfo.toString(): 'Top of the week',
      LanguageCodes.commonStoriesOfMonthTextInfo.toString(): 'Top of the month',
      LanguageCodes.newStoriesTextInfo.toString(): 'Newly released stories',
      LanguageCodes.completeStoriesTextInfo.toString(): 'Completed stories',
      LanguageCodes.newChapterUpdatedTextInfo.toString(): 'New chapter updated',
      LanguageCodes.homePageTextInfo.toString(): 'Home',
      LanguageCodes.recentStoriesTextInfo.toString(): 'Recent',
      LanguageCodes.freeStoriesTextInfo.toString(): 'Free stories',
      LanguageCodes.userInfoTextInfo.toString(): 'Profile',
      LanguageCodes.passedNumberMinuteTextInfo.toString(): 'minutes ago',
      LanguageCodes.chapterNumberTextInfo.toString(): 'Chapter',
      LanguageCodes.rankTextInfo.toString(): 'Top',
      LanguageCodes.savedStoriesTextInfo.toString(): 'Downloaded',
      LanguageCodes.bookmarkStoriesTextInfo.toString(): 'Bookmarks',
      LanguageCodes.storiesContinueChapterTextInfo.toString():
          'Continue reading',
      LanguageCodes.myAccountTextInfo.toString(): 'My account',
      LanguageCodes.myAccountCoinTextInfo.toString(): 'Coins',
      LanguageCodes.myAccountPremiumTextInfo.toString(): 'Upgrade account',
      LanguageCodes.myAccountGiftCodeTextInfo.toString(): 'Promo code',
      LanguageCodes.myAccountRechargeTextInfo.toString(): 'Recharge coins',
      LanguageCodes.myAccountContactAdminTextInfo.toString():
          'Contact & Support',
      LanguageCodes.myAccountDetailTextInfo.toString(): 'Account details',
      LanguageCodes.myAccountSettingTextInfo.toString(): 'Settings',
      LanguageCodes.voteStoryTextInfo.toString(): 'Rate',
      LanguageCodes.voteStoryTotalTextInfo.toString(): 'from',
      LanguageCodes.totalViewStoryTextInfo.toString(): 'Views',
      LanguageCodes.totalFavoriteStoryTextInfo.toString(): 'Likes',
      LanguageCodes.introStoryTextInfo.toString(): 'Story introduction',
      LanguageCodes.notifyStoryTextInfo.toString(): 'Notifications',
      LanguageCodes.newChapterStoryTextInfo.toString(): 'New chapter',
      LanguageCodes.listChapterStoryTextInfo.toString(): 'Chapter list',
      LanguageCodes.writeCommentStoryTextInfo.toString(): 'Write a review',
      LanguageCodes.coinStoryTextInfo.toString(): 'Coins',
      LanguageCodes.pushRechargeStoryTextInfo.toString(): 'Top up coins',
      LanguageCodes.similarStoriesTextInfo.toString(): 'Similar stories',
      LanguageCodes.chapterEndTextInfo.toString(): 'End!',
      LanguageCodes.tagCompleteTextInfo.toString(): 'completed',
      LanguageCodes.nextChapterTextInfo.toString(): 'Next chapter',
      LanguageCodes.previousChapterTextInfo.toString(): 'Previous chapter',
      LanguageCodes.loadingTextInfo.toString(): 'Loading',
      LanguageCodes.loadingMoreTextInfo.toString(): 'Swipe down to load more',
      LanguageCodes.loadingPreviousTextInfo.toString():
          'Swipe up to load previous',
      LanguageCodes.customDashboardReadingTextInfo.toString():
          'Customize layout',
      LanguageCodes.defaultDashboardTextInfo.toString(): 'Default layout',
      LanguageCodes.customAnotherDashboardTextInfo.toString(): 'Customize',
      LanguageCodes.scrollConfigDashboardTextInfo.toString(): 'Scroll',
      LanguageCodes.scrollConfigVerticalDashboardTextInfo.toString():
          'Vertical scroll',
      LanguageCodes.scrollConfigHorizontalDashboardTextInfo.toString():
          'Horizontal scroll',
      LanguageCodes.buttonScrollConfigDashboardTextInfo.toString():
          'Button scroll',
      LanguageCodes.buttonScrollConfigNoneDashboardTextInfo.toString(): 'Hide',
      LanguageCodes.buttonScrollConfigDisplayDashboardTextInfo.toString():
          'Show',
      LanguageCodes.alignConfigDashboardTextInfo.toString(): 'Alignment',
      LanguageCodes.alignConfigLeftDashboardTextInfo.toString(): 'Align left',
      LanguageCodes.alignConfigRegularDashboardTextInfo.toString():
          'Align center',
      LanguageCodes.fontConfigDashboardTextInfo.toString(): 'Font style',
      LanguageCodes.fontSizeConfigDashboardTextInfo.toString(): 'Font size',
      LanguageCodes.fontColorConfigDashboardTextInfo.toString(): 'Font color',
      LanguageCodes.backgroundConfigDashboardTextInfo.toString():
          'Background color',
      LanguageCodes.limitFontSizeConfigTextInfo.toString():
          'Font size range (10-50)',
      LanguageCodes.listChapterDetailConfigTextInfo.toString(): 'Chapter list',
      LanguageCodes.storyDetailConfigTextInfo.toString(): 'Story details',
      LanguageCodes.storyDownloadConfigTextInfo.toString(): 'Download',
      LanguageCodes.storyPushCoinConfigTextInfo.toString(): 'Throw coins',
      LanguageCodes.storyShareConfigTextInfo.toString(): 'Share',
      LanguageCodes.storyReportConfigTextInfo.toString(): 'Report an issue',
      LanguageCodes.signinConfigTextInfo.toString(): 'Sign in',
      LanguageCodes.signupConfigTextInfo.toString(): 'Sign up',
      LanguageCodes.inputUsernameTextConfigTextInfo.toString(): 'Username',
      LanguageCodes.inputPasswordTextConfigTextInfo.toString(): 'Password',
      LanguageCodes.noHaveAccountTextConfigTextInfo.toString():
          'Don\'t have an account?',
      LanguageCodes.inValidAccountTextConfigTextInfo.toString():
          'Invalid username or password!',
      LanguageCodes.publishStoryTextConfigTextInfo.toString():
          'Story %s - %s has just been published!',
      LanguageCodes.notificationTextConfigTextInfo.toString(): 'Notification',
      LanguageCodes.notificationByUserTextConfigTextInfo.toString():
          'User %s is now following your story %s',
      LanguageCodes.downloadedTextInfo.toString(): 'Downloaded',
      LanguageCodes.chaptersDownloadDeletedTextInfo.toString():
          'Chapter %s deleted from memory',
      LanguageCodes.chaptersDownloadAddedTextInfo.toString():
          'Successfully downloaded %s chapters',
      LanguageCodes.recentlyStoryTextInfo.toString():
          'No recently read stories found',
      LanguageCodes.upgradeAccountTextInfo.toString(): 'Upgrade account',
      LanguageCodes.buyNowTextInfo.toString(): 'Buy now',
      LanguageCodes.monthTextInfo.toString(): 'Month',
      LanguageCodes.customerBenefitsTextInfo.toString(): 'Customer benefits',
      LanguageCodes.oneLawsUpgradeAccountTextInfo.toString():
          'Ad-free experience',
      LanguageCodes.twoLawsUpgradeAccountTextInfo.toString():
          'Use the latest functions of the application',
      LanguageCodes.logoutAccountTextInfo.toString(): 'Log out',
      LanguageCodes.contactTextInfo.toString(): 'Contact & Support',
      LanguageCodes.contactToEmailTextInfo.toString(): 'Contact via email',
      LanguageCodes.askCommonTextInfo.toString(): 'Frequently asked questions',
      LanguageCodes.privacyTextInfo.toString(): 'Privacy policy',
      LanguageCodes.privacyTermsTextInfo.toString(): 'Terms of service',
      LanguageCodes.followUserTextInfo.toString(): 'Follow',
      LanguageCodes.inboxTextInfo.toString(): 'Inbox',
      LanguageCodes.gmailUserTextInfo.toString(): 'Gmail',
      LanguageCodes.phoneNumberTextInfo.toString(): 'Phone number',
      LanguageCodes.birthdayUserTextInfo.toString(): 'Birthday',
      LanguageCodes.addressUserTextInfo.toString(): 'Address',
      LanguageCodes.themeModeTextInfo.toString(): 'Theme mode',
      LanguageCodes.lightModeTextInfo.toString(): 'Light',
      LanguageCodes.darkModeTextInfo.toString(): 'Dark',
      LanguageCodes.forgotPasswordTextInfo.toString(): 'Forgot password',
      LanguageCodes.invalidAccountTextInfo.toString():
          'Incorrect username or password',
      LanguageCodes.rememberTextInfo.toString(): 'Remember',
      LanguageCodes.forgotPasswordMoreInfoTextInfo.toString():
          '''A password reset OTP will be sent to your email to reset your password. If you don't receive the email within a few minutes, please try again.''',
      LanguageCodes.notificationTextInfo.toString(): 'Notification',
      LanguageCodes.sendTextInfo.toString(): 'Sent',
      LanguageCodes.ignoreTextInfo.toString(): 'Dismiss',
      LanguageCodes.sendPasswordSuccessTextInfo.toString():
          'OTP has been sent to your email. Please check your email.',
      LanguageCodes.backInfoTextInfo.toString(): 'Back',
      LanguageCodes.submitTextInfo.toString(): 'Submit',
      LanguageCodes.isSureTextInfo.toString(): 'Agree',
      LanguageCodes.isNotSureTextInfo.toString(): 'Disagree',
      LanguageCodes.youSureLogoutTextInfo.toString(): 'Do you want to log out?',
      LanguageCodes.invalidEmailTextInfo.toString(): 'Invalid email',
      LanguageCodes.invalidPhoneNumberTextInfo.toString(): 'Invalid format',
      LanguageCodes.changeNameTextInfo.toString(): 'Change your name',
      LanguageCodes.changeUserInfoTextInfo.toString():
          'Information changed successfully',
      LanguageCodes.viewNotificationAllTextInfo.toString(): 'View all',
      LanguageCodes.successTextInfo.toString(): 'Success',
      LanguageCodes.unSuccessTextInfo.toString(): 'Failed',
      LanguageCodes.noDataTextInfo.toString(): 'No data',
      LanguageCodes.viewNextNotificationTextInfo.toString(): 'View next',
      LanguageCodes.viewPreviousNotificationTextInfo.toString(): 'Go back',
      LanguageCodes.closeAdsTextInfo.toString(): 'Close ad',
      LanguageCodes.acceptTextInfo.toString(): 'Agree',
      LanguageCodes.unAcceptTextInfo.toString(): 'Disagree',
      LanguageCodes.buyPremiumQuestionTextInfo.toString():
          'Do you want to purchase the premium package?',
      LanguageCodes.serverErrorTextInfo.toString():
          'An error occurred, please try again later',
      LanguageCodes.changePasswordTextInfo.toString(): 'Change password',
      LanguageCodes.newPasswordTextInfo.toString(): 'New password',
      LanguageCodes.confirmPasswordTextInfo.toString(): 'Confirm password',
      LanguageCodes.otpConfirmErrorTextInfo.toString():
          'Invalid or expired OTP',
      LanguageCodes.confirmTextInfo.toString(): 'Confirm',
      LanguageCodes.requiredPasswordTextInfo.toString():
          'Password must contain at least one uppercase letter, one lowercase letter, one digit, one special character, and be at least 8 characters long.',
      LanguageCodes.errorDoesNotMatchPasswordTextInfo.toString():
          'Passwords do not match',
      LanguageCodes.changePasswordSuccessTextInfo.toString():
          'Your password has been changed!',
      LanguageCodes.languageTextInfo.toString(): 'Language',
      LanguageCodes.continueWithGoogleTextInfo.toString(): 'Or continue with',
      LanguageCodes.emailSignUpTextInfo.toString(): 'Email',
      LanguageCodes.usernameSignUpErrorTextInfo.toString():
          'Account allows only [a-z, A-Z, 0-9, _]',
      LanguageCodes.emailSignUpErrorTextInfo.toString(): 'Invalid email format',
      LanguageCodes.haveAccountTextInfo.toString(): 'Already have an account?',
      LanguageCodes.chosseGenderTextInfo.toString(): 'Please choose gender',
      LanguageCodes.maleTextInfo.toString(): 'Male',
      LanguageCodes.femaleTextInfo.toString(): 'Female',
      LanguageCodes.requestDeleteAccountTextInfo.toString():
          'Request to delete account',
      LanguageCodes.confirmDeleteAccountTextInfo.toString():
          'Your account will be permanently deleted! Do you want to proceed?',
      LanguageCodes.privacyDeleteAccountTextInfo.toString():
          '1. Your account will be automatically deleted after 5 days. Please log in before this time to cancel the account deletion order.',
      LanguageCodes.privacyOneTextInfo.toString():
          '1. Do not disclose your email address or other security-related information to third parties unless you violate the rules.',
      LanguageCodes.privacyTwoTextInfo.toString():
          '2. Do not disclose your IP address to third parties.',
      LanguageCodes.privacyThirdTextInfo.toString():
          '3. Do not disclose your location to third parties. Use this information only to improve the functionality of the app. Everything is completely automated.',
      LanguageCodes.privacyFourTextInfo.toString():
          '''4. We store publicly visible activities when you participate in activities, including:
   Activity in stories (story log)
   Account-wide activity (account log)''',
      LanguageCodes.privacyFiveTextInfo.toString():
          '5. Most of the information you enter into the app is public, so we are not responsible for maintaining the privacy of that information.',
      LanguageCodes.privacySixTextInfo.toString():
          '''6. We have a mechanism to indicate when you are online or offline from the website. A green dot will appear next to your name when online and disappear when offline.''',
      LanguageCodes.privacySevenTextInfo.toString():
          '''7. To completely delete your data, please follow these steps:
   User management page.
   Choose the request to delete the account.
   Your account will be automatically deleted after 5 days, and log in before this time to cancel the account deletion order.''',
      LanguageCodes.deleteAccountSuccessTextInfo.toString():
          'Account deletion command successful',
      LanguageCodes.agreeDeleteAccountTextInfo.toString():
          'I agree to the terms and conditions',
      LanguageCodes.paymentSuccessTextInfo.toString(): 'Payment successful!',
      LanguageCodes.paymentSuccessCustomerInfoTextInfo.toString():
          'Your %s was successful charged',
      LanguageCodes.timeBackToHomeTextInfo.toString():
          'You will back to home after %s',
      LanguageCodes.audioSettingTextInfo.toString(): 'Volume',
      LanguageCodes.timerSettingTextInfo.toString(): 'Timer',
      LanguageCodes.timerInfoSettingTextInfo.toString():
          'Select the number of minutes you want to timer',
      LanguageCodes.noInternetTextInfo.toString(): 'Internet unavailable',
      LanguageCodes.firstInfoTrialTextInfo.toString():
          'This is a trial version! We will update the story as soon as possible. Thank you.'
    },
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
      LanguageCodes.twoLawsUpgradeAccountTextInfo.toString():
          'Sử dụng các chức năng mới nhất của ứng dụng',
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
          'Một OTP xác thực đặt lại mật khẩu sẽ được gửi đến email của bạn để đặt lại mật khẩu. Nếu bạn không nhận được email trong vòng vài phút, vui lòng thử lại.',
      LanguageCodes.notificationTextInfo.toString(): 'Thông báo',
      LanguageCodes.sendTextInfo.toString(): 'Đã gửi',
      LanguageCodes.ignoreTextInfo.toString(): 'Đã hiểu',
      LanguageCodes.sendPasswordSuccessTextInfo.toString():
          'OTP đã được gửi đến email. Vui lòng kiểm tra email của bạn.',
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
      LanguageCodes.closeAdsTextInfo.toString(): 'Tắt quảng cáo',
      LanguageCodes.acceptTextInfo.toString(): 'Đồng ý',
      LanguageCodes.unAcceptTextInfo.toString(): 'Không',
      LanguageCodes.buyPremiumQuestionTextInfo.toString():
          'Bạn có muốn mua gói trả phí?',
      LanguageCodes.serverErrorTextInfo.toString():
          'Có lỗi xảy ra vui lòng thử lại sau ít phút',
      LanguageCodes.serverErrorReLoginTextInfo.toString():
          'Có lỗi xảy ra vui lòng đăng nhập lại',
      LanguageCodes.changePasswordTextInfo.toString(): 'Đổi mật khẩu',
      LanguageCodes.newPasswordTextInfo.toString(): 'Mật khẩu mới',
      LanguageCodes.confirmPasswordTextInfo.toString(): 'Nhập lại mật khẩu',
      LanguageCodes.otpConfirmErrorTextInfo.toString():
          'Otp không hợp lệ hoặc đã hết hạn',
      LanguageCodes.confirmTextInfo.toString(): 'Xác thực',
      LanguageCodes.requiredPasswordTextInfo.toString():
          'Mật khẩu phải chứa ít nhất một chữ hoa, một chữ thường, một chữ số, một ký tự đặc biệt và dài ít nhất 8 ký tự.',
      LanguageCodes.errorDoesNotMatchPasswordTextInfo.toString():
          'Mật khẩu không khớp',
      LanguageCodes.changePasswordSuccessTextInfo.toString():
          'Mật khẩu của bạn đã được thay đổi!',
      LanguageCodes.languageTextInfo.toString(): 'Ngôn ngữ',
      LanguageCodes.continueWithGoogleTextInfo.toString(): 'Hoặc tiếp tục với',
      LanguageCodes.emailSignUpTextInfo.toString(): 'Email',
      LanguageCodes.usernameSignUpErrorTextInfo.toString():
          'Tài khoản chỉ cho phép [a-z,A-Z,0-9,_]',
      LanguageCodes.emailSignUpErrorTextInfo.toString():
          'Email không đúng định dạng',
      LanguageCodes.haveAccountTextInfo.toString(): 'Đã có tài khoản?',
      LanguageCodes.chosseGenderTextInfo.toString(): 'Vui lòng chọn giới tính',
      LanguageCodes.maleTextInfo.toString(): 'Nam',
      LanguageCodes.femaleTextInfo.toString(): 'Nữ',
      LanguageCodes.requestDeleteAccountTextInfo.toString():
          'Yêu cầu xoá tài khoản',
      LanguageCodes.confirmDeleteAccountTextInfo.toString():
          'Tài khoản của bạn sẽ bị xoá vĩnh viễn! Bạn có muốn tiếp tục?',
      LanguageCodes.privacyDeleteAccountTextInfo.toString():
          '1. Tài khoản của bạn sẽ được tự động xoá sau 5 ngày. Vui lòng đăng nhập lại trước thời gian này để huỷ bỏ lệnh xoá tài khoản',
      LanguageCodes.privacyOneTextInfo.toString():
          '1. Không tiết lộ địa chỉ email, hay các thông tin cần bảo mật khác cho bên thứ 3, trừ khi bạn vi phạm nội quy.',
      LanguageCodes.privacyTwoTextInfo.toString():
          '2. Không tiết lộ địa chỉ IP cho bên thứ 3.',
      LanguageCodes.privacyThirdTextInfo.toString():
          '3. Không tiết lộ vị trí của bạn cho bên thứ 3. Đồng thời chỉ sử dụng thông tin này để cải thiện chức năng của app. Mọi việc đều hoàn toàn tự động.',
      LanguageCodes.privacyFourTextInfo.toString():
          '''4. Chúng tôi lưu trữ các hoạt động mang tính công khai khi bạn tham gia hoạt động gồm:
             Hoạt động tại truyện (nhật ký của truyện)
             Hoạt động chung của tài khoản (nhật ký tài khoản)''',
      LanguageCodes.privacyFiveTextInfo.toString():
          '5. Các thông tin bạn nhập vào ứng dụng hầu hết đều là công khai, vì vậy chúng tôi không chịu trách nhiệm về việc giữ tính riêng tư các thông tin đó.',
      LanguageCodes.privacySixTextInfo.toString():
          '''6. Chúng tôi có cơ chế để cho biết khi nào bạn online hay offline khỏi website. Một chấm xanh sẽ xuất hiện bên cạnh tên của bạn khi online và biến mất khi offline.
             ''',
      LanguageCodes.privacySevenTextInfo.toString():
          '''7. Để xóa hoàn toàn dữ liệu của bạn, vui lòng thực hiện các bước sau:
             Trang quản lý người dùng.
             Chọn yêu cầu xoá tài khoản.
             Tài khoản của bạn sẽ tự động xoá sau 5 ngày, và đăng nhập lại trước thời gian này để huỷ bỏ lệnh xoá tài khoản''',
      LanguageCodes.deleteAccountSuccessTextInfo.toString():
          'Đặt lệnh xoá tài khoản thành công',
      LanguageCodes.agreeDeleteAccountTextInfo.toString():
          'Tôi đồng ý với các Điều khoản và Điều kiện',
      LanguageCodes.paymentSuccessTextInfo.toString(): 'Thanh toán thành công!',
      LanguageCodes.paymentSuccessCustomerInfoTextInfo.toString():
          'Thẻ đã %s thanh toán thành công',
      LanguageCodes.timeBackToHomeTextInfo.toString():
          'Bạn sẽ trở về trang chủ sau %s ',
      LanguageCodes.audioSettingTextInfo.toString(): 'Âm lượng',
      LanguageCodes.timerInfoSettingTextInfo.toString():
          'Chọn số phút bạn muốn hẹn giờ',
      LanguageCodes.timerSettingTextInfo.toString(): 'Hẹn giờ',
      LanguageCodes.noInternetTextInfo.toString(): 'Mạng không khả dụng',
      LanguageCodes.firstInfoTrialTextInfo.toString():
          'Đây là phiên bản thử nghiệm! Mọi thứ đều miễn phí và chúng tôi sẽ cập nhật truyện sớm nhất có thể. Xin cám ơn!'
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
