part of 'favorite_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesDelete extends FavoritesState {}

class FavoriteUploaded extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<CharacterEntity> characters;

  const FavoritesLoaded(this.characters);
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}
