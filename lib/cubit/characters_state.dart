part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoadedState extends CharactersState {}

class QuotesLoadedState extends CharactersState {
  final List<Quote> quotes;
  QuotesLoadedState(this.quotes);
}
