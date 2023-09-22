import 'package:flutter/cupertino.dart';
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
  late final GiphyRepository _giphyRepository;
  Future<List<GiphyDomain>>? _giphyFuture;

  @override
  void initState() {
    super.initState();
    _giphyRepository = context.read();
    _giphyFuture = _giphyRepository.getTrendingGifs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giphy Test'),
      ),
      body: FutureBuilder<List<GiphyDomain>>(
        future: _giphyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final gifs = snapshot.data ?? [];

          if (gifs.isEmpty) {
            return const Center(
              child: Text('No GIFs available'),
            );
          }

          return Column(
            children: [TextFormField(),
              Expanded(
                child: ListView.builder(
                  itemCount: gifs.length,
                  itemBuilder: (context, index) {
                    final gif = gifs[index];
                    return Image.network(gif.imageUrl);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
