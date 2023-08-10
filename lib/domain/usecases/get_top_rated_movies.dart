part of 'usecases.dart';

class GetTopRatedMovies {
  GetTopRatedMovies(this.homeRepository);

  final IHomeRepository homeRepository;

  Future<Either<String, List<Movie>>> call() async {
    return homeRepository.getTopRatedMovies();
  }
}
