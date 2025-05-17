import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/core/usecases/usecase.dart';
import 'package:rick_and_morty_app/feature/domain/repositories/character_repository.dart';

class DeleteCharacter extends UseCase<void, DeleteCharacterParams> {
  final CharacterRepository characterRepository;

  DeleteCharacter(this.characterRepository);

  @override
  Future<Either<Failure, void>> call(DeleteCharacterParams params) {
    return characterRepository.deleteCharacter(params.id.toString());
  }
}

class DeleteCharacterParams {
  final int id;

  DeleteCharacterParams({required this.id});
}
