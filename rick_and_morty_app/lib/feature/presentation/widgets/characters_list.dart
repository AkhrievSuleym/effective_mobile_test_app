import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rick_and_morty_app/core/theme/app_pallete.dart';
import 'package:rick_and_morty_app/feature/data/models/character_model.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/characters_bloc.dart/character_bloc.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/favorite_bloc.dart/bloc/favorite_bloc.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/cache_image_widget.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/loading_widget.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({super.key});

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  final scrollController = ScrollController();
  final Logger logger = Logger();

  int page = 1;

  @override
  void initState() {
    super.initState();
    setupScrollController();
    context.read<CharacterBloc>().add(GetCharactersEvent(page: page));
  }

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        final bloc = BlocProvider.of<CharacterBloc>(context);
        if (bloc.state is! CharacterLoading && mounted) {
          page++;
          bloc.add(GetCharactersEvent(page: page));
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
      List<CharacterModel> characters = [];
      bool isLoading = false;
      if (state is CharacterLoading && state.isFirstFetch) {
        return const LoadingIcon();
      } else if (state is CharacterLoading) {
        characters = state.oldCharactersList;
        isLoading = true;
      } else if (state is CharacterLoaded) {
        characters = state.characters;
      } else if (state is CharacterError) {
        return Text(
          state.message,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        );
      }
      return BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, favoritesState) {
          List<CharacterModel> favoriteCharacters = [];

          if (favoritesState is FavoritesLoading) {
            return const LoadingIcon();
          } else if (favoritesState is FavoritesLoaded) {
            favoriteCharacters = favoritesState.characters;
          } else if (favoritesState is FavoritesError) {
            return Center(
              child: Text(
                favoritesState.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            controller: scrollController,
            itemCount: characters.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < characters.length) {
                final character = characters[index];
                final isFavorite =
                    favoriteCharacters.any((fav) => fav.id == character.id);
                return Column(
                  children: [
                    Container(
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
                                        style: const TextStyle(
                                            color: Colors.white),
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
                              final favoritesBloc =
                                  context.read<FavoritesBloc>();

                              if (isFavorite) {
                                favoritesBloc
                                    .add(RemoveFavoriteEvent(character.id));
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
                    ),
                    const Divider(),
                  ],
                );
              } else {
                Timer(const Duration(milliseconds: 30), () {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                });
                return const LoadingIcon();
              }
            },
          );
        },
      );
    });
  }
}
