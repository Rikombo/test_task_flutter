// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'giphy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiphyFullResponse _$GiphyFullResponseFromJson(Map<String, dynamic> json) =>
    GiphyFullResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => GiphyDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

GiphyDataResponse _$GiphyDataResponseFromJson(Map<String, dynamic> json) =>
    GiphyDataResponse(
      type: json['type'] as String,
      id: json['id'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
      rating: json['rating'] as String,
      images: GiphyImages.fromJson(json['images'] as Map<String, dynamic>),
    );

GiphyImages _$GiphyImagesFromJson(Map<String, dynamic> json) => GiphyImages(
      originalUrl: json['originalUrl'] as String,
      fixedHeightUrl: json['fixedHeightUrl'] as String,
      fixedWidthUrl: json['fixedWidthUrl'] as String,
    );
