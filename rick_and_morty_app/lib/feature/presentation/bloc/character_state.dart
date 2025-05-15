import 'package:rick_and_morty_app/feature/domain/entities/character_entity.dart';

abstract class CharacterState {
  const CharacterState();
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {
  final List<CharacterEntity> oldCharactersList;
  final bool isFirstFetch;

  const CharacterLoading(this.oldCharactersList, {this.isFirstFetch = false});
}

class CharacterLoaded extends CharacterState {
  final List<CharacterEntity> characters;

  const CharacterLoaded({required this.characters});
}

class CharacterLoadToCache extends CharacterState {}

class CharacterError extends CharacterState {
  final String message;
  const CharacterError({required this.message});
}
