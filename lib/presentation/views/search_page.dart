import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/movie.dart';
import '../bloc/movies_bloc.dart';
import '../bloc/movies_events.dart';
import '../bloc/movies_state.dart';
import 'movie_item.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 32, 32, 32),
      child: Column(
        children: <Widget>[
          _SearchBar(),
          _SearchBody(),
        ],
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  late MoviesBloc _moviesBloc;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _moviesBloc = context.read<MoviesBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          color: const Color.fromARGB(255, 219, 219, 219),
          child: TextField(
            controller: _textController,
            autocorrect: false,
            onChanged: (text) {
              _moviesBloc.add(SearchMovie(search: text));
            },
            decoration: InputDecoration(
              prefixIconColor: const Color.fromARGB(255, 32, 32, 32),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: InkWell(
                onTap: _showMoviesPage,
                child: const Icon(
                  Icons.cancel_rounded,
                  color: Color.fromARGB(255, 129, 9, 0),
                ),
              ),
              border: InputBorder.none,
              hintText: 'Buscá la película que querés...',
            ),
          ),
        ),
      ),
    );
  }

  void _showMoviesPage() {
    _textController.text = '';
    _moviesBloc.add(const ShowMovies());
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesStateSearching) {
          return state.movies.search != null && state.movies.search!.isNotEmpty
              ? _SearchResult(movies: state.movies.search!)
              : const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _SearchResult extends StatelessWidget {
  const _SearchResult({required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 136,
          child: Wrap(
            children: List.generate(movies.length, ((index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: MovieItem(movie: movies[index]),
              );
            })),
          ),
        ),
      ),
    );
  }
}
