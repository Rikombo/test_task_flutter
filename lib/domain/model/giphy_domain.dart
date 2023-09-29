import 'package:equatable/equatable.dart';

class GiphyDomain extends Equatable {
  final String title;
  final String imageUrl;

  const GiphyDomain({
    required this.title,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [title, imageUrl];
}
