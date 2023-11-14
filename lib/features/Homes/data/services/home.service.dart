import 'package:dio/dio.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/features/homes/data/models/home.banner.model.dart';
import 'package:sprintf/sprintf.dart';

class HomeService {
  Future<ModelBannerResponse> getBannerList(int type) async {
    try {
      Dio dio = Dio(BaseOptions(
          baseUrl: ApiNetwork.baseApi, responseType: ResponseType.plain));
      final response = await dio.get(sprintf(ApiNetwork.banners, [type]));
      if (response.statusCode == 200) {
        return modelBannerResponseFromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw Exception("Failed to load banner list");
      }
    }
    throw Exception("Failed to load banner list");
  }
}
