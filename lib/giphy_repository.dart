import 'giphy_domain.dart';

abstract class GiphyRepository {
  Future<List<GiphyDomain>> getTrendingGifs();
  Future<List<GiphyDomain>> searchGifs(String query);
}