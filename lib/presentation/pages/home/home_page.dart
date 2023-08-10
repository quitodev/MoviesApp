part of '../pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: '/'),
      builder: (_) => const HomePage(),
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
            return const _HomeContent();
          }
          return const ErrorMessage();
        },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color.fromARGB(255, 32, 32, 32),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchButton(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/search_page',
                ),
              ),
              const Divider(color: Colors.yellow),
              const SizedBox(height: 32),
              const TitleText(
                text: 'MÁS POPULARES',
                iconLeft: Icons.star_outline_rounded,
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return ListMovies(
                    movies: state.popularMovies,
                  );
                },
              ),
              const TitleText(
                text: 'MÁS VOTADAS',
                iconLeft: Icons.thumb_up_outlined,
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return ListMovies(
                    movies: state.topRatedMovies,
                  );
                },
              ),
              const TitleText(
                text: 'EN CARTELERA PRONTO',
                iconLeft: Icons.movie_outlined,
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return ListMovies(
                    movies: state.upcomingMovies,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
