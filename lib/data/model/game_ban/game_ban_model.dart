part of model;

class GameBanModel extends GameBanEntity {

  GameBanModel({
    required int id,
    String? name,
    String? slug
  }) : super(
    id: id,
    name: name,
    slug: slug
  );

  factory GameBanModel.fromJson(Map<String, dynamic> json) {
    GameBanModel gameBanModel = GameBanModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
    return gameBanModel;
  }
}