import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/feature/domain/entities/character_entity.dart';
import 'package:rick_and_morty_app/feature/domain/usecases/get_all_characters.dart';
import 'package:rick_and_morty_app/feature/domain/usecases/load_character.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetAllCharacters _getAllCharacters;
  final LoadCharacter _loadCharacter;
  final Logger logger = Logger();

  CharacterBloc(
      {required GetAllCharacters getAllCharacters,
      required LoadCharacter loadCharacter})
      : _getAllCharacters = getAllCharacters,
        _loadCharacter = loadCharacter,
        super(CharacterInitial()) {
    on<GetCharactersEvent>(_onGetAllCharacters);
    on<LoadCharacterToCacheEvent>(_onLoadCharacter);
  }

  void _onGetAllCharacters(
      GetCharactersEvent event, Emitter<CharacterState> emit) async {
    final currentState = state;

    var oldCharacters = <CharacterEntity>[];
    if (currentState is CharacterLoaded) {
      oldCharacters = currentState.characters;
    }

    emit(CharacterLoading(oldCharacters, isFirstFetch: event.page == 1));

    final failureOrCharacters =
        await _getAllCharacters(GetCharacterParams(page: event.page));

    failureOrCharacters.fold(
        (failure) => emit(CharacterError(message: _failureToMessage(failure))),
        (character) {
      final characters = (state as CharacterLoading).oldCharactersList;
      characters.addAll(character);
      emit(CharacterLoaded(characters: characters));
    });
  }

  void _onLoadCharacter(
      LoadCharacterToCacheEvent event, Emitter<CharacterState> emit) async {
    final res = await _loadCharacter(LoadCharacterParams(
        id: event.id,
        name: event.name,
        status: event.status,
        species: event.species,
        type: event.type,
        gender: event.gender,
        image: event.image,
        episode: event.episode,
        created: event.created));

    res.fold(
        (failure) => emit(CharacterError(message: _failureToMessage(failure))),
        (character) => emit(CharacterLoadToCache()));
  }

  String _failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Server Failure';
      default:
        return '?? failure)';
    }
  }
}
