import 'package:muonroi/features/homes/data/models/model.home.banner.dart';
import 'package:muonroi/features/homes/data/services/api.home.service.dart';

class HomeRepository {
  final _homeService = HomeService();
  Future<ModelBannerResponse> getBannerList(int type) =>
      _homeService.getBannerList(type);
}

class NetworkError extends Error {}
