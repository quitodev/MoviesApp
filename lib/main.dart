import 'package:flutter/material.dart';
import 'package:movies_app/app_routes.dart';
import 'package:movies_app/injection_container.dart' as di;
import 'package:movies_app/presentation/pages/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        primaryColor: Colors.black54,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Movies App'),
          backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        ),
        body: const HomePage(),
      ),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: '/',
    );
  }
}
