import 'package:test_app/domain/model/giphy_domain.dart';

class GiphyListState {
  final List<GiphyDomain> gifs;
  final bool isLoading;
  final bool isError;

  GiphyListState({
    required this.gifs,
    required this.isLoading,
    required this.isError,
  });

  GiphyListState copyWith({
    List<GiphyDomain>? gifs,
    bool? isLoading,
    bool? isError,
  }) {
    return GiphyListState(
      gifs: gifs ?? this.gifs,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}