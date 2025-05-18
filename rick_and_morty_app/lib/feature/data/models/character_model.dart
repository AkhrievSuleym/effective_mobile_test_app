class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'gender': gender,
        'image': image,
      };

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json['id'] as int,
        name: json['name'] as String,
        status: json['status'] as String,
        species: json['species'] as String,
        gender: json['gender'] as String,
        image: json['image'] as String,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
