import 'package:rick_and_morty_app/feature/domain/entities/character_entity.dart';

class Character extends CharacterEntity {
  const Character({
    required id,
    required name,
    required status,
    required species,
    required gender,
    required image,
  }) : super(
          id: id,
          name: name,
          status: status,
          species: species,
          gender: gender,
          image: image,
        );

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
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
