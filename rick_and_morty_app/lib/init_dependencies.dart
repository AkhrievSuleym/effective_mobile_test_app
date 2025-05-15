import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty_app/core/network/connection.dart';
import 'package:rick_and_morty_app/feature/data/datasources/local_data_source.dart';
import 'package:rick_and_morty_app/feature/data/datasources/remote_data_source.dart';
import 'package:rick_and_morty_app/feature/data/repositories/character_repo_impl.dart';
import 'package:rick_and_morty_app/feature/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_app/feature/domain/usecases/get_all_characters.dart';
import 'package:rick_and_morty_app/feature/domain/usecases/load_character.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/character_bloc.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'notes'));
  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerLazySingleton(() => Logger());
  serviceLocator.registerLazySingleton(() => http.Client());

  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));

  serviceLocator
    //DataSource
    ..registerFactory<RemoteDataSource>(
      () => RemoteDataSourceImpl(
        client: serviceLocator(),
      ),
    )
    ..registerFactory<LocalDataSource>(
      () => LocalDataSourceImpl(
        characterBox: serviceLocator(),
      ),
    )
    ..registerFactory<CharacterRepository>(
      () => CharacterRepoImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )

    //Usecase
    ..registerFactory(() => GetAllCharacters(
          serviceLocator(),
        ))
    ..registerFactory(
      () => LoadCharacter(
        serviceLocator(),
      ),
    );

  serviceLocator.registerLazySingleton(
    () => CharacterBloc(
      getAllCharacters: serviceLocator(),
      loadCharacter: serviceLocator(),
    ),
  );
}
