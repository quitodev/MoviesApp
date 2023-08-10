part of 'widgets.dart';

class GridMovies extends StatelessWidget {
  const GridMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 136,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.movieSearch.isEmpty) {
                return const Text(
                  'No se encontraron resultados',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                );
              }
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  state.movieSearch.length,
                  ((index) {
                    return MovieItem(
                      movie: state.movieSearch[index],
                    );
                  }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
