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
  final String title;
  final GiphyResponseImages images;

  GiphyDataResponse({
    required this.title,
    required this.images,
  });

  factory GiphyDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GiphyDataResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class GiphyResponseImages {
  final OriginalGif original;

  GiphyResponseImages({
    required this.original,
  });

  factory GiphyResponseImages.fromJson(Map<String, dynamic> json) =>
      _$GiphyResponseImagesFromJson(json);
}

@JsonSerializable(createToJson: false)
class OriginalGif {
  final String url;

  OriginalGif({
    required this.url,
  });

  factory OriginalGif.fromJson(Map<String, dynamic> json) =>
      _$OriginalGifFromJson(json);
}