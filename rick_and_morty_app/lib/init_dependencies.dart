import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty_app/core/network/connection.dart';
import 'package:rick_and_morty_app/feature/data/datasources/remote_data_source.dart';
import 'package:rick_and_morty_app/feature/data/repositories/character_repo_impl.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'notes'));
  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerLazySingleton(() => Logger());

  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));
  
  serviceLocator
  //DataSource
  .registerFactory<RemoteDataSource>(
    () => CharacterRepoImpl(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    )
  )
}
