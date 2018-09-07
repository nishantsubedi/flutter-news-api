// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return ApiResponse(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      articles: json['articles'] as List);
}

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles
    };
