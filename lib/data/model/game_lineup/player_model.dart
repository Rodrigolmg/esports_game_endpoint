part of model;

class PlayerModel extends PlayerEntity {

  PlayerModel({
    required int id,
    String? firstName,
    String? lastName,
    String? name,
    String? shortName,
    String? slug,
    int? userCount
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    name: name,
    shortName: shortName,
    slug: slug,
    userCount: userCount
  );

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    PlayerModel playerModel = PlayerModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      name: json['name'],
      shortName: json['shortName'],
      slug: json['slug'],
      userCount: json['userCount'],
    );

    return playerModel;
  }
}