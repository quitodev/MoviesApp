part of 'datasources.dart';

abstract class IHomeDataSource {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<MovieModel>> getUpcomingMovies();
}

class HomeDataSource implements IHomeDataSource {
  HomeDataSource({
    required this.httpClient,
  });

  final http.Client httpClient;

  static const String baseUrl = 'https://api.themoviedb.org/3/movie';
  static const String apiKey = apiKeyDb;

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await httpClient.get(Uri.parse(
      '$baseUrl/popular?api_key=$apiKey&language=es-ES&page=1',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return List<MovieModel>.from(
        data['results'].map(MovieModel.fromJson).toList(),
      );
    } else {
      //print('ERROR: ${response.body}');
      return List.empty();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await httpClient.get(Uri.parse(
      '$baseUrl/top_rated?api_key=$apiKey&language=es-ES&page=1',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return List<MovieModel>.from(
        data['results'].map(MovieModel.fromJson).toList(),
      );
    } else {
      //print('ERROR: ${response.body}');
      return List.empty();
    }
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    // final response = await httpClient.get(Uri.parse(
    //   '$baseUrl/upcoming?api_key=$apiKey&language=es-ES&page=1',
    // ));
    // final results = json.decode(response.body) as Map<String, dynamic>;

    // if (response.statusCode == 200) {
    //   return MoviesResult.fromJson(results);
    // } else {
    //   throw MoviesResultError.fromJson(results);
    // }
    final response = await httpClient.get(Uri.parse(
      '$baseUrl/upcoming?api_key=$apiKey&language=es-ES&page=1',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return List<MovieModel>.from(
        data['results'].map(MovieModel.fromJson).toList(),
      );
    } else {
      //print('ERROR: ${response.body}');
      return List.empty();
    }
  }
}
