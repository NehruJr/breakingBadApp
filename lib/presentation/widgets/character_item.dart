import 'package:breakingbad/constants.dart';
import 'package:breakingbad/data/models/characters.dart';
import 'package:flutter/material.dart';

class CharactersItem extends StatelessWidget {
  const CharactersItem({required this.characterModel});

  final CharacterModel characterModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, detailsScreen , arguments: characterModel),
        child: GridTile(
          child:  Hero(
            tag: characterModel.name,
            child: Container(
              color: greyColor,
              child: characterModel.image.isNotEmpty? FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                placeholder: 'assets/images/loading.gif',
                image:characterModel.image ,fit: BoxFit.cover, ): Image.asset('assets/images/placeholder.jpg'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text('${characterModel.name}', style: TextStyle(height: 1.3 ,fontSize: 16 , color: whiteColor , fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis, maxLines: 2,
            textAlign: TextAlign.center,),
          ),
        ),
      ),
    );
  }
}
