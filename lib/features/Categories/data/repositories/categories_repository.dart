import 'package:muonroi/features/Categories/data/models/models.stories.dart';
import 'package:muonroi/features/categories/data/services/api.category.provider.dart';

class CategoriesRepository {
  final int pageIndex;
  final int pageSize;
  final _provider = CategoriesProvider();

  CategoriesRepository(this.pageIndex, this.pageSize);

  Future<CategoriesModel> fetchCategoriesData() =>
      _provider.getCategoriesDataList(pageIndex, pageSize);
}

class NetworkError extends Error {}
