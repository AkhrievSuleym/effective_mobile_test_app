import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/feature/data/models/hive_character_model.dart';
import 'package:rick_and_morty_app/feature/domain/usecases/delete_character.dart';
import 'package:rick_and_morty_app/feature/domain/usecases/get_favorite_chacarters.dart';
import 'package:rick_and_morty_app/feature/domain/usecases/load_character.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final UploadCharacter _uploadCharacter;
  final DeleteCharacter _deleteCharacter;
  final GetAllFavoriteCharacters _allFavoriteCharacters;

  FavoritesBloc(
      {required UploadCharacter uploadCharacter,
      required DeleteCharacter deleteCharacter,
      required GetAllFavoriteCharacters allFavoriteCharacters})
      : _uploadCharacter = uploadCharacter,
        _deleteCharacter = deleteCharacter,
        _allFavoriteCharacters = allFavoriteCharacters,
        super(FavoritesInitial()) {
    on<UploadFavoriteEvent>(_onUploadCharacter);
    on<RemoveFavoriteEvent>(_onDeleteFavorite);
    on<LoadCharactersEvent>(_onGetAllFavorites);
  }

  void _onGetAllFavorites(
      LoadCharactersEvent event, Emitter<FavoritesState> emit) async {
    final res = await _allFavoriteCharacters(EmptyParams());
    res.fold((failure) => emit(FavoritesError(_failureToMessage(failure))),
        (characters) => emit(FavoritesLoaded(characters)));
  }

  void _onDeleteFavorite(
      RemoveFavoriteEvent event, Emitter<FavoritesState> emit) async {
    final res =
        await _deleteCharacter(DeleteCharacterParams(id: event.characterId));
    await res.fold(
        (failure) async => emit(FavoritesError(_failureToMessage(failure))),
        (character) async {
      final characters = await _allFavoriteCharacters(EmptyParams());
      characters.fold(
        (failure) => emit(FavoritesError(_failureToMessage(failure))),
        (chars) => emit(FavoritesLoaded(chars)),
      );
    });
  }

  void _onUploadCharacter(
      UploadFavoriteEvent event, Emitter<FavoritesState> emit) async {
    final res = await _uploadCharacter(UploadCharacterParams(
      id: event.id,
      name: event.name,
      status: event.status,
      species: event.species,
      gender: event.gender,
      image: event.image,
    ));

    await res.fold(
        (failure) async => emit(FavoritesError(_failureToMessage(failure))),
        (character) async {
      final characters = await _allFavoriteCharacters(EmptyParams());
      characters.fold(
        (failure) => emit(FavoritesError(_failureToMessage(failure))),
        (chars) => emit(FavoritesLoaded(chars)),
      );
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
