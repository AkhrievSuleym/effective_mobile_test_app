abstract class CharacterEvent {
  const CharacterEvent();
}

class GetCharacters extends CharacterEvent {
  final int page;

  GetCharacters({required this.page});
}

class LoadCharacterToCashe extends CharacterEvent {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final List<String> episode;
  final DateTime created;

  LoadCharacterToCashe(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.image,
      required this.episode,
      required this.created});
}
