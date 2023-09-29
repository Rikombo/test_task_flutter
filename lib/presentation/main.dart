import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/data/api/giphy_api_client.dart';
import 'package:test_app/presentation/gifs/bloc/giphy_list_cubit.dart';
import 'package:test_app/presentation/gifs/main_page.dart';
import 'package:test_app/data/repository/network_giphy_repository.dart';

void main() {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.giphy.com/v1/gifs/'),
  );
  final giphyApiClient = GiphyApiClient(dio);
  final networkGiphyRepository = NetworkGiphyRepository(giphyApiClient);

  runApp(
    BlocProvider(
      create: (context) => GiphyListCubit(networkGiphyRepository),
      child: const MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}
