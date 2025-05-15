import 'package:rick_and_morty_app/feature/domain/entities/character_entity.dart';

abstract class CharacterState {
  const CharacterState();
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<CharacterEntity> characters;

  const CharacterLoaded({required this.characters});
}

class CharacterLoadToCashe extends CharacterState {}

class CharacterError extends CharacterState {
  final String message;
  const CharacterError({required this.message});
}
