import 'dart:convert';

import 'package:rick_and_morty_app/feature/data/models/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<CharacterModel>> getFavorites();
  Future<void> addFavorite({required CharacterModel character});
  Future<void> removeFavorite({required int id});
}

class LocalDataSourceImpl implements LocalDataSource {
  static const _favoritesKey = 'favorite_characters';

  @override
  Future<List<CharacterModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList = prefs.getStringList(_favoritesKey) ?? [];

    return jsonStringList
        .map((json) => CharacterModel.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> saveFavorites(List<CharacterModel> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = favorites.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(_favoritesKey, jsonList);
  }

  @override
  Future<void> addFavorite({required CharacterModel character}) async {
    final prefs = await SharedPreferences.getInstance();
    final currentFavorites = await getFavorites();
    if (!currentFavorites.any((c) => c.id == character.id)) {
      currentFavorites.add(character);
      await saveFavorites(currentFavorites);
    }
  }

  @override
  Future<void> removeFavorite({required int id}) async {
    final prefs = await SharedPreferences.getInstance();
    final currentFavorites = await getFavorites();
    currentFavorites.removeWhere((c) => c.id == id);
    await saveFavorites(currentFavorites);
  }
}
