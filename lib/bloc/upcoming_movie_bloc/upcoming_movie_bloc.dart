import 'package:bloc/bloc.dart';
import 'package:tentwenty_assesment/bloc/upcoming_movie_bloc/upcoming_movie_event.dart';
import 'package:tentwenty_assesment/bloc/upcoming_movie_bloc/upcoming_movie_state.dart';

import '../../api_data/api_data.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  UpcomingMovieBloc() : super(UpcomingMovieInitial()) {
    on<GetUpcomingMovieList>((event, emit) async {
      final ApiData apiProvider = ApiData();

      emit(UpcomingMovieLoading());
      final res = await apiProvider.fetchUpcomingMovie();

      emit(UpcomingMovieLoaded(upcomingMovieModel: res));
    });
  }
}
