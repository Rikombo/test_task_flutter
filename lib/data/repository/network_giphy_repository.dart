import 'package:test_app/data/api/giphy_api_client.dart';
import 'package:test_app/domain/model/giphy_domain.dart';
import 'package:test_app/domain/repository/giphy_repository.dart';

class NetworkGiphyRepository implements GiphyRepository {
  final GiphyApiClient _giphyApiClient;

  NetworkGiphyRepository(this._giphyApiClient);

  @override
  Future<List<GiphyDomain>> getTrendingGifs() async {
    final response = await _giphyApiClient.getTrendingGifs();
    final trendingGifs = response.map(
      (trendingGif) => GiphyDomain(
        title: trendingGif.title,
        imageUrl: trendingGif.images.original.url,
      ),
    );
    return trendingGifs.toList();
  }

  @override
  Future<List<GiphyDomain>> searchGifs(String query) async {
    final response = await _giphyApiClient.searchGifs(query);
    final searchGifs = response.map(
      (searchGif) => GiphyDomain(
        title: searchGif.title,
        imageUrl: searchGif.images.original.url,
      ),
    );
    return searchGifs.toList();
  }

  @override
  Future<List<GiphyDomain>> getMoreGifs(
      {int additionalItems = 5, String? query, int offset = 0}) async {
    final response = await _giphyApiClient.getMoreGifs(
        additionalItems: additionalItems, query: query, offset: offset);
    final moreGifs = response.map(
      (moreGif) => GiphyDomain(
        title: moreGif.title,
        imageUrl: moreGif.images.original.url,
      ),
    );
    return moreGifs.toList();
  }
}
