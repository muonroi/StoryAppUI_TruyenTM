import 'package:muonroi/features/homes/data/models/model.home.banner.dart';
import 'package:muonroi/features/homes/data/models/model.setting.dart';
import 'package:muonroi/features/homes/data/services/api.home.service.dart';

class HomeRepository {
  final _homeService = HomeService();
  Future<ModelBannerResponse> getBannerList(int type) =>
      _homeService.getBannerList(type);

  Future<ModelSettingResponse> getSettingByType(int type) =>
      _homeService.getSetting(type);
}

class NetworkError extends Error {}
