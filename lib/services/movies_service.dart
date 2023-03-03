import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/models/movies_result.dart';
import '../domain/models/movies_result_error.dart';

class MoviesService {
  MoviesService({
    http.Client? httpClient,
    this.baseUrl = 'https://api.themoviedb.org/3',
    this.apiKey = '8627cbb6881fbd622136e2f4aad3c344',
  }) : httpClient = httpClient ?? http.Client();

  final http.Client httpClient;
  final String baseUrl;
  final String apiKey;

  Future<MoviesResult> getPopularMovies() async {
    final response = await httpClient.get(Uri.parse(
      '$baseUrl/movie/popular?api_key=$apiKey&language=es-ES&page=1',
    ));
    final results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return MoviesResult.fromJson(results);
    } else {
      throw MoviesResultError.fromJson(results);
    }
  }

  Future<MoviesResult> getTopRatedMovies() async {
    final response = await httpClient.get(Uri.parse(
      '$baseUrl/movie/top_rated?api_key=$apiKey&language=es-ES&page=1',
    ));
    final results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return MoviesResult.fromJson(results);
    } else {
      throw MoviesResultError.fromJson(results);
    }
  }

  Future<MoviesResult> getUpcomingMovies() async {
    final response = await httpClient.get(Uri.parse(
      '$baseUrl/movie/upcoming?api_key=$apiKey&language=es-ES&page=1',
    ));
    final results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return MoviesResult.fromJson(results);
    } else {
      throw MoviesResultError.fromJson(results);
    }
  }
}
