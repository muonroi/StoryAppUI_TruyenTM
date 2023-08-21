import 'package:muonroi/Models/Categories/models.stories.dart';
import 'package:muonroi/Settings/settings.api.dart';
import 'package:muonroi/Settings/settings.main.dart';
import 'package:sprintf/sprintf.dart';

class CategoriesProvider {
  Future<CategoriesModel> getCategoriesDataList(
      [int pageIndex = 1, int pageSize = 15]) async {
    try {
      final response = await baseUrl().get(
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
