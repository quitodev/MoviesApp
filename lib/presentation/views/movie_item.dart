import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/movie.dart';
import '../bloc/movies_bloc.dart';
import '../bloc/movies_events.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDetailPage(context),
      child: SizedBox(
        height: 200,
        width: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'http://image.tmdb.org/t/p/w500/${movie.posterPath}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _showDetailPage(BuildContext context) {
    final MoviesBloc moviesBloc = context.read<MoviesBloc>();
    moviesBloc.add(ShowDetail(movie: movie));
  }
}
