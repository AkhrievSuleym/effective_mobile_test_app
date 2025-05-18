import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/core/usecases/usecase.dart';
import 'package:rick_and_morty_app/feature/domain/entities/character_entity.dart';
import 'package:rick_and_morty_app/feature/domain/repositories/character_repository.dart';

class GetAllFavoriteCharacters
    extends UseCase<List<CharacterEntity>, EmptyParams> {
  final CharacterRepository characterRepository;

  GetAllFavoriteCharacters(this.characterRepository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(
      EmptyParams params) async {
    return await characterRepository.getAllFavoriteCharacters();
  }
}

class EmptyParams extends Equatable {
  @override
  List<Object?> get props => [];
}
