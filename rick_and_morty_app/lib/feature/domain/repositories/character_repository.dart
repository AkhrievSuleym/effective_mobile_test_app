import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/feature/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(int page);
  Future<Either<Failure, List<CharacterEntity>>> getAllFavoriteCharacters();
  Future<Either<Failure, void>> uploadCharacter({
    required int id,
    required String name,
    required String status,
    required String species,
    required String gender,
    required String image,
  });
  Future<Either<Failure, void>> deleteCharacter(int id);
}
