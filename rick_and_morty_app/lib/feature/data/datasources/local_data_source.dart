import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/feature/data/models/character_model.dart';
import 'package:rick_and_morty_app/feature/data/models/hive_character_model.dart';

abstract class LocalDataSource {
  Future<List<LocalCharacter>> loadCharacters();
  Future<void> uploadLocalCharacter({required LocalCharacter character});
  Future<void> deleteLocalCharacter({required int id});
}

class LocalDataSourceImpl implements LocalDataSource {
  Future<Box<LocalCharacter>> get _box async =>
      await Hive.openBox<LocalCharacter>('characters_box');

  @override
  Future<List<LocalCharacter>> loadCharacters() async {
    var box = await _box;
    return box.values.toList();
  }

  @override
  Future<void> uploadLocalCharacter({required LocalCharacter character}) async {
    var box = await _box;
    await box.add(character);
  }

  @override
  Future<void> deleteLocalCharacter({required int id}) async {
    var box = await _box;
    await box.deleteAt(id);
  }
}
