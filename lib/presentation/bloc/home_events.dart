part of 'home_bloc.dart';

abstract class HomeEvents {
  const HomeEvents();
}

class GetMovies extends HomeEvents {
  const GetMovies();
}

class SearchMovie extends HomeEvents {
  const SearchMovie({
    required this.search,
  });

  final String search;
}
