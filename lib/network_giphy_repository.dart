import 'package:test_app/giphy_api_client.dart';
import 'package:test_app/giphy_domain.dart';
import 'package:test_app/giphy_repository.dart';

class NetworkGiphyRepository implements GiphyRepository {
  final GiphyApiClient _giphyApiClient;

  NetworkGiphyRepository(this._giphyApiClient);

  @override
  Future<List<GiphyDomain>> getTrendingGifs() async {
    final response = await _giphyApiClient.getTrendingGifs();
    final trendingGifs = response.map(
      (trendingGifs) => GiphyDomain(
        title: trendingGifs.title,
        imageUrl: trendingGifs.images.original.url,
      ),
    );
    return trendingGifs.toList();
  }

  @override
  Future<List<GiphyDomain>> searchGifs(String query) async {
    final response = await _giphyApiClient.searchGifs(query);
    final search = response.map(
      (search) => GiphyDomain(
        title: search.title,
        imageUrl: search.images.original.url,
      ),
    );
    return search.toList();
  }
}
