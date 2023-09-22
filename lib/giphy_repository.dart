import 'giphy_domain.dart';

abstract class GiphyRepository {
  Future<List<GiphyDomain>> getTrendingGifs();
}