
import 'package:equatable/equatable.dart';

abstract class UpcomingMovieEvent extends Equatable {
  const UpcomingMovieEvent();

  @override
  List<Object> get props => [];
}

class GetUpcomingMovieList extends UpcomingMovieEvent {}