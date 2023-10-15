import 'package:muonroi/core/authorization/setting.api.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/features/notification/data/models/notification.single.user.dart';
import 'package:sprintf/sprintf.dart';

class NotificationService {
  Future<NotificationSingleUser> getNotificationUser(
      int pageSize, int pageIndex) async {
    try {
      var baseEndpoint = await endPoint();
      final response = await baseEndpoint.get(
          sprintf(ApiNetwork.storiesNotificationUser, [pageIndex, pageSize]));
      if (response.statusCode == 200) {
        return notificationSingleUserFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load notification");
      }
    } catch (e) {
      throw Exception("Failed to load notification");
    }
  }

  Future<bool> viewAllNotificationUser() async {
    try {
      var baseEndpoint = await endPoint();
      Map<String, dynamic> data = {};
      final response = await baseEndpoint
          .put(ApiNetwork.viewAllNotificationUser, data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> viewSingleNotificationUser(int notificationId) async {
    try {
      var baseEndpoint = await endPoint();
      Map<String, dynamic> data = {"notificationId": notificationId};
      final response = await baseEndpoint
          .put(ApiNetwork.viewSingleNotificationUser, data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
