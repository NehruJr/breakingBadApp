import 'package:breakingbad/data/models/characters.dart';
import 'package:breakingbad/data/models/quote.dart';
import 'package:breakingbad/data/web_services/characters_api.dart';

class CharactersRepository {

  Future<List<CharacterModel>> getCharacters () async{
    final characters = await CharactersApi().getCharacters();
    return characters.map((character) => CharacterModel.fromJson(character)
    ).toList();

  }

  Future<List<Quote>> getCharactersQuotes (String charName) async{
    final quotes = await CharactersApi().getCharactersQuotes(charName);
    return quotes.map((charQuotes) => Quote.fromJson(charQuotes)).toList();

  }

}