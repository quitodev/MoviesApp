part of 'models.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
    required super.title,
    required super.voteAverage,
  });

  factory MovieModel.fromJson(dynamic json) {
    return MovieModel(
      id: json['id'] as int,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String,
      releaseDate: json['release_date'] as String,
      title: json['title'] as String,
      voteAverage: json['vote_average'].toString(),
    );
  }
}
