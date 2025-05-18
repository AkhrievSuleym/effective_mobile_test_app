import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/feature/data/models/hive_character_model.dart';

abstract class LocalDataSource {
  Future<List<CharacterModel>> loadCharacters();
  Future<void> uploadLocalCharacter({required CharacterModel character});
  Future<void> deleteLocalCharacter({required int id});
}

class LocalDataSourceImpl implements LocalDataSource {
  static const String _boxName = 'characters_box';

  Future<Box<CharacterModel>> get _box async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<CharacterModel>(_boxName);
    }
    return Hive.box<CharacterModel>(_boxName);
  }

  @override
  Future<List<CharacterModel>> loadCharacters() async {
    var box = await _box;
    return box.values.toList();
  }

  @override
  Future<void> uploadLocalCharacter({required CharacterModel character}) async {
    var box = await _box;
    await box.add(character);
  }

  @override
  Future<void> deleteLocalCharacter({required int id}) async {
    var box = await _box;
    await box.deleteAt(id);
  }
}
