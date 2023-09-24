import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/giphy_repository.dart';
import 'package:test_app/giphy_domain.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final GiphyRepository giphyRepository;
  List<GiphyDomain> gifs = [];
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debouncer;
  bool _isLoading = false;
  String? _currentQuery;

  @override
  void initState() {
    super.initState();
    giphyRepository = context.read();
    _loadData();
    _searchController.addListener(() {
      _debounceSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GIFs'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search GIFs...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 10),
                ),
              ),
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo is ScrollEndNotification) {
                  if (!_isLoading &&
                      scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 500) {
                    _loadMoreGifs();
                  }
                }
                return false;
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: gifs.length,
                itemBuilder: (context, index) {
                  final gif = gifs[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        gif.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _debounceSearch() {
    if (_debouncer != null) {
      _debouncer?.cancel();
    }
    _debouncer = Timer(const Duration(milliseconds: 300), () {
      final query = _searchController.text;
      _currentQuery = query;
      _loadData(query: query);
    });
  }

  Future<void> _loadData({String? query}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (query == null || query.isEmpty) {
        final trendingGifs = await giphyRepository.getTrendingGifs();
        gifs = trendingGifs;
      } else {
        final searchGifs = await giphyRepository.searchGifs(query);
        gifs = searchGifs;
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMoreGifs() async {
    if (_isLoading || _currentQuery == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final additionalGifs = await giphyRepository.getMoreGifs(query: _currentQuery);
      gifs.addAll(additionalGifs);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

}
