// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'hive_character_model.g.dart';

@HiveType(typeId: 1)
class CharacterModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String status;
  @HiveField(3)
  String image;
  @HiveField(4)
  String species;
  @HiveField(5)
  String gender;
  CharacterModel({
    this.id = 0,
    this.name = '',
    this.status = '',
    this.image = '',
    this.species = '',
    this.gender = '',
  });

  CharacterModel copyWith({
    int? id,
    String? name,
    String? status,
    String? image,
    String? species,
    String? gender,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      image: image ?? this.image,
      species: species ?? this.species,
      gender: gender ?? this.gender,
    );
  }

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'gender': gender,
      'image': image,
    };
  }
}
