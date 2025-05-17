part of 'favorite_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent {}

class RemoveFavoriteEvent extends FavoritesEvent {
  final int characterId;

  const RemoveFavoriteEvent(this.characterId);

  @override
  List<Object> get props => [characterId];
}
