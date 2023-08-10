part of 'entities.dart';

class Movie extends Equatable {
  const Movie({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
  });

  factory Movie.empty() {
    return const Movie(
      id: 0,
      overview: '',
      posterPath: '',
      releaseDate: '',
      title: '',
      voteAverage: '',
    );
  }

  final int id;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String title;
  final String voteAverage;

  @override
  List<Object?> get props => [
        id,
        overview,
        posterPath,
        releaseDate,
        title,
        voteAverage,
      ];
}
