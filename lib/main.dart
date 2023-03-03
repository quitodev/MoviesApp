import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/repository/movies_repository.dart';
import 'presentation/bloc/movies_bloc.dart';
import 'presentation/views/home_page.dart';
import 'services/movies_service.dart';

void main() {
  runApp(MyApp(moviesRepository: MoviesRepository(MoviesService())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.moviesRepository});

  final MoviesRepository moviesRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoviesApp',
      theme: ThemeData(
        primaryColor: Colors.black54,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MoviesApp'),
          backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        ),
        body: BlocProvider(
          create: (_) => MoviesBloc(moviesRepository: moviesRepository),
          child: const HomePage(),
        ),
      ),
    );
  }
}
