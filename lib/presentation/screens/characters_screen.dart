import 'package:breakingbad/constants.dart';
import 'package:breakingbad/cubit/characters_cubit.dart';
import 'package:breakingbad/data/models/characters.dart';
import 'package:breakingbad/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {

  late List<CharacterModel> allCharacters;
  late List<CharacterModel> searchedCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField(){
    return TextField(
      controller: _searchTextController,
      cursorColor: greyColor,
      decoration: InputDecoration(
        hintText: 'Find a Character ...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: greyColor , fontSize: 18),
      ),
      style: TextStyle(color: greyColor , fontSize: 18),
      onChanged: (searchedCharacter){
        addSearchedItemsToList(searchedCharacter);
      },
    );
  }

  void addSearchedItemsToList(String searchedCharacter){
    searchedCharacters = allCharacters.where((character) => character.name.toLowerCase().startsWith(searchedCharacter)).toList();
  }

  List<Widget> _buildAppBarActions(){
    if(_isSearching){
      return [
        IconButton(onPressed: (){
        _clearSearch();
        Navigator.pop(context);
        }, icon: Icon(Icons.clear , color: greyColor,))
      ];
    }else{
      return [
        IconButton(onPressed: _startSearch, icon: Icon(Icons.search , color: greyColor,))
      ];
    }
  }

  void _startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
  setState(() {
    _isSearching = true;
  });
  }

  void _stopSearching(){
    _clearSearch();
    setState(() {
      _isSearching  = false;
    });
  }

  void _clearSearch(){
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget _buildAppBarTitle(){
    return Text('Characters' , style: TextStyle(color: greyColor),);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget(){
    return BlocBuilder<CharactersCubit , CharactersState>(builder: (context, state) {
    if (state is CharactersLoadedState){
      allCharacters = CharactersCubit.get(context).characters;
      return buildLoadedListWidget();
    }else{
      return Center(child: CircularProgressIndicator(color: yellowColor,),);
    }
    },);
  }

  Widget buildLoadedListWidget(){
    return SingleChildScrollView(
      child: Container(
        color: greyColor,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList(){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2/3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty? allCharacters.length : searchedCharacters.length,
        itemBuilder: (context, index) => CharactersItem(characterModel: _searchTextController.text.isEmpty?allCharacters[index]: searchedCharacters[index],));
  }

  Widget buildNoInternetWidget(){
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text('Please Check Your Internet Connection ...' , style: TextStyle(fontSize: 24 , color: greyColor),),
            Image.asset('assets/images/notConnected.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
        backgroundColor: yellowColor,
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: Center(child: CircularProgressIndicator(color: yellowColor,),),
      ),
    );
  }
}
