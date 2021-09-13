import 'package:bloc/bloc.dart';
import 'package:breakingbad/data/models/characters.dart';
import 'package:breakingbad/data/models/quote.dart';
import 'package:breakingbad/data/repository/characters_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  static CharactersCubit get(context) => BlocProvider.of(context);

  final CharactersRepository charactersRepository ;
  List<CharacterModel> characters = [];

  List<CharacterModel> getAllCharacters () {
     charactersRepository.getCharacters().then((characters) {
      this.characters = characters;
      emit(CharactersLoadedState());
    }
    );
    return characters;
  }


  void getQuotes (String charName) {
    charactersRepository.getCharactersQuotes(charName).then((charQuotes) {
      print('this ${charQuotes.toString()}');
      emit(QuotesLoadedState(charQuotes));
    }
    );}


}
