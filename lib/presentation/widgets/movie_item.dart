part of 'widgets.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/movie_page',
        arguments: movie,
      ),
      child: SizedBox(
        height: 200,
        width: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'http://image.tmdb.org/t/p/w500/${movie.posterPath}',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
