import 'dart:async';

import '../../services/movies_service.dart';
import '../models/movies_result.dart';

class MoviesRepository {
  const MoviesRepository(this.service);

  final MoviesService service;

  Future<MoviesResult> getPopularMovies() async =>
      await service.getPopularMovies();

  Future<MoviesResult> getTopRatedMovies() async =>
      await service.getTopRatedMovies();

  Future<MoviesResult> getUpcomingMovies() async =>
      await service.getUpcomingMovies();
}
