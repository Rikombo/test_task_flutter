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
  Future<List<GiphyDomain>>? giphyFuture;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debouncer;

  @override
  void initState() {
    super.initState();
    giphyRepository = context.read();
    giphyFuture = giphyRepository.getTrendingGifs();
    _searchController.addListener(() {
      _debounceSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text('Trending GIFs'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search GIFs...',
            ),
          ),
          Expanded(
            child: FutureBuilder<List<GiphyDomain>>(
              future: giphyFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final gifs = snapshot.data ?? [];

                if (gifs.isEmpty) {
                  return Center(
                    child: Text('No GIFs available'),
                  );
                }

                return ListView.builder(
                  itemCount: gifs.length,
                  itemBuilder: (context, index) {
                    final gif = gifs[index];
                    return Image.network(gif.imageUrl);
                  },
                );
              },
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
    super.dispose();
  }

  void _debounceSearch() {
    if (_debouncer != null) {
      _debouncer?.cancel();
    }
    _debouncer = Timer(const Duration(milliseconds: 300), () {
      final query = _searchController.text;
      setState(() {
        if (query.isEmpty) {
          giphyFuture = giphyRepository.getTrendingGifs();
        } else {
          giphyFuture = giphyRepository.searchGifs(query);
        }
      });
    });
  }
}
