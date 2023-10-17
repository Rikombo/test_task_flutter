import 'package:test_app/data/api/giphy_api_client.dart';
import 'package:test_app/data/model/giphy_response.dart';
import 'package:test_app/domain/model/giphy_domain.dart';
import 'package:test_app/domain/repository/giphy_repository.dart';

class NetworkGiphyRepository implements GiphyRepository {
  final GiphyApiClient _giphyApiClient;

  NetworkGiphyRepository(this._giphyApiClient);

  @override
  Future<List<GiphyDomain>> getTrendingGifs() async {
    final response = await _giphyApiClient.getTrendingGifs();
    return response.map((trendingGif) => _mapToDomain(trendingGif)).toList();
  }

  @override
  Future<List<GiphyDomain>> searchGifs(String query) async {
    final response = await _giphyApiClient.searchGifs(query);
    return response.map((searchGif) => _mapToDomain(searchGif)).toList();
  }

  @override
  Future<List<GiphyDomain>> getMoreGifs({
    int additionalItems = 5,
    String? query,
    int offset = 0,
  }) async {
    final response = await _giphyApiClient.getMoreGifs(
        additionalItems: additionalItems, query: query, offset: offset);
    return response.map((moreGif) => _mapToDomain(moreGif)).toList();
  }

  GiphyDomain _mapToDomain(GiphyDataResponse gif) {
    return GiphyDomain(
      title: gif.title,
      imageUrl: gif.images.original.url,
    );
  }
}
