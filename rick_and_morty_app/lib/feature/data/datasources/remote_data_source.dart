import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/core/error/exceptions.dart';
import 'package:rick_and_morty_app/feature/data/models/character_model.dart';

abstract class RemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters(int page);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> getAllCharacters(int page) async {
    final response = await client.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => CharacterModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
