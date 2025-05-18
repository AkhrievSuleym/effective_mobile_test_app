import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/feature/data/models/character_model.dart';
import 'package:rick_and_morty_app/feature/domain/usecases/get_all_characters.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetAllCharacters _getAllCharacters;
  final Logger logger = Logger();

  CharacterBloc({
    required GetAllCharacters getAllCharacters,
  })  : _getAllCharacters = getAllCharacters,
        super(CharacterInitial()) {
    on<GetCharactersEvent>(_onGetAllCharacters);
  }

  void _onGetAllCharacters(
      GetCharactersEvent event, Emitter<CharacterState> emit) async {
    final currentState = state;

    var oldCharacters = <CharacterModel>[];
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

  String _failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Server Failure';
      default:
        return '?? failure)';
    }
  }
}
