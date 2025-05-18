import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/feature/data/models/character_model.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<CharacterModel>>> getAllCharacters(int page);
  Future<Either<Failure, List<CharacterModel>>> getAllFavoriteCharacters();
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
