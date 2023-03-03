class MoviesResultError implements Exception {
  MoviesResultError({required this.message});

  final String message;

  factory MoviesResultError.fromJson(Map<String, dynamic> json) {
    return MoviesResultError(
      message: json['status_message'] as String,
    );
  }
}
