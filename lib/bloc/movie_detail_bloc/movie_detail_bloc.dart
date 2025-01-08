import 'package:bloc/bloc.dart';
import 'package:tentwenty_assesment/bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:tentwenty_assesment/bloc/movie_detail_bloc/movie_detail_state.dart';

import '../../api_data/api_data.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitialState()) {
    on<HitMovieDetail>((event, emit) async {
      final ApiData apiProvider = ApiData();

      emit(MovieDetailLoading());
      final res = await apiProvider.fetchMovieDetailById(event.movieId);

      emit(MovieDetailLoaded(movieDetailModel: res));
    });


    on<HitGetMovieTrailer>((event, emit) async {
      final ApiData apiProvider = ApiData();

      emit(MovieDetailLoading());
      final res = await apiProvider.fetchMovieTrailerById(event.movieId);
      // state.movieTrailerModel.results?.last?.key ?? ""
      // emit(MovieDetailLoaded( ));

      emit((state as MovieDetailLoaded).copyWith(
          newKey: res.results?.last?.key));
    });
  }
}
