import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/characters_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        centerTitle: true,
      ),
      body: CharactersList(),
    );
  }
}
