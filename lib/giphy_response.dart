import 'package:json_annotation/json_annotation.dart';

part 'giphy_response.g.dart';

@JsonSerializable(createToJson: false)
class GiphyFullResponse {
  final List<GiphyDataResponse> data;

  const GiphyFullResponse({required this.data});

  factory GiphyFullResponse.fromJson(Map<String, dynamic> json) =>
      _$GiphyFullResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class GiphyDataResponse {
  final String type;
  final String id;
  final String url;
  final String title;
  final String rating;
  final GiphyImages images;

  GiphyDataResponse(
      {required this.type,
      required this.id,
      required this.url,
      required this.title,
      required this.rating,
      required this.images});

  factory GiphyDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GiphyDataResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class GiphyImages {
  final String originalUrl;
  final String fixedHeightUrl;
  final String fixedWidthUrl;

  GiphyImages({
    required this.originalUrl,
    required this.fixedHeightUrl,
    required this.fixedWidthUrl,
  });

  factory GiphyImages.fromJson(Map<String, dynamic> json) =>
      _$GiphyImagesFromJson(json);
}
