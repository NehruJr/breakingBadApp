class CharacterModel {
  late int charID;
  late String name;
  late String nickname;
  late String image;
  late List<dynamic> jobs;
  late String status;
  late String actorName;
  late String categoryForTwoSeries;
  late List<dynamic> bbSeasonsAppearance;
  late List<dynamic> saulSeasonsAppearance;

  CharacterModel.fromJson(Map<String , dynamic> json){
    charID = json["char_id"];
    name = json["name"];
    nickname = json["nickname"];
    image = json["img"];
    jobs = json["occupation"];
    status = json["status"];
    actorName = json["portrayed"];
    categoryForTwoSeries = json["category"];
    bbSeasonsAppearance = json["appearance"];
    saulSeasonsAppearance = json["better_call_saul_appearance"];

  }
}