import 'package:muonroi/core/Authorization/setting.api.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/features/Categories/data/models/models.stories.dart';
import 'package:sprintf/sprintf.dart';

class CategoriesProvider {
  Future<CategoriesModel> getCategoriesDataList(
      [int pageIndex = 1, int pageSize = 15]) async {
    try {
      var baseEndpoint = await endPoint();
      final response = await baseEndpoint.get(
          sprintf(ApiNetwork.getCategoriesPaging, ["$pageIndex", "$pageSize"]));
      if (response.statusCode == 200) {
        return categoriesModelFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load category");
      }
    } catch (e) {
      throw Exception("Failed to load category");
    }
  }
}
