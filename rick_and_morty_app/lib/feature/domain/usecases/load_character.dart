import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/core/usecases/usecase.dart';
import 'package:rick_and_morty_app/feature/domain/repositories/character_repository.dart';

class UploadCharacter extends UseCase<void, UploadCharacterParams> {
  final CharacterRepository characterRepository;

  UploadCharacter(this.characterRepository);

  @override
  Future<Either<Failure, void>> call(UploadCharacterParams params) async {
    return characterRepository.uploadCharacter(
      id: params.id,
      name: params.name,
      status: params.status,
      species: params.species,
      gender: params.gender,
      image: params.image,
    );
  }
}

class UploadCharacterParams {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  UploadCharacterParams({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });
}
