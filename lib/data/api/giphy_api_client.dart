import 'package:dio/dio.dart';
import 'package:test_app/data/model/giphy_response.dart';

class GiphyApiClient {
  final Dio _dio;

  final String _apiKey = const String.fromEnvironment(
      'SIF4B0wr25IWKjYMjIcoGy6zv4pqbG8H',
      defaultValue: 'SIF4B0wr25IWKjYMjIcoGy6zv4pqbG8H');

  final int limit;
  final int offset;

  final String rating = 'g';
  final String bundle = 'messaging_non_clips';

  GiphyApiClient(
    this._dio, {
    this.limit = 5,
    this.offset = 0,
  });

  Future<List<GiphyDataResponse>> _fetchGifs(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      final fullResponse = GiphyFullResponse.fromJson(response.data);
      return fullResponse.data;
    } catch (e) {
      throw Exception('Failed to load GIFs: $e');
    }
  }

  Future<List<GiphyDataResponse>> getTrendingGifs() async {
    final endpoint =
        'trending?api_key=$_apiKey&limit=$limit&offset=$offset&rating=$rating&bundle=$bundle';
    return _fetchGifs(endpoint);
  }

  Future<List<GiphyDataResponse>> searchGifs(String query) async {
    final endpoint =
        'search?api_key=$_apiKey&q=$query&limit=$limit&offset=$offset&rating=$rating&bundle=$bundle';
    return _fetchGifs(endpoint);
  }

  Future<List<GiphyDataResponse>> getMoreGifs({
    int additionalItems = 5,
    String? query,
    required int offset,
  }) async {
    final endpoint = query != null
        ? 'search?api_key=$_apiKey&q=$query&limit=$additionalItems&offset=$offset&rating=$rating&bundle=$bundle'
        : 'trending?api_key=$_apiKey&limit=$additionalItems&offset=$offset&rating=$rating&bundle=$bundle';

    return _fetchGifs(endpoint);
  }
}
