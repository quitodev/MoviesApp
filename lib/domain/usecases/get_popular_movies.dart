part of 'usecases.dart';

class GetPopularMovies {
  GetPopularMovies(this.homeRepository);

  final IHomeRepository homeRepository;

  Future<Either<String, List<Movie>>> call() async {
    return homeRepository.getPopularMovies();
  }
}
