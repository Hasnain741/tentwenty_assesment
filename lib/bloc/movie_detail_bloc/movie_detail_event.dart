import 'package:meta/meta.dart';

@immutable
abstract class MovieDetailEvent {}

class HitMovieDetail extends MovieDetailEvent {
  final String movieId;
  HitMovieDetail({
    required this.movieId,
  });
}

class HitGetMovieTrailer extends MovieDetailEvent {
  final String movieId;
  HitGetMovieTrailer({
    required this.movieId,
  });
}