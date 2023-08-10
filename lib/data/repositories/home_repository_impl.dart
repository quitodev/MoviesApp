part of 'repositories_impl.dart';

class HomeRepositoryImpl implements IHomeRepository {
  HomeRepositoryImpl(this.homeDataSource);

  final IHomeDataSource homeDataSource;

  @override
  Future<Either<String, List<Movie>>> getPopularMovies() async {
    try {
      final result = await homeDataSource.getPopularMovies();
      return Right(result);
    } catch (_) {
      return const Left('Error de conexión');
    }
  }

  @override
  Future<Either<String, List<Movie>>> getTopRatedMovies() async {
    try {
      final result = await homeDataSource.getTopRatedMovies();
      return Right(result);
    } catch (_) {
      return const Left('Error de conexión');
    }
  }

  @override
  Future<Either<String, List<Movie>>> getUpcomingMovies() async {
    try {
      final result = await homeDataSource.getUpcomingMovies();
      return Right(result);
    } catch (_) {
      return const Left('Error de conexión');
    }
  }
}
