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
}
