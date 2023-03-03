import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/movie.dart';
import '../bloc/movies_bloc.dart';
import '../bloc/movies_events.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            color: const Color.fromARGB(255, 32, 32, 32),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.70,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    'http://image.tmdb.org/t/p/w500/${movie.posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        movie.releaseDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        movie.overview,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Puntaje: ${movie.voteAverage}",
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: IconButton(
              onPressed: () => _showHomePage(context),
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.yellow,
                size: 32,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showHomePage(BuildContext context) {
    final MoviesBloc moviesBloc = context.read<MoviesBloc>();
    moviesBloc.add(const ShowMovies());
  }
}
