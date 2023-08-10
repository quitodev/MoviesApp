part of 'widgets.dart';

class ListMovies extends StatelessWidget {
  const ListMovies({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: SizedBox(
        height: 200,
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return MovieItem(
              movie: movies[index],
            );
          },
        ),
      ),
    );
  }
}
