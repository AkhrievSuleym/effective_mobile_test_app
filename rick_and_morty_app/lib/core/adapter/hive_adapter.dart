import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/feature/data/models/character_model.dart';

class CharacterModelAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 0; // Уникальный ID

  @override
  Character read(BinaryReader reader) {
    final map = reader.readMap().cast<String, dynamic>();
    return Character.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer.writeMap(obj.toJson());
  }
}
