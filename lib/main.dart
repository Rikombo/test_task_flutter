import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/giphy_api_client.dart';
import 'package:test_app/giphy_repository.dart';
import 'package:test_app/main_page.dart';
import 'package:test_app/network_giphy_repository.dart';

void main() {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.giphy.com/v1/gifs/'),
  );
  dio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
    ),
  );

  final giphyApiClient = GiphyApiClient(dio);
  final networkGiphyRepository = NetworkGiphyRepository(giphyApiClient);
  final giphyRepositoryProvider = RepositoryProvider<GiphyRepository>(
    create: (context) => networkGiphyRepository,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        giphyRepositoryProvider,
      ],
      child: MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}
