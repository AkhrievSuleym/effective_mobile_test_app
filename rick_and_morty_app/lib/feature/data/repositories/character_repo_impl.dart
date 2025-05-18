import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/exceptions.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/core/network/connection.dart';
import 'package:rick_and_morty_app/feature/data/datasources/local_data_source.dart';
import 'package:rick_and_morty_app/feature/data/datasources/remote_data_source.dart';
import 'package:rick_and_morty_app/feature/data/models/hive_character_model.dart';
import 'package:rick_and_morty_app/feature/domain/repositories/character_repository.dart';

class CharacterRepoImpl implements CharacterRepository {
  final RemoteDataSource characterRemoteDataSource;
  final LocalDataSource characterLocalDataSource;
  final ConnectionChecker connectionChecker;

  CharacterRepoImpl(
    this.characterRemoteDataSource,
    this.characterLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, List<CharacterModel>>> getAllCharacters(
      int page) async {
    if (await connectionChecker.isConnected) {
      try {
        final characters =
            await characterRemoteDataSource.getAllCharacters(page);
        return right(characters);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localCharacters = await characterLocalDataSource.loadCharacters();
        return right(localCharacters);
      } on CacheException {
        return left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> uploadCharacter({
    required int id,
    required String name,
    required String status,
    required String species,
    required String gender,
    required String image,
  }) async {
    try {
      CharacterModel character = CharacterModel(
        id: id,
        name: name,
        status: status,
        species: species,
        gender: gender,
        image: image,
      );
      characterLocalDataSource.uploadLocalCharacter(character: character);
      return right(null);
    } on CacheException {
      return left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteCharacter(int id) async {
    try {
      await characterLocalDataSource.deleteLocalCharacter(id: id);
      return right(null);
    } on CacheException {
      return left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<CharacterModel>>>
      getAllFavoriteCharacters() async {
    try {
      final localCharacters = await characterLocalDataSource.loadCharacters();
      return right(localCharacters);
    } on CacheException {
      return left(CacheFailure());
    }
  }
}
