import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/core/usecases/usecase.dart';
import 'package:rick_and_morty_app/feature/domain/repositories/character_repository.dart';

class LoadCharacter extends UseCase<void, LoadCharacterParams> {
  final CharacterRepository characterRepository;

  LoadCharacter(this.characterRepository);

  @override
  Future<Either<Failure, void>> call(LoadCharacterParams params) async {
    return characterRepository.loadCharacter(
        id: params.id,
        name: params.name,
        status: params.status,
        species: params.species,
        type: params.type,
        gender: params.gender,
        image: params.image,
        episode: params.episode,
        created: params.created);
  }
}

class LoadCharacterParams {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final List<String> episode;
  final DateTime created;

  LoadCharacterParams(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.image,
      required this.episode,
      required this.created});
}
