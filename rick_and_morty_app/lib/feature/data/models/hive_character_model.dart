import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/feature/domain/entities/character_entity.dart';

part 'hive_character_model.g.dart';

@HiveType(typeId: 0)
class LocalCharacter extends CharacterEntity {
  @override
  @HiveField(0)
  int id;
  @override
  @HiveField(1)
  String name;
  @override
  @HiveField(2)
  String status;
  @override
  @HiveField(3)
  String image;
  @override
  @HiveField(4)
  String species;
  @override
  @HiveField(5)
  String gender;
  LocalCharacter({
    this.id = 0,
    this.name = '',
    this.status = '',
    this.image = '',
    this.species = '',
    this.gender = '',
  }) : super(id: 0, name: '', status: '', species: '', gender: '', image: '');
}
