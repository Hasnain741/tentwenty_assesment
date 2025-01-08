import 'package:meta/meta.dart';
import 'package:tentwenty_assesment/models/movie_detail_model.dart';

import '../../models/get_movie_trailer_model.dart';

@immutable
abstract class MovieDetailState {}

class MovieDetailInitialState extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String errorMessage;

  MovieDetailError({
    required this.errorMessage,
  });
}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailModel? movieDetailModel;
  String? key;

  MovieDetailLoaded({required this.movieDetailModel, this.key});

  MovieDetailLoaded copyWith(
      {String? newKey, MovieDetailModel? newMovieDetailModel}) {
    return MovieDetailLoaded(
        key: newKey ?? key, movieDetailModel: newMovieDetailModel??movieDetailModel);
  }
}

class GetMovieTrailerInitialState extends MovieDetailState {}

class GetMovieTrailerError extends MovieDetailState {
  final String errorMessage;

  GetMovieTrailerError({
    required this.errorMessage,
  });
}

class GetMovieTrailerLoading extends MovieDetailState {}

class GetMovieTrailerLoaded extends MovieDetailState {
  final MovieTrailerModel movieTrailerModel;

  GetMovieTrailerLoaded({required this.movieTrailerModel});
}
