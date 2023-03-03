import 'package:bloc/bloc.dart';

import '../../domain/models/movie.dart';
import '../../domain/models/movies_result.dart';
import '../../domain/models/movies_result_error.dart';
import '../../domain/repository/movies_repository.dart';
import 'movies_events.dart';
import 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc({required this.moviesRepository}) : super(MoviesStateLoading()) {
    on<GetMovies>(_getMovies);
    on<ShowMovies>(_showMovies);
    on<ShowDetail>(_showDetail);
    on<SearchMovie>(_searchMovie);
  }

  final MoviesRepository moviesRepository;

  Future<void> _getMovies(
    GetMovies event,
    Emitter<MoviesState> emit,
  ) async {
    emit(MoviesStateLoading());
    try {
      final MoviesResult popular = await moviesRepository.getPopularMovies();
      final MoviesResult topRated = await moviesRepository.getTopRatedMovies();
      final MoviesResult upcoming = await moviesRepository.getUpcomingMovies();
      final Movies movies = Movies(
        popular: popular.movies,
        topRated: topRated.movies,
        upcoming: upcoming.movies,
      );
      emit(MoviesStateLoaded(movies));
    } catch (error) {
      emit(
        error is MoviesResultError
            ? MoviesStateError(error.message)
            : const MoviesStateError('Algo salió mal :('),
      );
    }
  }

  Future<void> _showMovies(
    ShowMovies event,
    Emitter<MoviesState> emit,
  ) async {
    if (state is MoviesStateSearching) {
      final state = this.state as MoviesStateSearching;
      emit(MoviesStateLoaded(Movies(
        popular: List.from(state.movies.popular),
        topRated: List.from(state.movies.topRated),
        upcoming: List.from(state.movies.upcoming),
      )));
    }
    if (state is MoviesStateDetail) {
      final state = this.state as MoviesStateDetail;
      emit(MoviesStateLoaded(Movies(
        popular: List.from(state.movies.popular),
        topRated: List.from(state.movies.topRated),
        upcoming: List.from(state.movies.upcoming),
      )));
    }
  }

  Future<void> _showDetail(
    ShowDetail event,
    Emitter<MoviesState> emit,
  ) async {
    if (state is MoviesStateLoaded) {
      final state = this.state as MoviesStateLoaded;
      emit(MoviesStateDetail(Movies(
        popular: List.from(state.movies.popular),
        topRated: List.from(state.movies.topRated),
        upcoming: List.from(state.movies.upcoming),
        detail: event.movie,
      )));
    }
    if (state is MoviesStateSearching) {
      final state = this.state as MoviesStateSearching;
      emit(MoviesStateDetail(Movies(
        popular: List.from(state.movies.popular),
        topRated: List.from(state.movies.topRated),
        upcoming: List.from(state.movies.upcoming),
        detail: event.movie,
        search: state.movies.search == null
            ? null
            : List.from(state.movies.search!),
      )));
    }
  }

  Future<void> _searchMovie(
    SearchMovie event,
    Emitter<MoviesState> emit,
  ) async {
    if (state is MoviesStateLoaded) {
      if (event.search.isEmpty) {
        final state = this.state as MoviesStateLoaded;
        return emit(MoviesStateSearching(state.movies));
      }
    }
    if (state is MoviesStateSearching) {
      final state = this.state as MoviesStateSearching;
      final List<Movie> moviesFound = [];
      final movies = <dynamic>{};
      state.movies.popular
          .where((movie) =>
              movie.title.toLowerCase().contains(event.search.toLowerCase()))
          .toList()
          .forEach((movie) {
        moviesFound.add(movie);
      });
      state.movies.topRated
          .where((movie) =>
              movie.title.toLowerCase().contains(event.search.toLowerCase()))
          .toList()
          .forEach((movie) {
        moviesFound.add(movie);
      });
      state.movies.upcoming
          .where((movie) =>
              movie.title.toLowerCase().contains(event.search.toLowerCase()))
          .toList()
          .forEach((movie) {
        moviesFound.add(movie);
      });
      moviesFound.retainWhere((movie) => movies.add(movie.title));
      emit(MoviesStateSearching(Movies(
        popular: List.from(state.movies.popular),
        topRated: List.from(state.movies.topRated),
        upcoming: List.from(state.movies.upcoming),
        search: event.search.isEmpty
            ? null
            : moviesFound
                .where((movie) => movies.contains(movie.title))
                .toList(),
      )));
    }
  }
}
