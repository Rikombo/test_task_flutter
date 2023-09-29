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
      title: json['title'] as String,
      images:
          GiphyResponseImages.fromJson(json['images'] as Map<String, dynamic>),
    );

GiphyResponseImages _$GiphyResponseImagesFromJson(Map<String, dynamic> json) =>
    GiphyResponseImages(
      original: OriginalGif.fromJson(json['original'] as Map<String, dynamic>),
    );

OriginalGif _$OriginalGifFromJson(Map<String, dynamic> json) => OriginalGif(
      url: json['url'] as String,
    );
