import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/domain/repository/giphy_repository.dart';
import 'package:test_app/presentation/gifs/bloc/giphy_list_state.dart';

class GiphyListCubit extends Cubit<GiphyListState> {
  final GiphyRepository _giphyRepository;
  String? _currentQuery;
  int _offset = 0;
  static const int itemsPerPage = 5;

  GiphyListCubit(this._giphyRepository)
      : super(GiphyListState(
          gifs: [],
          isLoading: false,
          isError: false,
        ));

  Future<void> loadGifs({String? query}) async {
    try {
      _currentQuery = query;
      _offset = 0;
      emit(state.copyWith(isLoading: true, isError: false));

      final gifs = query == null
          ? await _giphyRepository.getTrendingGifs()
          : await _giphyRepository.searchGifs(query);

      emit(state.copyWith(gifs: gifs, isLoading: false));
    } catch (_) {
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }

  Future<void> loadMoreGifs() async {
    try {
      _offset += itemsPerPage;
      emit(state.copyWith(isLoading: true));

      final additionalGifs = await _giphyRepository.getMoreGifs(
        offset: _offset,
        query: _currentQuery,
      );

      emit(state.copyWith(
        gifs: state.gifs + additionalGifs,
        isLoading: false,
      ));
    } catch (_) {
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }
}
