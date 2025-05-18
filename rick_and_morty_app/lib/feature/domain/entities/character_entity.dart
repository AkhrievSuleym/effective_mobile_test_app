import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String status;
  final String image;
  final String species;
  final String gender;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        gender,
        image,
      ];
}

class LocationEntity {
  final String name;
  final String url;

  const LocationEntity({required this.name, required this.url});
}
