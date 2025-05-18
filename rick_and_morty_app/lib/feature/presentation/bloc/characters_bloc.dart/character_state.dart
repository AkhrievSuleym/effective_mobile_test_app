part of 'character_bloc.dart';

@immutable
sealed class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {
  final List<CharacterModel> oldCharactersList;
  final bool isFirstFetch;

  CharacterLoading(this.oldCharactersList, {this.isFirstFetch = false});
}

class CharacterLoaded extends CharacterState {
  final List<CharacterModel> characters;

  CharacterLoaded({required this.characters});
}

class CharacterLoadToCache extends CharacterState {}

class CharacterError extends CharacterState {
  final String message;
  CharacterError({required this.message});
}
