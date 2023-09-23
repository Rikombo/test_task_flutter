import 'package:dio/dio.dart';
import 'package:test_app/giphy_response.dart';

class GiphyApiClient {
  final Dio _dio;
  final _apiKey = 'SIF4B0wr25IWKjYMjIcoGy6zv4pqbG8H';
  final limit = 25;
  final offset = 0;
  final rating = 'g';
  final bundle = 'messaging_non_clips';

  GiphyApiClient(this._dio);

  Future<List<GiphyDataResponse>> getTrendingGifs() async {
    final response = await _dio.get(
      'trending?api_key=$_apiKey&limit=$limit&offset=$offset&rating=$rating&bundle=$bundle',
    );

    final fullResponse = GiphyFullResponse.fromJson(response.data);
    return fullResponse.data;
  }

  Future<List<GiphyDataResponse>> searchGifs(String query) async {
    final response = await _dio.get(
        'search?api_key=$_apiKey&q=$query&limit=$limit&offset=$offset&rating=$rating&bundle=$bundle',
    );
    final searchResponse = GiphyFullResponse.fromJson(response.data);
    return searchResponse.data;
  }



}
