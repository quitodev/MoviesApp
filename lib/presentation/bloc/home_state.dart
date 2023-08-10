part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.status,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
    required this.allMovies,
    required this.movieSearch,
  });

  final HomeStatus status;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;
  final List<Movie> allMovies;
  final List<Movie> movieSearch;

  HomeState copyWith({
    HomeStatus? status,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? upcomingMovies,
    List<Movie>? allMovies,
    List<Movie>? movieSearch,
  }) {
    return HomeState(
      status: status ?? this.status,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      allMovies: allMovies ?? this.allMovies,
      movieSearch: movieSearch ?? this.movieSearch,
    );
  }

  @override
  List<Object?> get props => [
        status,
        popularMovies,
        topRatedMovies,
        upcomingMovies,
        allMovies,
        movieSearch,
      ];
}

abstract class HomeStatus {}

class HomeInitial extends HomeStatus {}

class ShowLoading extends HomeStatus {}

class ShowData extends HomeStatus {}

class ShowError extends HomeStatus {}
