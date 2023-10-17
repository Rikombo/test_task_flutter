import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/presentation/gifs/bloc/giphy_list_cubit.dart';
import 'package:test_app/presentation/gifs/bloc/giphy_list_state.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debouncer;
  late final GiphyListCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<GiphyListCubit>();
    _cubit.loadGifs(); // Load initial GIFs
    _searchController.addListener(_debounceSearch);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiphyListCubit, GiphyListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('GIFs'),
            backgroundColor: Colors.deepPurple,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search GIFs...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(width: 1),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent - 500) {
                      _cubit.loadMoreGifs();
                    }
                    return false;
                  },
                  child: _buildBody(state),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(GiphyListState state) {
    if (state.isLoading && state.gifs.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.isError) {
      return Center(
        child: ElevatedButton(
          onPressed: () => _cubit.loadGifs(),
          child: const Text('Retry'),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: state.gifs.length,
        itemBuilder: (context, index) {
          final gif = state.gifs[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: gif.imageUrl,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        },
      );
    }
  }

  void _debounceSearch() {
    if (_debouncer?.isActive ?? false) _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 300), () {
      final query = _searchController.text;
      if (query.isNotEmpty) {
        _cubit.loadGifs(query: query);
      } else {
        _cubit.loadGifs();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer?.cancel();
    super.dispose();
  }
}
