import '../../domain/models/movie.dart';

abstract class MoviesState {
  const MoviesState();
}

class MoviesStateLoading extends MoviesState {}

class MoviesStateLoaded extends MoviesState {
  const MoviesStateLoaded(this.movies);

  final Movies movies;
}

class MoviesStateDetail extends MoviesState {
  const MoviesStateDetail(this.movies);

  final Movies movies;
}

class MoviesStateSearching extends MoviesState {
  const MoviesStateSearching(this.movies);

  final Movies movies;
}

class MoviesStateError extends MoviesState {
  const MoviesStateError(this.error);

  final String error;
}
