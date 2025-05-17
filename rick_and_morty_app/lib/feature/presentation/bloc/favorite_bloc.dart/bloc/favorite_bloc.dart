import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_app/feature/domain/entities/character_entity.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final Box<Map<String, dynamic>> favoritesBox;

  FavoritesBloc() : super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) {});
  }
}
