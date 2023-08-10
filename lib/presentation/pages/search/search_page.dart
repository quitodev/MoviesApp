part of '../pages.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: '/search_page'),
      builder: (_) => const SearchPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        getPopularMoviesUseCase: getIt<GetPopularMovies>(),
        getTopRatedMoviesUseCase: getIt<GetTopRatedMovies>(),
        getUpcomingMoviesUseCase: getIt<GetUpcomingMovies>(),
      )..add(const GetMovies()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status is HomeInitial || state.status is ShowLoading) {
            return const CircularProgress();
          }
          if (state.status is ShowData) {
            return const _MoviesContent();
          }
          return const ErrorMessage();
        },
      ),
    );
  }
}

class _MoviesContent extends StatelessWidget {
  const _MoviesContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador de películas'),
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      ),
      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SearchField(
                  onChanged: (text) {
                    context.read<HomeBloc>().add(SearchMovie(search: text));
                  },
                  onCancel: () {
                    context.read<HomeBloc>().add(const SearchMovie(search: ""));
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                const GridMovies(),
                const SizedBox(
                  height: 24,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
