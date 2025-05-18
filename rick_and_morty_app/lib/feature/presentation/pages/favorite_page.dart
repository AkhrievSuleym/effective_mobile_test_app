import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/favorite_bloc.dart/bloc/favorite_bloc.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/character_card_widget.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/loading_widget.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite characters'),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: LoadingIcon());
          } else if (state is FavoritesLoaded) {
            final characters = state.characters;

            if (characters.isEmpty) {
              return const Center(
                child: Text(
                  'There is no favorite characters',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: characters.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final character = characters[index];
                return CharacterCard(
                  character: character,
                  isInitiallyFavorite: true,
                );
              },
            );
          } else if (state is FavoritesError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          return const Center(child: LoadingIcon());
        },
      ),
    );
  }
}
