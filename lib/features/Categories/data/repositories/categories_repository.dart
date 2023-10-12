import 'package:muonroi/features/Categories/data/models/models.stories.dart';
import 'package:muonroi/features/categories/data/services/api.category.service.dart';

class CategoriesRepository {
  final int pageIndex;
  final int pageSize;
  final _provider = CategoriesService();

  CategoriesRepository(this.pageIndex, this.pageSize);

  Future<CategoriesModel> fetchCategoriesData() =>
      _provider.getCategoriesDataList(pageIndex, pageSize);
}

class NetworkError extends Error {}
