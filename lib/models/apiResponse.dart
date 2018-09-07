import 'package:json_annotation/json_annotation.dart';

part 'apiResponse.g.dart';

@JsonSerializable()
class ApiResponse {
  final String status;
  final int totalResults;
  final List<dynamic> articles;

  ApiResponse({
      this.status, this.totalResults, this.articles
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

}