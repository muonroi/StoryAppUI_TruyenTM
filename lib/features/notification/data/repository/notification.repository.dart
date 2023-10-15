import 'package:muonroi/features/notification/data/models/notification.single.user.dart';
import 'package:muonroi/features/notification/data/service/notification.service.dart';

class NotificationRepository {
  var notificationService = NotificationService();
  Future<NotificationSingleUser> getNotificationUser(
          int pageIndex, int pageSize) =>
      notificationService.getNotificationUser(pageSize, pageIndex);
  Future<bool> viewAllNotificationUser() =>
      notificationService.viewAllNotificationUser();
  Future<bool> viewSingleNotificationUser(int notificationId) =>
      notificationService.viewSingleNotificationUser(notificationId);
}

class NetworkError extends Error {}
