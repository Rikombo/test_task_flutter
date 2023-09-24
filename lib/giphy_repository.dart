import 'giphy_domain.dart';

abstract class GiphyRepository {
  Future<List<GiphyDomain>> getTrendingGifs();
  Future<List<GiphyDomain>> searchGifs(String query);
  Future<List<GiphyDomain>> getMoreGifs({int additionalItems, String? query});
}