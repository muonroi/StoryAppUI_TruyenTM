import 'package:muonroi/features/homes/data/models/home.banner.model.dart';
import 'package:muonroi/features/homes/data/services/home.service.dart';

class HomeRepository {
  final _homeService = HomeService();
  Future<ModelBannerResponse> getBannerList(int type) =>
      _homeService.getBannerList(type);
}

class NetworkError extends Error {}
