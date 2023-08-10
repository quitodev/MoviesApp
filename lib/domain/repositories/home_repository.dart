part of 'repositories.dart';

abstract class IHomeRepository {
  Future<Either<String, List<Movie>>> getPopularMovies();
  Future<Either<String, List<Movie>>> getTopRatedMovies();
  Future<Either<String, List<Movie>>> getUpcomingMovies();
}
