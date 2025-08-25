import 'package:app_cars_front/core/core.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap({required String env}) async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the environment configuration.
  late final Env envConfig = EnvUtil.getEnvConfig(env);
  // Configure the dependency injection.
  await configureDependencies(envConfig);
  // Run the app with the initialized environment configuration.
  runApp(CarsApp(envConfig: envConfig));
}

class CarsApp extends StatelessWidget {
  const CarsApp({super.key, required this.envConfig});

  final Env envConfig;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: appRouter,
    );
  }
}
