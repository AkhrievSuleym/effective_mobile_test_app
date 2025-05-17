import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/exceptions.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/core/network/connection.dart';
import 'package:rick_and_morty_app/feature/data/datasources/local_data_source.dart';
import 'package:rick_and_morty_app/feature/data/datasources/remote_data_source.dart';
import 'package:rick_and_morty_app/feature/data/models/character_model.dart';
import 'package:rick_and_morty_app/feature/domain/entities/character_entity.dart';
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
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(
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
        final localCharacters = characterLocalDataSource.loadCharacters();
        return right(localCharacters);
      } on CacheException {
        return left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> loadCharacter({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required String image,
    required List<String> episode,
    required DateTime created,
  }) async {
    try {
      CharacterModel character = CharacterModel(
        id: id,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
        origin: null,
        location: null,
        image: image,
        episode: episode,
        created: created,
      );
      characterLocalDataSource.uploadLocalCharacter(character: character);
      return right(null);
    } on CacheException {
      return left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteCharacter(String id) async {
    try {
      await characterLocalDataSource.deleteLocalCharacter(id: id);
      return right(null);
    } on CacheException {
      return left(CacheFailure());
    }
  }
}
