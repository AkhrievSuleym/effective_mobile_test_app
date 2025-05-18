part of 'favorite_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadCharactersEvent extends FavoritesEvent {}

class UploadFavoriteEvent extends FavoritesEvent {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  const UploadFavoriteEvent({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final int characterId;

  const RemoveFavoriteEvent(this.characterId);

  @override
  List<Object> get props => [characterId];
}
