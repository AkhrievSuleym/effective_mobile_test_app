import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/favorite_bloc.dart/bloc/favorite_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Favorites')),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoritesError) {
            return Center(child: Text(state.message));
          }

          if (state is FavoritesLoaded) {
            return ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                final character = state.characters[index];
                return ListTile(
                  leading: Image.network(character.image),
                  title: Text(character.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.star, color: Colors.amber),
                    onPressed: () => context
                        .read<FavoritesBloc>()
                        .add(RemoveFavoriteEvent(character.id)),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
