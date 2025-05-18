import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/core/usecases/usecase.dart';
import 'package:rick_and_morty_app/feature/data/models/hive_character_model.dart';
import 'package:rick_and_morty_app/feature/domain/repositories/character_repository.dart';

class GetAllFavoriteCharacters
    extends UseCase<List<CharacterModel>, EmptyParams> {
  final CharacterRepository characterRepository;

  GetAllFavoriteCharacters(this.characterRepository);

  @override
  Future<Either<Failure, List<CharacterModel>>> call(EmptyParams params) async {
    return await characterRepository.getAllFavoriteCharacters();
  }
}

class EmptyParams extends Equatable {
  @override
  List<Object?> get props => [];
}
