import 'package:muonroi/Models/Stories/models.stories.story.dart';

class PagingInfo {
  final int pageSize;
  final int page;
  final int totalItems;

  PagingInfo(
      {required this.pageSize, required this.page, required this.totalItems});

  factory PagingInfo.fromJson(Map<String, dynamic> json) {
    return PagingInfo(
      pageSize: json['pageSize'],
      page: json['page'],
      totalItems: json['totalItems'],
    );
  }
}

class ApiResponse {
  final Result result;
  final List<String> errorMessages;
  final bool isOK;
  final int statusCode;

  ApiResponse(
      {required this.result,
      required this.errorMessages,
      required this.isOK,
      required this.statusCode});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      result: Result.fromJson(json['result']),
      errorMessages: List<String>.from(json['errorMessages']),
      isOK: json['isOK'],
      statusCode: json['statusCode'] ?? 0,
    );
  }
}

class Result {
  final List<dynamic> items;
  final PagingInfo pagingInfo;

  Result({required this.items, required this.pagingInfo});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      items: List<dynamic>.from(
          json['items'].map((item) => StoriesModel.fromJson(item))),
      pagingInfo: PagingInfo.fromJson(json['pagingInfo']),
    );
  }
}
