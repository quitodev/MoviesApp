part of 'usecases.dart';

class GetUpcomingMovies {
  GetUpcomingMovies(this.homeRepository);

  final IHomeRepository homeRepository;

  Future<Either<String, List<Movie>>> call() async {
    return homeRepository.getUpcomingMovies();
  }
}
