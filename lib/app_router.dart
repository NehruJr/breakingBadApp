import 'package:breakingbad/cubit/characters_cubit.dart';
import 'package:breakingbad/data/models/characters.dart';
import 'package:breakingbad/data/repository/characters_repository.dart';
import 'package:breakingbad/presentation/screens/character_details_screen.dart';
import 'package:breakingbad/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';

class AppRouter {

  late CharactersCubit charactersCubit;
  late CharactersRepository charactersRepository;

  AppRouter() {
    charactersRepository = CharactersRepository();
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (BuildContext context) => charactersCubit,
              child: CharactersScreen(),
            ));

      case detailsScreen :
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (BuildContext context) => CharactersCubit(charactersRepository),
              child: CharacterDetailsScreen(characterModel: character,),
            ));
    }
  }
}