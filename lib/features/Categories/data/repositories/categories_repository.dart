import 'package:muonroi/features/Categories/data/models/models.stories.dart';
import 'package:muonroi/core/services/api_category_provider.dart';

class CategoriesRepository {
  final int pageIndex;
  final int pageSize;
  final _provider = CategoriesProvider();

  CategoriesRepository(this.pageIndex, this.pageSize);

  Future<CategoriesModel> fetchCategoriesData() =>
      _provider.getCategoriesDataList(pageIndex, pageSize);
}

class NetworkError extends Error {}
