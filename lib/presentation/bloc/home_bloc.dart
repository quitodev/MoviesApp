import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/domain/entities/entities.dart';
import 'package:movies_app/domain/usecases/usecases.dart';

part 'home_events.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  HomeBloc({
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
    required this.getUpcomingMoviesUseCase,
  }) : super(
          HomeState(
            status: HomeInitial(),
            popularMovies: List.empty(),
            topRatedMovies: List.empty(),
            upcomingMovies: List.empty(),
            allMovies: List.empty(),
            movieSearch: List.empty(),
          ),
        ) {
    on<GetMovies>(_getMovies);
    on<SearchMovie>(_searchMovie);
  }

  final GetPopularMovies getPopularMoviesUseCase;
  final GetTopRatedMovies getTopRatedMoviesUseCase;
  final GetUpcomingMovies getUpcomingMoviesUseCase;

  void _showLoading(Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        status: ShowLoading(),
      ),
    );
  }

  void _showError(Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        status: ShowError(),
      ),
    );
  }

  Future<void> _getMovies(
    GetMovies event,
    Emitter<HomeState> emit,
  ) async {
    _showLoading(emit);
    await _getPopularMovies(emit);
    await _getTopRatedMovies(emit);
    await _getUpcomingMovies(emit);
  }

  Future<void> _getPopularMovies(Emitter<HomeState> emit) async {
    final either = await getPopularMoviesUseCase.call();
    either.fold(
      (failure) {
        _showError(emit);
        return;
      },
      (popularMovies) {
        emit(
          state.copyWith(
            status: ShowData(),
            popularMovies: popularMovies,
            allMovies: List<Movie>.from(state.allMovies)..addAll(popularMovies),
            movieSearch: List<Movie>.from(state.movieSearch)
              ..addAll(popularMovies),
          ),
        );
      },
    );
  }

  Future<void> _getTopRatedMovies(Emitter<HomeState> emit) async {
    final either = await getTopRatedMoviesUseCase.call();
    either.fold(
      (failure) {
        _showError(emit);
        return;
      },
      (topRatedMovies) {
        emit(
          state.copyWith(
            status: ShowData(),
            topRatedMovies: topRatedMovies,
            allMovies: List<Movie>.from(state.allMovies)
              ..addAll(topRatedMovies),
            movieSearch: List<Movie>.from(state.movieSearch)
              ..addAll(topRatedMovies),
          ),
        );
      },
    );
  }

  Future<void> _getUpcomingMovies(Emitter<HomeState> emit) async {
    final either = await getUpcomingMoviesUseCase.call();
    either.fold(
      (failure) {
        _showError(emit);
        return;
      },
      (upcomingMovies) {
        emit(
          state.copyWith(
            status: ShowData(),
            upcomingMovies: upcomingMovies,
            allMovies: List<Movie>.from(state.allMovies)
              ..addAll(upcomingMovies),
            movieSearch: List<Movie>.from(state.movieSearch)
              ..addAll(upcomingMovies),
          ),
        );
      },
    );
  }

  Future<void> _searchMovie(
    SearchMovie event,
    Emitter<HomeState> emit,
  ) async {
    if (event.search.isEmpty) {
      emit(
        state.copyWith(
          movieSearch: state.allMovies,
        ),
      );
      return;
    }
    final List<Movie> movieSearch = List.empty(growable: true);
    movieSearch
      ..addAll(state.popularMovies
          .where(
            (movie) =>
                movie.title.toLowerCase().contains(event.search.toLowerCase()),
          )
          .toList())
      ..addAll(state.topRatedMovies
          .where(
            (movie) =>
                movie.title.toLowerCase().contains(event.search.toLowerCase()),
          )
          .toList())
      ..addAll(state.upcomingMovies
          .where(
            (movie) =>
                movie.title.toLowerCase().contains(event.search.toLowerCase()),
          )
          .toList());
    emit(
      state.copyWith(
        movieSearch: movieSearch,
      ),
    );
  }
}
