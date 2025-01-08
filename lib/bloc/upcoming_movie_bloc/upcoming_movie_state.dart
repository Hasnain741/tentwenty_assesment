import 'package:equatable/equatable.dart';
import 'package:tentwenty_assesment/models/upcoming_movie_model.dart';

abstract class UpcomingMovieState extends Equatable {
  const UpcomingMovieState();

  @override
  List<Object?> get props => [];
}

class UpcomingMovieInitial extends UpcomingMovieState {}

class UpcomingMovieLoading extends UpcomingMovieState {}

class UpcomingMovieLoaded extends UpcomingMovieState {
  final UpcomingMovieModel upcomingMovieModel;
  const UpcomingMovieLoaded({required this.upcomingMovieModel});

  @override
  List<Object?> get props => [upcomingMovieModel];
}

class UpcomingMovieError extends UpcomingMovieState {
  final String message;
  const UpcomingMovieError({required this.message});

  @override
  List<Object?> get props => [message];
}
