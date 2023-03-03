class Movie {
  const Movie({
    required this.uid,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
  });

  final int uid;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String title;
  final String voteAverage;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      uid: json['id'] as int,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String,
      releaseDate: json['release_date'] as String,
      title: json['title'] as String,
      voteAverage: json['vote_average'].toString(),
    );
  }
}

class Movies {
  Movies({
    required this.popular,
    required this.topRated,
    required this.upcoming,
    this.detail,
    this.search,
  });

  final List<Movie> popular;
  final List<Movie> topRated;
  final List<Movie> upcoming;
  late final Movie? detail;
  late final List<Movie>? search;
}
