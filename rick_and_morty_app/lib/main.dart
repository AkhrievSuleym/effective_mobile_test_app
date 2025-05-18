import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty_app/core/theme/app_theme.dart';
import 'package:rick_and_morty_app/feature/data/models/character_model.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/characters_bloc.dart/character_bloc.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/favorite_bloc.dart/bloc/favorite_bloc.dart';
import 'package:rick_and_morty_app/feature/presentation/pages/characters_page.dart';
import 'package:rick_and_morty_app/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<CharacterBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<FavoritesBloc>(),
      ),
    ],
    child: const RickAndMortyApp(),
  ));
}

class RickAndMortyApp extends StatefulWidget {
  const RickAndMortyApp({super.key});

  @override
  State<RickAndMortyApp> createState() => _RickAndMortyAppState();
}

class _RickAndMortyAppState extends State<RickAndMortyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const HomePage(),
    );
  }
}
