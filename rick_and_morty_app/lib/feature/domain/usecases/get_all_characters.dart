import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/core/usecases/usecase.dart';
import 'package:rick_and_morty_app/feature/domain/entities/character_entity.dart';
import 'package:rick_and_morty_app/feature/domain/repositories/character_repository.dart';

class GetAllCharacters
    extends UseCase<List<CharacterEntity>, GetCharacterParams> {
  final CharacterRepository characterRepository;

  GetAllCharacters(this.characterRepository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(
      GetCharacterParams params) async {
    return await characterRepository.getAllCharacters(params.page);
  }
}

class GetCharacterParams extends Equatable {
  final int page;

  const GetCharacterParams({required this.page});

  @override
  List<Object> get props => [page];
}
