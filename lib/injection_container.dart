import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/data/datasources/datasources.dart';
import 'package:movies_app/data/repositories/repositories_impl.dart';
import 'package:movies_app/domain/repositories/repositories.dart';
import 'package:movies_app/domain/usecases/usecases.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  await setupHome();
}

Future<void> setupHome() async {
  getIt
    // DATASOURCES
    ..registerLazySingleton<IHomeDataSource>(
      () => HomeDataSource(
        httpClient: http.Client(),
      ),
    )
    // REPOSITORIES
    ..registerLazySingleton<IHomeRepository>(
      () => HomeRepositoryImpl(
        getIt<IHomeDataSource>(),
      ),
    )
    // USECASES
    ..registerLazySingleton<GetPopularMovies>(
      () => GetPopularMovies(
        getIt<IHomeRepository>(),
      ),
    )
    ..registerLazySingleton<GetTopRatedMovies>(
      () => GetTopRatedMovies(
        getIt<IHomeRepository>(),
      ),
    )
    ..registerLazySingleton<GetUpcomingMovies>(
      () => GetUpcomingMovies(
        getIt<IHomeRepository>(),
      ),
    );
}
