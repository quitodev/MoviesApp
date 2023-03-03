import '../../domain/models/movie.dart';

abstract class MoviesEvent {
  const MoviesEvent();
}

class GetMovies extends MoviesEvent {
  const GetMovies();
}

class ShowMovies extends MoviesEvent {
  const ShowMovies();
}

class ShowDetail extends MoviesEvent {
  const ShowDetail({required this.movie});

  final Movie movie;
}

class SearchMovie extends MoviesEvent {
  const SearchMovie({required this.search});

  final String search;
}
