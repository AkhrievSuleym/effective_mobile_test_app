import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rick_and_morty_app/core/theme/app_pallete.dart';
import 'package:rick_and_morty_app/feature/data/models/hive_character_model.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/characters_bloc.dart/character_bloc.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/favorite_bloc.dart/bloc/favorite_bloc.dart';
import 'package:rick_and_morty_app/feature/presentation/widgets/character_card_widget.dart';
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

          if (favoritesState is FavoritesLoaded) {
            favoriteCharacters = favoritesState.characters;
          }

          return ListView.separated(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < characters.length) {
                final character = characters[index];
                final isFavorite =
                    favoriteCharacters.any((fav) => fav.id == character.id);
                return CharacterCard(
                  character: character,
                  isInitiallyFavorite: isFavorite,
                );
              } else {
                Timer(const Duration(milliseconds: 30), () {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                });
                return const LoadingIcon();
              }
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: AppPallete.greyColor,
              );
            },
            itemCount: characters.length + (isLoading ? 1 : 0),
          );
        },
      );
    });
  }
}
