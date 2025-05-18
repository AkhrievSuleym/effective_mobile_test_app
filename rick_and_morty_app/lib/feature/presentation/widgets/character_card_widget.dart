import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/theme/app_pallete.dart';
import 'package:rick_and_morty_app/feature/data/models/hive_character_model.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/favorite_bloc.dart/bloc/favorite_bloc.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/cache_image_widget.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;
  final bool isInitiallyFavorite;

  const CharacterCard({
    super.key,
    required this.character,
    this.isInitiallyFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        // Можно добавить обработку специфичных состояний
      },
      builder: (context, state) {
        // Определяем текущее состояние избранного
        final isFavorite = state is FavoritesLoaded
            ? state.characters.any((fav) => fav.id == character.id)
            : isInitiallyFavorite;

        return Container(
          decoration: BoxDecoration(
            color: AppPallete.backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              CharacterCacheImage(
                width: 166,
                height: 166,
                imageUrl: character.image,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      character.name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: character.status == 'Alive'
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${character.status} - ${character.species}',
                            style: const TextStyle(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.amber : Colors.white,
                  size: 38,
                ),
                onPressed: () {
                  final favoritesBloc = context.read<FavoritesBloc>();

                  if (isFavorite) {
                    favoritesBloc.add(RemoveFavoriteEvent(character.id));
                  } else {
                    favoritesBloc.add(UploadFavoriteEvent(
                      id: character.id,
                      name: character.name,
                      status: character.status,
                      species: character.species,
                      gender: character.gender,
                      image: character.image,
                    ));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
