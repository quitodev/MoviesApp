import 'movie.dart';

class MoviesResult {
  const MoviesResult({required this.movies});

  final List<Movie> movies;

  factory MoviesResult.fromJson(Map<String, dynamic> json) {
    final listMovies = (json['results'] as List<dynamic>)
        .map((dynamic movie) => Movie.fromJson(movie as Map<String, dynamic>))
        .toList();
    return MoviesResult(movies: listMovies);
  }
}
