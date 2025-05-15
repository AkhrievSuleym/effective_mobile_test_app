import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/feature/data/models/character_model.dart';

abstract class LocalDataSource {
  List<CharacterModel> loadCharacters();
  Future<void> uploadLocalCharacter({required CharacterModel character});
}

const CHARACTER_BOX = 'character_box';

class LocalDataSourceImpl implements LocalDataSource {
  final Box<Map<String, dynamic>> characterBox;

  LocalDataSourceImpl({required this.characterBox});

  @override
  List<CharacterModel> loadCharacters() {
    final List<CharacterModel> characters = [];
    for (int i = 0; i < characterBox.length; i++) {
      final characterJson = characterBox.get(i.toString());
      if (characterJson != null) {
        characters.add(CharacterModel.fromJson(characterJson));
      }
    }
    return characters;
  }

  @override
  Future<void> uploadLocalCharacter({required CharacterModel character}) async {
    characterBox.put(character.id.toString(), character.toJson());
  }
}
