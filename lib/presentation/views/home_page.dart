import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/movie.dart';
import '../bloc/movies_bloc.dart';
import '../bloc/movies_events.dart';
import '../bloc/movies_state.dart';
import 'movie_detail_page.dart';
import 'movie_widget.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MoviesBloc _moviesBloc;

  @override
  void initState() {
    super.initState();
    _moviesBloc = context.read<MoviesBloc>();
    _moviesBloc.add(const GetMovies());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesStateLoading) {
          return Container(
            color: const Color.fromARGB(255, 32, 32, 32),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.yellow,
              ),
            ),
          );
        }
        if (state is MoviesStateLoaded) {
          return _HomeBody(movies: state.movies);
        }
        if (state is MoviesStateSearching) {
          return const SearchPage();
        }
        if (state is MoviesStateDetail) {
          return MovieDetailPage(movie: state.movies.detail!);
        }
        if (state is MoviesStateError) {
          return Center(child: Text(state.error));
        }
        return const Center(child: Text('Error de estado'));
      },
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({required this.movies});

  final Movies movies;

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
              InkWell(
                onTap: () => _showSearchPage(context),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.yellow),
                    SizedBox(width: 8),
                    Text('Buscar una película...',
                        style: TextStyle(color: Colors.yellow)),
                    Spacer(),
                  ],
                ),
              ),
              const Divider(color: Colors.yellow),
              const SizedBox(height: 32),
              const Text(
                'MÁS POPULARES',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              MovieWidget(movies: movies.popular),
              const Text(
                'MÁS VOTADAS',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              MovieWidget(movies: movies.topRated),
              const Text(
                'EN CARTELERA PRONTO',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              MovieWidget(movies: movies.upcoming),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchPage(BuildContext context) {
    final MoviesBloc moviesBloc = context.read<MoviesBloc>();
    moviesBloc.add(const SearchMovie(search: ""));
  }
}
