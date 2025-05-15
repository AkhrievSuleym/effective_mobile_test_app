import 'package:rick_and_morty_app/feature/domain/entities/character_entity.dart';

abstract class CharacterState {
  const CharacterState();
}

class CharacterEmpty extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<CharacterEntity> characters;

  const CharacterLoaded({required this.characters});
}

class CharacterError extends CharacterState {
  final String message;
  const CharacterError({required this.message});
}
